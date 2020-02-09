import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/homepage/homepage_need/homepage_need_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_need/homepage_need_presenter.dart';
import 'package:wuhan/widget/easyrefresh/lcfarm_refresh_header.dart';

import '../homepage_info_item.dart';
import '../homepage_list_entity.dart';

/// @desc TODO
/// @time 2020/02/06 16:32
/// @author lizubing1992
class HomepageNeed extends LcfarmWidget {
  HomepageNeed({Object arguments})
      : super(arguments: arguments, routerName: "HomepageNeed");

  @override
  LcfarmWidgetState getState() {
    return _HomepageNeedState();
  }
}

class _HomepageNeedState extends LcfarmWidgetState<Presenter, HomepageNeed>
    implements View {
  List<HomepageListEntity> _itemData = [];
  EasyRefreshController _controller = EasyRefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    innerPager(true);
    super.initState();
    hiddenAppbar();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      enableControlFinishRefresh: true,
      enableControlFinishLoad: false,
      header: LcfarmRefreshHeader(),
      child: _itemData.isEmpty
          ? Container()
          : ListView.builder(
              itemBuilder: (c, i) {
                return _buildNeedItem(_itemData[i]);
              },
              itemCount: _itemData.length,
            ),
      onRefresh: () async {
        // 开始加载数据
        finishRefresh();
        showList();
      },
    );
  }

  showList() {
    _controller.finishRefresh();
    List<HomepageListEntity> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(HomepageListEntity());
    }
    this._itemData = list;
  }

  Widget _buildNeedItem(HomepageListEntity bean) {
    return HomepageListItem(
      bean: bean,
      onTap: () {
        //跳转到援助详情
        NavigatorManager()
            .pushNamed(context, Router.need_detail, arguments: {});
      },
    );
  }

  void finishRefresh() async {
    _controller.finishRefresh();
  }

  @override
  void queryData() {
    showLoadSuccess();
    showList();
  }

  @override
  Presenter createPresenter() {
    return HomepageNeedPresenter();
  }
}
