import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_common_utils/http/http_manager.dart';
import 'package:flutter_common_utils/http/lcfarm_log_interceptor.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mvp/view/abstract_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wuhan/lcfarm_navigator_observers.dart';
import 'package:wuhan/module/home/home.dart';
import 'package:wuhan/module/login/login_page.dart';
import 'package:wuhan/module/login/splash_page.dart';
import 'package:wuhan/widget/scale_text_widget.dart';

import 'base/api.dart';
import 'base/build_config.dart';
import 'base/const.dart';
import 'base/header_interceptor.dart';
import 'base/lcfarm_interceptor.dart';
import 'base/router.dart';
import 'chinese_cupertino_localizations.dart';
import 'utils/lcfarm_color.dart';
import 'utils/lcfarm_util.dart';

/// @desc 入口公共部分
/// @time 2019-07-17 15:08
/// @author chenyun
Future<Null> initConfig() async {

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //share preference 初始化
  await SpUtil().init();

  //日志输出
  if (BuildConfig.isDebug) {
    LogUtil.init(isDebug: true);
  }

  String tokenKey = await LcfarmUtil.generateTokenKey();

  await SpUtil().putString(Const.tokenKey, tokenKey);
}

///初始化 App
void initMaterialApp() {
  //初始化 Http，这里必须放在target 设置后面，因为 baseUrl 使用到了 target
  HttpManager().init(
    baseUrl: Api.getBaseUrl(),
    interceptors: [
      HeaderInterceptor(),
//      LcfarmLogInterceptor(),
      LcfarmInterceptor(),
    ],
  );

  // release模式下mediaQuery获取到的值为空，因此需要等待其返回正确结果时才渲染页面
//  TimerUtil timerUtil = TimerUtil(mInterval: 50);
//  timerUtil
//    ..setOnTimerTickCallback((int millisUntilFinished) {
//      var queryData = MediaQueryData.fromWindow(window);
//      if (queryData.size.width != 0) {
//        timerUtil.cancel();
//      } else {
//        print("waiting for MediaQueryData.fromWindow");
//      }
//    })
//    ..startTimer();

  ///开发模式不上传 bugly，上传 bugly将阻止 本地异常输出
  if (LcfarmUtil.isTest()) {
    _runApp();
  } else {
    FlutterBugly.postCatchedException(() {
      _runApp();
    });
  }

  //设置状态栏透明
  LcfarmUtil.setStatusBar(isTranslucent: true, isLight: true);
}

void _runApp() {
  runApp(OKToast(
    child: MaterialApp(
      navigatorObservers: [routeObserver, LcfarmNavigatorObserver()],
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        ChineseCupertinoLocalizations.delegate, // 这里加上这个,是自定义的delegate

        DefaultCupertinoLocalizations.delegate, // 这个截止目前只包含英文

        // 下面两个是Material widgets的delegate, 包含中文
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('zh', 'Hans'), // China
        const Locale('zh', ''), // China
        // ... other locales the app supports
      ],
      builder: (context, child) {
        return NoScaleTextWidget(
          child: child,
        );
      },
      theme: ThemeData(
        primaryColor: LcfarmColor.color3776E9,
        accentColor: LcfarmColor.color60000000,
      ),
      routes: Router.init(),
      onGenerateRoute: (RouteSettings settings) {
        return Router.onGenerateRoute(settings);
      },
      initialRoute: SplashPage.router,
    ),
  ));
}
