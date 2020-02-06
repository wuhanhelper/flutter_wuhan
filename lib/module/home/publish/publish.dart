import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/module/home/publish/publish_contract.dart';
import 'package:wuhan/module/home/publish/publish_presenter.dart';

/// @desc TODO
/// @time 2020/02/04 20:38
/// @author lizubing1992
class Publish extends LcfarmWidget {
  Publish({Object arguments})
      : super(arguments: arguments, routerName: "Publish");

  @override
  LcfarmWidgetState getState() {
    return _PublishState();
  }
}

class _PublishState extends LcfarmWidgetState<Presenter, Publish>
    implements View {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("发布"),
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
    return PublishPresenter();
  }
}
