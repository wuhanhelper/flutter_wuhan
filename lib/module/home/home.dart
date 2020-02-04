import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/home_contract.dart';
import 'package:wuhan/module/home/home_presenter.dart';

/// @desc 首页主要框架展示
/// @time 2020/02/03 21:08
/// @author lizubing1992
class Home extends LcfarmWidget {
  ///路由
  static const String router = Router.scheme + "home";

  Home({Object arguments}) : super(arguments: arguments, routerName: router);

  @override
  LcfarmWidgetState getState() {
    return _HomeState();
  }
}

class _HomeState extends LcfarmWidgetState<Presenter, Home> implements View {
  @override
  Widget buildWidget(BuildContext context) {
    return Container();
  }
  @override
  void initState() {
    super.initState();
    hiddenAppbar();
  }

  @override
  void queryData() {
    showLoadSuccess();
  }

  @override
  Presenter createPresenter() {
    return HomePresenter();
  }
}
