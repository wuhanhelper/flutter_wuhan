import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/module/home/homepage/homepage_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_presenter.dart';

/// @desc 首页
/// @time 2020/02/04 20:50
/// @author lizubing1992
class Homepage extends LcfarmWidget {
  Homepage({Object arguments})
      : super(arguments: arguments, routerName: "Homepage");

  @override
  LcfarmWidgetState getState() {
    return _HomepageState();
  }
}

class _HomepageState extends LcfarmWidgetState<Presenter, Homepage>
    implements View {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("首页"),
    );
  }

  @override
  void initState() {
    //必须要在 super.initState前调用
    innerPager(true);
    super.initState();
    hiddenAppbar();
  }

  @override
  void queryData() {
    disabledLoading();
  }

  @override
  Presenter createPresenter() {
    return HomepagePresenter();
  }
}
