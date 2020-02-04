import 'dart:io';

import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:lcfarm_flutter_umeng/lcfarm_flutter_umeng.dart';
import 'package:umeng_share/flutter_share.dart';

import 'main_common.dart';

Future<Null> main() async {
  await initConfig();
  //设备地图初始化
//  FlutterAmapLocationPlugin.setApiKey("d941864736c971504eea57c202f6822d");

  //设置渠道
  await SpUtil().putString("target", "main");

  //正式环境用农发贷
  LcfarmFlutterUmeng.init(
      iOSAppKey: "1111",
      androidAppKey: "11111");

  ///友盟分享注册  放在init后面
  if (Platform.isAndroid) {
    UmengShare.registerQQWeChat(
        weChatAppId: '11',
        weChatSecret: '11',
        qqAppId: '11',
        qqAppKey: '11'

    );
  } else {

    UmengShare.registerQQWeChat(
        weChatAppId: "11",
        weChatSecret: "11",
        qqAppId: "11",
        qqAppKey: "11");
  }


  //初始化 bugly
  FlutterBugly.init(androidAppId: "1111", iOSAppId: "111");

  initMaterialApp();
}
