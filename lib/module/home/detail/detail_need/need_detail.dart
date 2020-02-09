import 'package:flutter/material.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_contract.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_presenter.dart';

/// @desc 需求详情
/// @time 2020/02/09 14:26
/// @author lizubing1992
class NeedDetail extends LcfarmWidget {

  ///路由
  static const String router = Router.scheme + "need_detail";

  NeedDetail({Object arguments}) : super(arguments: arguments,routerName:router);

  @override
  LcfarmWidgetState getState() {
    return _NeedDetailState();
  }
}

class _NeedDetailState extends LcfarmWidgetState<Presenter, NeedDetail>
    implements View {

  @override
  void initState() {
    super.initState();
    setTitle("需求详情");
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
    return NeedDetailPresenter();
  }
}
