import 'dart:convert';
import 'dart:io';

import 'package:city_pickers/city_pickers.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/date_util.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:flutter_status_bar_light/flutter_status_bar_light.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:wuhan/base/build_config.dart';
import 'package:wuhan/base/const.dart';
import 'package:wuhan/base/dialog_bean.dart';
import 'package:wuhan/base/dialog_manager.dart';
import 'package:wuhan/base/dialog_util.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/utils/string_util.dart';
import 'package:wuhan/widget/lcfarm_bottom_sheet.dart';
import 'package:wuhan/widget/lcfarm_input.dart';
import 'package:wuhan/widget/tips_confirm_dialog.dart';

import 'aes_util.dart';
import 'encrypt_util.dart';
import 'lcfarm_color.dart';
import 'lcfarm_style.dart';

/// @desc: 共用工具类
/// @time 2019/3/20 8:50 AM
/// @author chenyun
class LcfarmUtil {
  ///是否 iphoneX
  static bool iPhoneX() {
    return BuildConfig.isIOS && LcfarmSize.bottomBarHeight > 0;
  }

  ///退出应用
  static void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }


  ///生成当前唯一标识
  static Future<String> generateTokenKey() async {
    String deviceID = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (BuildConfig.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.androidId;
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor;
    }
    return generateMd5("$deviceID${DateTime.now().microsecondsSinceEpoch}");
  }

  ///获取当前唯一标识
  static String getTokenKey() {
    return SpUtil().getString(Const.tokenKey);
  }

  ///获取当前时间戳
  static String uuid() {
    return "${DateTime.now().microsecondsSinceEpoch}";
  }

  /// md5 加密
  static String generateMd5(String data) {
    var content = Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  ///设置 android 状态栏透明及状态栏图标，IOS flutter 已内置，直接设置 appbar [brightness] [backgroundColor]
  static void setStatusBar({bool isTranslucent = false, bool isLight = false}) {
    if (isTranslucent) {
      FlutterStatusBarLight.setTranslucent();
    }
    if (isLight) {
      FlutterStatusBarLight.setLightStatusBar();
    }
  }

  ///正则表达式判断密码字符
  static bool validatePassword(String password) {
//    return !(RegExp('[0-9]+').hasMatch(password) ||
//        RegExp('[a-z]+').hasMatch(password) ||
//        RegExp('[A-Z]+').hasMatch(password) ||
//        RegExp(r'[\W_]+').hasMatch(password) ||
//        RegExp(r'\s+').hasMatch(password));
    ///至少为字母、数字、符号两种组成，不包含空格,不能输入中文
    //[A-Za-z]+$ 表示字符串是由大写字母和小写字母组成
    //![A-Za-z]+$ 表示字符串不全是大写字母和小写字母组成
    //(?![A-Za-z]+$)表示如果从当前匹配位置开始到结尾是一个不全是大写字母和小写字母组成的字符串，就匹配，否则匹配位置保持不变，执行接下来的表达式
    //
    return RegExp(
            r'((?=.*\d)(?=.*\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))(?!^.*[\u4E00-\u9FA5].*$)^\S{6,22}$')
        .hasMatch(password);
  }

  ///正则表达式判断密码字符
  static bool validateEmail(String eamilStr) {
//    return !(RegExp('[0-9]+').hasMatch(password) ||
//        RegExp('[a-z]+').hasMatch(password) ||
//        RegExp('[A-Z]+').hasMatch(password) ||
//        RegExp(r'[\W_]+').hasMatch(password) ||
//        RegExp(r'\s+').hasMatch(password));
    ///至少为字母、数字、符号两种组成，不包含空格,不能输入中文
    //[A-Za-z]+$ 表示字符串是由大写字母和小写字母组成
    //![A-Za-z]+$ 表示字符串不全是大写字母和小写字母组成
    //(?![A-Za-z]+$)表示如果从当前匹配位置开始到结尾是一个不全是大写字母和小写字母组成的字符串，就匹配，否则匹配位置保持不变，执行接下来的表达式
    //
    return RegExp(
            r'^([a-z0-9A-Z]+[-|_|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$')
        .hasMatch(eamilStr);
  }

  ///取消 toast
  static void cancelToast() {
    dismissAllToast();
  }

  ///toast 提示
  static void makeToast(String message) {
    //先取消再显示最新的
    if (StringUtil.isEmpty(message)) {
      return;
    }

    message = message.replaceAll("<br/>", "\n");

    showToast(
      message,
      duration: Duration(seconds: 2),
      position: ToastPosition.center,
      textPadding: EdgeInsets.all(10.0),
      backgroundColor: LcfarmColor.color60000000,
      radius: 10.0,
      textStyle: TextStyle(fontSize: 14.0),
      dismissOtherToast: true,
    );
  }

  ///已经登录过
  static bool hasLoggedIn() {
    return !StringUtil.isEmpty(SpUtil().get(Const.token));
  }

  ///对话框提示显示
  static void showTipDialog<T>(
    BuildContext context,
    String message, {
    bool hasTips = true,
    bool canceled = true,
    String cancelText,
    String confirmText,
    OnCancelListener onCancelListener,
    OnConfirmListener onConfirmListener,
  }) {
    DialogManager()
      ..add(DialogBean(
        createDialogWidget: () => DialogUtil.createTipWidget(
          context,
          message,
          hasTips: hasTips,
          cancelText: cancelText,
          confirmText: confirmText,
          canceled: canceled,
          onCancelListener: onCancelListener,
          onConfirmListener: onConfirmListener,
        ),
      ));
    DialogManager().show(context);
  }

  ///显示修改对话框
  static Future<String> showEditDialog(
    BuildContext context,
    String message, {
    @required TextEditingController controller,
    String cancelText,
    String confirmText,
    OnCancelListener onCancelListener,
    OnConfirmListener onConfirmListener,
  }) {
    return showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: LcfarmColor.color00000000,
            body: WillPopScope(
                child: TipsConfirmDialog(
                  message: message,
                  hasTips: false,
                  cancelText: cancelText,
                  confirmText: confirmText,
                  hasCancelButton: true,
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
                  explainWidget: Container(
                    decoration: BoxDecoration(
                      color: LcfarmColor.colorF7F8FA,
                      borderRadius:
                          BorderRadius.all(Radius.circular(LcfarmSize.dp(8))),
                    ),
                    margin: EdgeInsets.only(
                        left: LcfarmSize.dp(20),
                        right: LcfarmSize.dp(20),
                        top: LcfarmSize.dp(20)),
                    padding: EdgeInsets.only(
                        left: LcfarmSize.dp(10), right: LcfarmSize.dp(10)),
                    child: LcfarmInput(
                      hint: "请输入登录密码",
                      hitStyle: LcfarmStyle.style24000000_16,
                      obscureText: true,
                      controller: controller,
                      isShowBottomSeparator: false,
                    ),
                  ),
                ),
                onWillPop: () async => false),
          );
        });
  }

  ///显示提交对话框,禁止物理返回
  static void showSubmitDialog<T>(BuildContext context,
      {String message, String dialogId}) {
    DialogManager()
      ..add(DialogBean(
        dialogPriority: DialogPriority.high,
        createDialogWidget: () => DialogUtil.createSubmitDialog(
          context,
          message: message,
        ),
      ));
    DialogManager().show(context);
  }

  ///显示底部选择器
  static void showBottomSheet<T>(
    BuildContext context, {
    List<LcfarmBottomSheetModel> bottomSheetModels,
    List<String> titleList,
    BottomSheetCallback callback,
    IndexedWidgetBuilder itemBuilder,
  }) {
    DialogManager()
      ..add(DialogBean(
        dialogType: DialogType.bottomSheet,
        createDialogWidget: () => DialogUtil.createBottomSheet(
          context,
          bottomSheetModels: bottomSheetModels,
          titleList: titleList,
          callback: callback,
          itemBuilder: itemBuilder,
        ),
      ));
    DialogManager().show(context);
  }

  ///通过定位获取地址
  static Future<Result> getCityFormLocation() async {
    Result result = Result();

    String _province = SpUtil().getString(Const.province);
    String _city = SpUtil().getString(Const.city);
    String _district = SpUtil().getString(Const.district);

    String data = await loadAddressAsset();

    List<CityPoint> listBean = [];

    for (var dataItem in json.decode(data)) {
      listBean.add(dataItem == null ? null : CityPoint(dataItem));
    }

    CityPoint provincePoint = listBean.firstWhere(
        (province) => _province == province.label,
        orElse: () => null);

    if (provincePoint == null) {
      provincePoint = listBean[0];
    }

    CityPoint cityPoint = provincePoint.children
        .firstWhere((city) => _city == city.label, orElse: () => null);

    if (cityPoint == null) {
      cityPoint = provincePoint.children[0];
    }

    CityPoint areaPoint = cityPoint.children
        .firstWhere((area) => _district == area.label, orElse: () => null);

    if (areaPoint == null) {
      areaPoint = cityPoint.children[0];
    }

    result.provinceName = provincePoint.label;
    result.provinceId = provincePoint.value;
    result.cityName = cityPoint.label;
    result.cityId = cityPoint.value;
    result.areaName = areaPoint.label;
    result.areaId = areaPoint.value;

    return result;
  }

  ///显示底部选择器
  static Future<Result> showCityPickerBottomSheet(BuildContext context,
      {Result initDataResult}) async {
    Result result;

    await loadAddressAsset().then((data) async {
      List<CityPoint> listBean = [];

      for (var dataItem in json.decode(data)) {
        listBean.add(dataItem == null ? null : CityPoint(dataItem));
      }

      result = await CityPickers.showCityPicker2(
          context: context,
          provinceCityAreaList: listBean,
          height: 300,
          initDataResult: initDataResult);

      LogUtil.v("showCityPickerBottomSheet:" + (result.toString()));
    });

    return result;
  }

  static Future<String> loadAddressAsset() async {
    return await rootBundle.loadString('res/json/address.json');
  }

  ///是否测试环境
  static bool isTest() {
    return "test" == SpUtil().getString("target");
  }

  static String getOCRDecrypt(String data) {
    if (isTest()) {
      return AESUtil.decryptBase64('njq/dev@20150315', data);
    } else {
      return AESUtil.decryptBase64('njq/prd#(&^@2015', data);
    }
  }

  ///取得当前时间戳
  static int getNowDateMilliseconds() {
    int syncTimeDiff = SpUtil().getInt(Const.syncTimeDiff);
    return DateUtil.getNowDateMilliseconds() + syncTimeDiff ?? 0;
  }

  ///取加星电话号码
  static String getStarPhone({String phone}) {
    if (phone == null) {
      phone = SpUtil().get(Const.username) ?? "";
    }
    if (phone != "") {
      phone = phone.replaceRange(3, 7, "****");
    }
    return phone;
  }

  ///取得当前版本
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  ///取得当前包信息
  static Future<String> getPackageName() async {
    //包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  ///获取公共 header 信息
  static Future<Map<String, Object>> getHeaders() async {
    //包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String sourceVersion = "";
    String deviceID = "";
    if (BuildConfig.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.androidId;
      sourceVersion =
          "${androidDeviceInfo.manufacturer} ${androidDeviceInfo.model}"
          "/${androidDeviceInfo.version.release}"
          "/${LcfarmSize.screenWidthPx}x${LcfarmSize.screenHeightPx}"
          "/${LcfarmSize.textScaleFactory}";
    } else if (BuildConfig.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor;
      sourceVersion = "${iosDeviceInfo.utsname.machine}"
          "/${iosDeviceInfo.systemVersion}"
          "/${LcfarmSize.screenWidthPx}x${LcfarmSize.screenHeightPx}"
          "/${LcfarmSize.textScaleFactory}";
    }

    int syncTimeDiff = SpUtil().getInt(Const.syncTimeDiff) ?? 0;
//    LogUtil.v("syncTimeDiff=$syncTimeDiff");
//    LogUtil.v("syncTimeDiff nowTime=${DateUtil.getNowDateMilliseconds()}");
//    LogUtil.v(
//        "syncTimeDiff syncTime=${DateUtil.getNowDateMilliseconds() + syncTimeDiff}");
    String sign = await EncryptUtil.encode(
        "${DateUtil.getNowDateMilliseconds() + syncTimeDiff}com.nongfadai.kappa.app$deviceID");
    return {
      'loginSource': Platform.operatingSystem,
      'sourceVersion': Uri.encodeFull(sourceVersion),
      'deviceID': deviceID,
      'bundleId': packageInfo.packageName,
      'useVersion': packageInfo.version,
      'longitude': SpUtil().getDouble(Const.longitude),
      'latitude': SpUtil().getDouble(Const.latitude),
      'sign': sign,
      'Authorization': SpUtil().get(Const.token),
    };
  }

  ///用来保存到sp里面。 跟用户关联
  static String getSpUtilKeyByAccount(String key) {
    String accountStr = SpUtil().get(Const.username);

    if (StringUtil.isEmpty(accountStr)) {
      return key;
    }
    return "$accountStr$key";
  }

  static Color colorFromHex(String hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return null;
    }
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }
}
