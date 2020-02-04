import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_common_utils/http/http_manager.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:lcfarm_flutter_umeng/lcfarm_flutter_umeng.dart';
import 'package:umeng_share/flutter_share.dart';
import 'package:wuhan/utils/string_util.dart';

import 'main_common.dart';
import 'using_proxy.dart';

Future<Null> main() async {
  await initConfig();
  //测试渠道
  await SpUtil().putString("target", "test");

 /* //测试环境用test
  LcfarmFlutterUmeng.init(
    iOSAppKey: "11111",
    androidAppKey: "11111",
    logEnable: true,
    encrypt: true,
  );*/

  ///     flutter build apk --flavor dev -t lib/dev.dart
  ///

  /*if (Platform.isAndroid) {
    UmengShare.registerQQWeChat(
        weChatAppId: '111',
        weChatSecret: '1111',
        qqAppId: '111',
        qqAppKey: '11111'
    );
  } else {
    UmengShare.registerQQWeChat(
        weChatAppId: "11",
        weChatSecret: "11",
        qqAppId: "111",
        qqAppKey: "111");
  }

  //初始化 bugly
  FlutterBugly.init(androidAppId: "11", iOSAppId: "111");*/

  //网络代理
  String proxyAddress =
      SpUtil().getString("proxyAddress") ?? "$localProxyIPAddress";
  String proxyPort = SpUtil().getString("proxyPort") ?? "$localProxyPort";

  if (!StringUtil.isEmpty(proxyAddress) && !StringUtil.isEmpty(proxyPort)) {
    //debug 抓包
    (HttpManager().client.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (client) {
      client.findProxy = (uri) {
        return "PROXY $proxyAddress:$proxyPort";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }
  initMaterialApp();
}

//Future<void> readFont(String path) async {
//  var fontLoader = FontLoader("Montserrat-Light");
//  fontLoader.addFont(getCustomFont(path));
//  await fontLoader.load();
//}
//
//Future<ByteData> getCustomFont(String path) async {
//  ByteData byteData = await rootBundle.load(path);
//  return byteData;
//}
