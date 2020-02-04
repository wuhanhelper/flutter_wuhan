/// @desc:
/// @time 2019-08-30 14:49
/// @author mrliuys
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/date_util.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_mvp/presenter/i_presenter.dart';
import 'package:wuhan/utils/lcfarm_color.dart';

import 'base/lcfarm_widget.dart';
import 'base/router.dart';

/// @desc 开发者模式
/// @time 2019-06-11 15:40
/// @author chenyun

class DeveloperSDK extends LcfarmWidget {
  static const String router = Router.scheme + "developerSDK";

  DeveloperSDK({Object arguments})
      : super(arguments: arguments, routerName: router);

  @override
  LcfarmWidgetState getState() {
    return _DeveloperSDKState();
  }
}

class _DeveloperSDKState extends LcfarmWidgetState<IPresenter, DeveloperSDK> {
  @override
  void initState() {
    super.initState();
    setAppbar(title: "开发者模式");
  }

  @override
  Widget buildWidget(BuildContext context) {
    String time = "${DateUtil.getNowDateMilliseconds()}";

    return Container(
      color: LcfarmColor.colorFFFFFF,
      padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(30)),
      child: ListView(
        children: <Widget>[],
      ),
    );
  }

  @override
  void queryData() {
    disabledLoading();
  }

  @override
  IPresenter createPresenter() {
    return null;
  }
}
