import 'package:flutter/material.dart';
import 'package:flutter_common_utils/log_util.dart';

import 'dialog_bean.dart';
import 'dialog_manager.dart';
import 'lcfarm_widget.dart';

typedef OnInterceptor = Function(bool isInterceptor);

/// @desc 导航管理
/// @time 2019-05-29 09:51
/// @author chenyun
class NavigatorManager {
  //todo 无法关闭指定的页面

  //push 将设置的router信息推送到Navigator上，实现页面跳转。
  //of 主要是获取 Navigator最近实例的好状态。
  //pop 导航到新页面，或者返回到上个页面。
  //canPop 判断是否可以导航到新页面
  //maybePop 可能会导航到新页面
  //popAndPushNamed 指定一个路由路径，并导航到新页面。
  //popUntil 反复执行pop 直到该函数的参数predicate返回true为止。
  //pushAndRemoveUntil 将给定路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
  //pushNamed 将命名路由推送到Navigator。
  //pushNamedAndRemoveUntil 将命名路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
  //pushReplacement 路由替换。
  //pushReplacementNamed 这个也是替换路由操作。推送一个命名路由到Navigator，新路由完成动画之后处理上一个路由。
  //removeRoute 从Navigator中删除路由，同时执行Route.dispose操作。
  //removeRouteBelow 从Navigator中删除路由，同时执行Route.dispose操作，要替换的路由是传入参数anchorRouter里面的路由。
  //replace 将Navigator中的路由替换成一个新路由。
  //replaceRouteBelow 将Navigator中的路由替换成一个新路由，要替换的路由是是传入参数anchorRouter里面的路由。

  ///视图栈，在 init 加入，dispose 移除。
  List<LcfarmWidgetState> _widgetStack;

  ///所有路由栈，包括弹窗与页面
  List<Route> _history;

  static final NavigatorManager _instance = NavigatorManager._internal();

  factory NavigatorManager() => _instance;

  NavigatorManager _bus;

  NavigatorManager._internal() {
    if (_bus == null) {
      _widgetStack = List<LcfarmWidgetState>();
      _history = List<Route>();
    }
  }

  ///加入栈
  void addWidget(LcfarmWidgetState widget) {
//    widgetName.didPopRoute();
//    widgetName.dispose();
    _widgetStack.add(widget);
  }

  ///从栈中移除
  void removeWidget(LcfarmWidgetState widget) {
    _widgetStack.remove(widget);
  }

  ///通过拦截器增加 push router
  void addRouter(Route route) {
    _history.add(route);
  }

  ///通过拦截器移动 push router
  void removeRouter(Route route) {
    _history.remove(route);
  }

  ///通过拦截器移动 push router
  void replaceRouter(Route newRoute, Route oldRoute) {
    _history.remove(oldRoute);
    _history.add(newRoute);
  }

  List<Route> get history => _history;

//  ///是否当前显示的页面
//  bool isCurrentWidget(LcfarmWidgetState widget) {
//    if (_widgetStack.isEmpty) {
//      return false;
//    }
//    return widget.getClassName() ==
//        _widgetStack[_widgetStack.length - 1].getClassName();
//  }

  ///取得 widget
  LcfarmWidgetState getWidget(String routerName) {
    LcfarmWidgetState widgetState;
    //从后面往前找，找到对应 routerName 对象
    for (int i = _widgetStack.length - 1; i >= 0; i--) {
      widgetState = _widgetStack[i];
      if (widgetState.getClassName() == routerName) {
        break;
      }
    }
    return widgetState;
  }

  ///是否顶层路由为页面，或者还未显示，正在压入栈
  bool isTopRouter(String routerName) {
    if (_history.isEmpty) {
      return false;
    }
    int i = _history.length - 1;
    Route route = _history[i];
    while (route.settings == null && i >= 0) {
      i--;
      route = _history[i];
    }
    return route.settings.name != null && route.settings.name == routerName;
  }

  ///是否顶层路由为弹窗(包括showBottomSheet)，或者还未显示，正在压入栈
  bool isTopDialog() {
    if (_history.isEmpty) {
      return false;
    }
    return _history[_history.length - 1].settings.name == null;
  }

  void finishWidget(BuildContext context, String route) {
    if (hasRouter(route)) {
      int index = _getIndexByRouter(route);
      LogUtil.v("index=${_widgetStack[index].getClassName()}");

//      ModalRoute.of(context).
//      pop(_widgetStack[index].context);

//      ModalRoute.of(_widgetStack[index].context).dispose();
//      Navigator.removeRoute(
//          context, MaterialPageRoute(builder: (context) => BankAccount()));
    }
  }

  int _getIndexByRouter(String router) {
    int index = 0;
    for (LcfarmWidgetState widget in _widgetStack) {
      if (widget.getClassName() == router) {
        break;
      }
      index++;
    }
//    List<String> classNames=_widgetStack.map((widget)=>widget.getClassName()).toList();
    return index;
  }

  ///取得此路由的前一个路由
  String _getPreRouter(String routerName) {
    int index = _getIndexByRouter(routerName);
    if (index > 0) {
      return _widgetStack[index - 1].getClassName();
    }
    return routerName;
  }

  ///是否栈中已包含此路由
  bool hasRouter(String router) {
    bool b = false;
    for (LcfarmWidgetState widget in _widgetStack) {
//      LogUtil.v("widget className=${widget.getClassName()}");
      if (widget.getClassName() == router) {
        b = true;
        break;
      }
    }
    return b;
  }

  ///跳转新页面
  Future<T> pushNamed<T extends Object>(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    if (_pushInterceptor(context, routeName)) {
      return null;
    }
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  ///在当前页面跳转，替换当前页面
  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    if (_pushInterceptor(context, routeName)) {
      return null;
    }
    return Navigator.pushReplacementNamed(context, routeName,
        result: result, arguments: arguments);
  }

  ///跳转页面newRouteName及至predicate为 true
  Future<T> pushNamedAndRemoveUntil<T extends Object>(
    BuildContext context,
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) {
    if (_pushInterceptor(context, newRouteName)) {
      return null;
    }
    return Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate,
        arguments: arguments);
  }

  ///销毁当前页面并跳转指向新的页面
  Future<T> popAndPushNamed<T extends Object, TO extends Object>(
    BuildContext context,
    String routeName, {
    TO result,
    Object arguments,
  }) {
    if (_pushInterceptor(context, routeName)) {
      return null;
    }
    return Navigator.popAndPushNamed(context, routeName,
        result: result, arguments: arguments);
  }

  ///销毁当前页面
  bool pop<T extends Object>(BuildContext context, [T result]) {
    if (_popInterceptor(context)) {
      return false;
    }
    return Navigator.pop(context, result);
  }

//  ///销毁页面router,且回收弹窗
//  bool popWithRouterAndRecycleDialog<T extends Object>(
//      BuildContext context, String router,
//      [T result]) {
//    if (_popInterceptor(context)) {
//      return false;
//    }
//    if (isTopDialog()) {}
//    return pop(context, result);
//  }

  ///销毁页面,直至 router,包含 router
  void popUntilWithRouter(BuildContext context, String router) {
    if (_popInterceptor(context)) {
      return;
    }
    return popUntil(context, ModalRoute.withName(_getPreRouter(router)));
  }

  ///销毁页面,直至 predicate里路由页面，不包括，
  void popUntil(BuildContext context, RoutePredicate predicate) {
    if (_popInterceptor(context)) {
      return;
    }
    return Navigator.popUntil(context, predicate);
  }

  ///push 拦截
  ///返回 true 后续不执行，false 后续继续执行
  bool _pushInterceptor(BuildContext context, String routerName) {
    DialogBean dialogBean = DialogManager().getShowingDialog();
    //强制升级、或者多终端登录（highClear），不打开新页面
    if (dialogBean != null && dialogBean.isHighClear()) {
      return true;
    }

    if (isTopRouter(routerName)) {
      //已经 push过了，则不重新 push
      return true;
    }
    return false;
  }

  ///pop 拦截
  ///返回 true 后续不执行，false 后续继续执行
  bool _popInterceptor(BuildContext context) {
    return false;
  }
}
