import 'dart:io';

/// @desc  系统构建参数配置
/// @time 2019/4/15 9:55 AM
/// @author chenyun
class BuildConfig {
  static bool isDebug = !bool.fromEnvironment("dart.vm.product");
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;
}
