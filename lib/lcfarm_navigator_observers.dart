import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/log_util.dart';

import 'base/navigator_manager.dart';

/// @desc:
/// @time 2019-09-20 09:55
/// @author mrliuys

class LcfarmNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    LogUtil.v("didPush router : $route |  previousRoute: $previousRoute");
    NavigatorManager().addRouter(route);

//      if (route.settings.name != null) {
//        //push 页面
//        NavigatorManager().addRouter(route.settings.name);
//      } else {
//        //push 弹窗
//
//      }

//    LogUtil.v("didPush history=${NavigatorManager().history}");
//    if ((route is TransitionRoute) && route.opaque) {
//      //全屏不透明，通常是一个page
//      LogUtil.v("全屏不透明，通常是一个page");
//    } else {
//      //全屏透明，通常是一个弹窗
//      LogUtil.v("全屏透明，通常是一个弹窗");
//    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    LogUtil.v("didPop router : $route |  previousRoute: $previousRoute");

    NavigatorManager().removeRouter(route);

//    LogUtil.v("didPop history=${NavigatorManager().history}");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    LogUtil.v("didRemove router : $route |  previousRoute: $previousRoute");

    NavigatorManager().removeRouter(route);

//    LogUtil.v("didRemove history=${NavigatorManager().history}");
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    LogUtil.v("didReplace router : $newRoute |  previousRoute: $oldRoute");

    NavigatorManager().replaceRouter(newRoute, oldRoute);

//    LogUtil.v("didReplace history=${NavigatorManager().history}");
  }
}
