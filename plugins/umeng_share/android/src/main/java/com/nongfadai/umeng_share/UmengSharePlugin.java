package com.nongfadai.umeng_share;

import android.app.Activity;
import android.content.Intent;


import com.nongfadai.umeng_share.util.ShareUtil;
import com.nongfadai.umeng_share.widget.SharePopupWindow;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.UMShareAPI;


import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/** UmengSharePlugin */
public class UmengSharePlugin implements MethodCallHandler {

  private Activity mContext;

  private Result shareResult;


  /** Plugin registration. */
  public static void registerWith(final Registrar registrar) {

    registrar.addActivityResultListener(new PluginRegistry.ActivityResultListener() {
      @Override
      public boolean onActivityResult(int i, int i1, Intent intent) {

        Log.d("UMShareAPI "," i =" +i+" i1 = "+i1);
        //QQ分享回调生效
        UMShareAPI.get(registrar.activity()).onActivityResult(i, i1, intent);

        return false;
      }
    });

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "umeng_share");
    channel.setMethodCallHandler(new UmengSharePlugin(registrar.activity()));
  }

  public UmengSharePlugin(Activity context){
    this.mContext = context;
  }

  @Override
  public void onMethodCall(MethodCall call, final Result result) {
    if (call.method.equals("getPlatformVersion")) {

      result.success("Android " + android.os.Build.VERSION.RELEASE);

    } else if("openShareWindow".equals(call.method)){

      openShareWindow(call,result);

    }else if("registerQQWeChat".equals(call.method)){

      registerQQWeChat(call,result);

    } else {
      result.notImplemented();

    }
  }

  private void openShareWindow(MethodCall call,final Result result){
    String  shareType = call.argument("shareType");
    String  title = call.argument("title");
    String  content = call.argument("content");
    String  url = call.argument("url");
    String  shareImage = call.argument("shareImage");
    String  supportPlatform = call.argument("supportPlatform");

    shareResult = result;

    if("IMAGE".equals(shareType)){
      ShareUtil.setShareImage(mContext, shareImage, supportPlatform, new SharePopupWindow.OnShareListener() {
        @Override
        public void shareCallback(String platform) {
          shareResult.success(toJsonStr(platform,"success"));
        }
      });

    }else if("TEXT".equals(shareType)){
      ShareUtil.setShareContent(mContext, title, content, url, shareImage, supportPlatform, new SharePopupWindow.OnShareListener() {
        @Override
        public void shareCallback(String platform) {
          shareResult.success(toJsonStr(platform,"success"));
        }
      });
    }else{
      shareResult.success(toJsonStr("分享类型不支持","error"));
    }
  }

  private String toJsonStr(String msg,String status){
    return "{\"message\":" + msg + ",\"status\":" + status + "}";
  }


  private void registerQQWeChat(MethodCall call,final Result result){
    String  weChatAppId = call.argument("weChatAppId");
    String  weChatSecret = call.argument("weChatSecret");
    String  qqAppId = call.argument("qqAppId");
    String  qqAppKey = call.argument("qqAppKey");

    PlatformConfig.setWeixin(weChatAppId,weChatSecret);

    PlatformConfig.setQQZone(qqAppId,qqAppKey);

    result.success( null);
  }
}

