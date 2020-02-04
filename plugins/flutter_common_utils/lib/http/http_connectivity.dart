import 'package:connectivity/connectivity.dart';

class CheckConnectivity {
  ///检测网络状态
  static Future<NetWorkStatus> checkNetWork() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());

    switch (result) {
      case ConnectivityResult.wifi:
        return NetWorkStatus.wifi;

      case ConnectivityResult.mobile:
        return NetWorkStatus.mobile;

      default:
        return NetWorkStatus.none;
    }
  }
}

enum NetWorkStatus { wifi, mobile, none }
