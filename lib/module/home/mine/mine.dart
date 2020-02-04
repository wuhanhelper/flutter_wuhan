import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/module/home/mine/mine_contract.dart';
import 'package:wuhan/module/home/mine/mine_presenter.dart';

/// @desc TODO
/// @time 2020/02/04 20:32
/// @author lizubing1992
class Mine extends LcfarmWidget {
  Mine({Object arguments}) : super(arguments: arguments,routerName: "Mine");

  @override
  LcfarmWidgetState getState() {
    return _MineState();
  }
}

class _MineState extends LcfarmWidgetState<Presenter, Mine> implements View {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("我的"),
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
    return MinePresenter();
  }
}
