import 'package:flutter/material.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wuhan/base/build_config.dart';
import 'package:wuhan/base/dialog_bean.dart';
import 'package:wuhan/base/dialog_manager.dart';
import 'package:wuhan/base/dialog_util.dart';
import 'package:wuhan/base/navigator_manager.dart';

/// @desc:权限管理
/// @time 2019-06-14 15:19
/// @author mrliuys

class PermissionsManager {
  static Future<bool> contactPermission(BuildContext context) async {
    PermissionStatus contactPermissionStatus =
        await _getPermission(context, PermissionGroup.contacts);

    if (contactPermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对通讯录授权");
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> locationPermission(BuildContext context) async {
    PermissionStatus locationPermissionStatus =
        await _getPermission(context, PermissionGroup.location);

    if (locationPermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对定位授权");
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> checkLocationPermission(BuildContext context) async {
    return _checkPermission(context, PermissionGroup.location);
  }

  static Future<bool> cameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus =
        await _getPermission(context, PermissionGroup.camera);

    if (cameraPermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对相机授权");
      return false;
    } else {
      return true;
    }
  }

  ///电话权限
  static Future<bool> phonePermission(BuildContext context) async {
    if (BuildConfig.isIOS) {
      return true;
    }
    PermissionStatus cameraPermissionStatus =
        await _getPermission(context, PermissionGroup.phone);

    if (cameraPermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对电话授权");
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> photoPermission(BuildContext context) async {
    PermissionStatus photoPermissionStatus =
        await _getPermission(context, PermissionGroup.photos);

    if (photoPermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对相册授权");
      return false;
    } else {
      return true;
    }
  }

  ///外部存储SD卡权限
  static Future<bool> storagePermission(BuildContext context) async {
    if (BuildConfig.isIOS) {
      return true;
    }
    PermissionStatus storagePermissionStatus =
        await _getPermission(context, PermissionGroup.storage);

    if (storagePermissionStatus != PermissionStatus.granted) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对SD卡授权");
      return false;
    } else {
      return true;
    }
  }

  ///检查多个权限
  static Future<Map<PermissionGroup, PermissionStatus>> checkPermissions(
      List<PermissionGroup> permissions) async {
    Map<PermissionGroup, PermissionStatus> permissionStatusMap = Map();
    for (PermissionGroup permissionGroup in permissions) {
      PermissionStatus permission =
          await PermissionHandler().checkPermissionStatus(permissionGroup);
      if (permission != PermissionStatus.granted &&
          permission != PermissionStatus.disabled) {
        Map<PermissionGroup, PermissionStatus> permissionStatus =
            await PermissionHandler().requestPermissions([permissionGroup]);
        permissionStatusMap[permissionGroup] =
            permissionStatus[permissionGroup] ?? PermissionStatus.unknown;
      } else {
        permissionStatusMap[permissionGroup] = permission;
      }
    }

    return permissionStatusMap;
  }

  ///检查权限，并申请权限
  static Future<PermissionStatus> _getPermission(
      BuildContext context, PermissionGroup permissionGroup) async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(permissionGroup);

//    LogUtil.v("permission $permissionGroup=$permission");
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
//      bool b = await PermissionHandler()
//          .shouldShowRequestPermissionRationale(permissionGroup);
////      LogUtil.v(
////          "permission $permissionGroup shouldShowRequestPermissionRationale=$b");
//
//      if (b) {
      //表明用户没有彻底禁止弹出权限请求
      //&& permission != PermissionStatus.disabled，加上这个判断后，禁止后不能重新弹出，不加上这个判断，就会有下面的问题，一直调 onForeground
      //解决系统权限申请弹窗与自定义设置弹窗覆盖问题。当申请权限不允许时，弹出自定义设置弹窗，同时在 oppo 上会调用 onForeground,重新又会申请权限，所以出现

      Map<PermissionGroup, PermissionStatus> permissionStatus = {};
      //显示系统弹窗，回收其它弹窗
      DialogManager().showSystemDialog(context);
      //try catch以防插件 result.error
      try {
        permissionStatus =
            await PermissionHandler().requestPermissions([permissionGroup]);
      } catch (e) {
        LogUtil.v(e);
      }
      //隐藏指纹弹窗，显示其它弹窗
      DialogManager().dismissSystemDialog(context);
      return permissionStatus[permissionGroup] ?? PermissionStatus.unknown;
//      } else {
//        //表明用户已经彻底禁止弹出权限请求
//        //   PermissionMonitorService.start(this);//这里一般会提示用户进入权限设置界面
//        return PermissionStatus.denied;
//      }
    } else {
      return permission;
    }
  }

  static Future<bool> _checkPermission(
      BuildContext context, PermissionGroup permissionGroup) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
//    LogUtil.v("permission=$permission");
    //在魅族手机上，允许权限后还是PermissionStatus.disabled
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      showAppSetDialog(context, "为了保证“农金普惠”的正常使用，请对定位授权");
      return false;
    } else {
      return true;
    }
  }

  static void showAppSetDialog(BuildContext context, String message) {
    DialogManager()
      ..add(DialogBean(
          dialogPriority: DialogPriority.high,
          createDialogWidget: () => DialogUtil.createTipWidget(
                context,
                message,
                canceled: false,
                hasTips: false,
                onConfirmListener: () async {
                  NavigatorManager().pop(context);
                  await PermissionHandler().openAppSettings();
                },
                confirmText: "去开启",
              )))
      ..show(context);
  }
}
