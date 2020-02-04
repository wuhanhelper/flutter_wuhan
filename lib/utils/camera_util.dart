import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/utils/permissions_manager.dart';

import 'lcfarm_util.dart';

/// @desc:
/// @time 2019-06-21 08:52
/// @author mrliuys

class CameraUtil {
  ///flutter ios拍照有问题
  ///https://github.com/flutter/flutter/issues/32896
  ///context 页面上下文
  ///cameraCallBack 调用相机
  ///finishCallBack 调用相机之后返回的文件做事件处理
  static Future camera(
      {@required BuildContext context,
      @required final cameraCallBack,
      final finishCallBack}) {
    PermissionsManager.cameraPermission(context).then((bool isOpen) async {
      if (isOpen) {
        if (cameraCallBack != null) {
          if (Platform.isIOS) {
            LcfarmUtil.showSubmitDialog(context);
          }

          try {
            var object = await cameraCallBack();

            LogUtil.v("cameraCallBack ");
            LogUtil.v("cameraCallBack :${object.toString()}");

            if (Platform.isIOS) {
              NavigatorManager().pop(context);
            }
            if (finishCallBack != null && object != null) {
              finishCallBack(object);
            }
          } catch (e) {
            LogUtil.v("cameraCallBack catch");
            if (Platform.isIOS) {
              NavigatorManager().pop(context);
            }
          }

//          print("camera: " + object.toString());
//
//          if (object is Map && object["success"] != null) {
//            bool success = object["success"];
//            if (!success) {
//              String desc = object["description"] ?? "未知错误";
//
//              if (desc.contains("283504")) {
//                LcfarmUtil.makeToast("网络异常, 请重新拍照");
//              } else if (desc.contains("216202")) {
//                //图片大小错误
//                LcfarmUtil.makeToast("请对准证件边框重新拍照");
//              } else {
//                LcfarmUtil.makeToast('请对准证件边框重新拍照');
//              }
//            } else {
//              finishCallBack(object);
//            }
//          } else {
//            if (finishCallBack != null && object != null) {
//              finishCallBack(object);
//            }
//          }
        }
      }
    });
  }

  static Future photo(
      {@required BuildContext context,
      @required final cameraCallBack,
      final finishCallBack}) {
    PermissionsManager.photoPermission(context).then((bool isOpen) async {
      if (isOpen) {
        if (cameraCallBack != null) {
          if (Platform.isIOS) {
            LcfarmUtil.showSubmitDialog(context);
          }

          var iamge = await cameraCallBack();

          if (Platform.isIOS) {
            NavigatorManager().pop(context);
          }

          if (finishCallBack != null && iamge != null) {
            finishCallBack(iamge);
          }
        }
      }
    });
  }
}
