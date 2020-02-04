import 'package:flutter/material.dart';
import 'package:wuhan/common_bean/version_bean.dart';
import 'package:wuhan/utils/lcfarm_util.dart';
import 'package:wuhan/widget/lcfarm_bottom_sheet.dart';
import 'package:wuhan/widget/lcfarm_submit_dialog.dart';
import 'package:wuhan/widget/tips_confirm_dialog.dart';
import 'package:wuhan/widget/upgrade_dialog.dart';

import 'navigator_manager.dart';

/// @desc 弹窗 widget 统一创建类
/// @time 2019-11-06 09:42
/// @author chenyun
class DialogUtil {
  ///对话框提示显示
  ///[id] 同一对话框唯一标识
  static Widget createTipWidget(
    BuildContext context,
    String message, {
    String id,
    bool hasTips = true,
    bool canceled = true,
    String cancelText,
    String confirmText,
    OnCancelListener onCancelListener,
    OnConfirmListener onConfirmListener,
  }) {
    return WillPopScope(
        key: ValueKey(id ?? generateId("createTipWidget$message")),
        child: TipsConfirmDialog(
          message: message,
          hasTips: hasTips,
          cancelText: cancelText,
          confirmText: confirmText,
          hasCancelButton: canceled,
          onCancelListener: () {
            if (onCancelListener != null) {
              onCancelListener();
            } else {
              NavigatorManager().pop(context);
            }
          },
          onConfirmListener: () {
            if (onConfirmListener != null) {
              onConfirmListener();
            } else {
              NavigatorManager().pop(context);
            }
          },
        ),
        onWillPop: () async => canceled);
  }

  ///提交弹窗
  static Widget createSubmitDialog(
    BuildContext context, {
    String message,
    String id,
  }) {
    message ??= "正在提交...";
    return WillPopScope(
      key: ValueKey(id ?? generateId("createSubmitDialog")),
      onWillPop: () async => false,
      child: LcfarmSubmitDialog(
        text: message,
      ),
    );
  }

  ///升级对话框
  static Widget createUpgradeDialog(
    BuildContext context, {
    @required VersionBean versionBean,
    @required UpgradeCallback callback,
    CloseCallback closeCallback,
    String id,
  }) {
    return WillPopScope(
      key: ValueKey(id ??
          generateId(
              "createUpgradeDialog${versionBean.version}${versionBean.forceUpdate}")),
      onWillPop: () async => false,
      child: UpgradeDialog(
        versionBean,
        callback,
        closeCallback,
      ),
    );
  }

  ///android 下载对话框
  static Widget createDownloadDialog(
    BuildContext context, {
    @required StatefulBuilder statefulBuilder,
  }) {
    return WillPopScope(
      key: ValueKey(generateId("createDownloadDialog")),
      onWillPop: () async => false,
      child: statefulBuilder,
    );
  }


  ///创建底部弹窗
  static Widget createBottomSheet(
    BuildContext context, {
    List<LcfarmBottomSheetModel> bottomSheetModels,
    List<String> titleList,
    BottomSheetCallback callback,
    IndexedWidgetBuilder itemBuilder,
  }) {
    return LcfarmBottomSheet(
        key: ValueKey(generateId("createBottomSheet")),
        context: context,
        titleList: titleList,
        itemList: bottomSheetModels,
        itemListCallBack: callback,
        itemBuilder: itemBuilder,
    );
  }

  ///生成对话框 id
  static String generateId(String txt) {
    assert(txt != null);
    return LcfarmUtil.generateMd5(txt);
  }
}
