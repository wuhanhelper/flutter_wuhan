import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/detail/detail_help/help_detail_contract.dart';
import 'package:wuhan/module/home/detail/detail_help/help_detail_presenter.dart';

/// @desc 援助详情
/// @time 2020/02/09 13:27
/// @author lizubing1992
class HelpDetail extends LcfarmWidget {
  ///路由
  static const String router = Router.scheme + "help_detail";


  HelpDetail({Object arguments}) : super(arguments: arguments,routerName:router);

  @override
  LcfarmWidgetState getState() {
    return _HelpDetailState();
  }
}

class _HelpDetailState extends LcfarmWidgetState<Presenter, HelpDetail>
    implements View {

  @override
  void initState() {
    super.initState();
    setTitle("援助详情");
  }

  @override
  Widget buildWidget(BuildContext context) {
    //TODO: implement buildWidget
    return Container();
  }

  @override
  void queryData() {
    //TODO: implement queryData
  }

  @override
  Presenter createPresenter() {
    return HelpDetailPresenter();
  }
}
