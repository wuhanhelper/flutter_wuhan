import 'package:flutter/material.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:wuhan/module/home/home.dart';
import 'package:wuhan/utils/string_util.dart';

import '../developer.dart';
import '../developerSDK.dart';
import '../flutter_text_example.dart';

/// @desc  所有路由管理,与原生路由保持一致，开头不能有/
/// @time 2019/3/19 4:07 PM
/// @author chenyun card
class Router {
  ///路由协议
  static const String scheme = "router://app.wuhan.com/";

  ///登录页
  static const String login = scheme + "login";

  ///首页
  static const String home = Router.scheme + "home";


  static Map<String, WidgetBuilder> init() {
    return {
      //这里不能传递参数
      Home.router: (context) => Home(),
      DeveloperSDK.router: (context) => DeveloperSDK(),
      Developer.router: (context) => Developer(),
      FlutterTextExample.router: (context) => FlutterTextExample(),
    };
  }

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    LogUtil.v("settings=$settings");
    switch (settings.name) {

    }
    return null;
  }

  static MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  ///取得 router 名字，不包含 scheme
  static String getName(String routerName) {
    if (StringUtil.isEmpty(routerName)) {
      return "";
    }
    return routerName.replaceAll(scheme, "");
  }

  ///校验
  static bool checkRouterUrl(String routerUrl) {
    return routerList.contains(routerUrl);
  }

  static const List<String> routerList = [
    Router.login,

  ];
}
