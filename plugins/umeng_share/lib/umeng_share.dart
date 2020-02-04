import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:umeng_share/share_menus.dart';

typedef ShareCallback = void Function(String sharePlatform);

class UmengShare {
  static const MethodChannel _channel = MethodChannel('umeng_share');

  static const bool isProduct = bool.fromEnvironment("dart.vm.product");

  static Future<String> openShareWindow(ShareMenus shareMenus,
      {ShareCallback callback}) async {

    assert(shareMenus != null);

    if (!isProduct) {
      print("${shareMenus.toString()}");
    }

    final String resultJson =
    await _channel.invokeMethod('openShareWindow', shareMenus.toShareMap());

    if (callback != null) {
      callback(resultJson);
    }

    return resultJson;
  }


  ///
  /// 注册分享平台  QQ 微信
  ///
  static Future<void> registerQQWeChat({@required String weChatAppId,
    @required String weChatSecret,
    @required String qqAppId,
    @required String qqAppKey,
    String shareDefaultUrl = "https://mp.nongfadai.com"}) async {
    await _channel.invokeMethod('registerQQWeChat', {
      'weChatAppId': weChatAppId,
      'weChatSecret': weChatSecret,
      'qqAppId': qqAppId,
      'qqAppKey': qqAppKey,
      'shareDefaultUrl' : shareDefaultUrl,
    });
  }

}
