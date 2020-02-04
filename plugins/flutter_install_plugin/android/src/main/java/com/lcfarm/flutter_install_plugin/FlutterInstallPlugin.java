package com.lcfarm.flutter_install_plugin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import androidx.core.content.FileProvider;
import android.util.Log;

import java.io.File;
import java.io.FileNotFoundException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterInstallPlugin */
public class FlutterInstallPlugin implements MethodCallHandler {

  private static final  int installRequestCode = 1001;

  private Registrar register;

  private File apkFile;
  private String appId;

  public FlutterInstallPlugin(final Registrar register) {
    this.register = register;
    register.addActivityResultListener(new PluginRegistry.ActivityResultListener() {
      @Override
      public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (resultCode == Activity.RESULT_OK && requestCode == installRequestCode) {
          install24(register.context(), apkFile, appId);
          return true;
        }
        return false;
      }
    });

  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_install_plugin");
    channel.setMethodCallHandler(new FlutterInstallPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("installApk")) {
      String filePath=call.argument("filePath");
      String appId=call.argument("appId");

      try {
        installApk(filePath, appId);
        result.success("Success");
      } catch (Exception e) {
        result.error(e.getClass().getSimpleName(),e.getMessage(),null);
      }
    } else {
      result.notImplemented();
    }
  }

  private void installApk(String filePath, String appId) throws Exception {
    if (filePath == null){
      throw new NullPointerException("fillPath is null!");
    }
    Activity activity=register.activity();
    if(register.activity()==null){
      throw new NullPointerException("context is null!");
    }

    File file = new File(filePath);

    if (!file.exists()) {
      throw new FileNotFoundException("filePath is not exist! or check permission");
    }
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      if (canRequestPackageInstalls(activity)){
        install24(activity, file, appId);
      } else {
        showSettingPackageInstall(activity);
        this.apkFile = file;
        this.appId = appId;
      }
    } else {
      installBelow24(activity, file);
    }
  }

  /**
   * 8.0以上打开权限设置
   * @param activity
   */
  private void showSettingPackageInstall(Activity activity) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      Log.d("SettingPackageInstall", ">= Build.VERSION_CODES.O");
      Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES);
      intent.setData(Uri.parse("package:" + activity.getPackageName())) ;
      activity.startActivityForResult(intent, installRequestCode);
    } else {
      throw  new RuntimeException("VERSION.SDK_INT < O");
    }

  }

  private Boolean canRequestPackageInstalls(Activity activity ) {
    return Build.VERSION.SDK_INT <= Build.VERSION_CODES.O || activity.getPackageManager().canRequestPackageInstalls();
  }

  ///安装
  private void installBelow24(Context context, File file) {
    Intent intent =new  Intent(Intent.ACTION_VIEW);
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    Uri uri = Uri.fromFile(file);
    intent.setDataAndType(uri, "application/vnd.android.package-archive");
    context.startActivity(intent);
  }

  /**
   * android24及以上安装需要通过 ContentProvider 获取文件Uri，
   * 需在应用中的AndroidManifest.xml 文件添加 provider 标签，
   * 并新增文件路径配置文件 res/xml/provider_path.xml
   * 在android 6.0 以上如果没有动态申请文件读写权限，会导致文件读取失败，你将会收到一个异常。
   * 插件中不封装申请权限逻辑，是为了使模块功能单一，调用者可以引入独立的权限申请插件
   */
  private void install24(Context context,File file,String appId) {
    if (context == null) {
      throw new NullPointerException("context is null!");
    }
    if (file == null){
      throw new NullPointerException("file is null!");
    }
    if (appId == null) {
      throw new NullPointerException("appId is null!");
    }
    Intent intent = new Intent(Intent.ACTION_VIEW);
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
    Uri uri= FileProvider.getUriForFile(context, appId+".fileProvider.install", file);
    intent.setDataAndType(uri, "application/vnd.android.package-archive");
    context.startActivity(intent);
  }
}
