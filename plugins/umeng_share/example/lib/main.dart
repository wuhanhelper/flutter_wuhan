import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:umeng_share/umeng_share.dart';
import 'package:umeng_share/share_menus.dart';

void main() {
// QQ
// AppID: 1109951354
// APPKEY: hAwJRunCQc3l5uRo
// weixin
// AppID：  wx48675ca2c13952e2
// AppSecret : 8e5063010241278b92c413359fb933e1
  UmengShare.registerQQWeChat(
      weChatAppId: "wx48675ca2c13952e2",
      weChatSecret: "8e5063010241278b92c413359fb933e1",
      qqAppId: "1109951354",
      qqAppKey: "hAwJRunCQc3l5uRo");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: GestureDetector(
          onTap: () {
            ShareMenus shareMenus = ShareMenus.textMenus(
                title: "hello",
                content: "content",
                url:
                    "https://www.baidu.com/img/superlogo_c4d7df0a003d3db9b65e9ef0fe6da1ec.png?where=super");
            UmengShare.openShareWindow(shareMenus);
          },
          behavior: HitTestBehavior.translucent,
          child: Text('点击分享'),
        )),
      ),
    );
  }
}
