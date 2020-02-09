import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/module/home/homepage/homepage_help/homepage_help_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_help/homepage_help_presenter.dart';
import 'package:wuhan/widget/easyrefresh/lcfarm_refresh_header.dart';

import '../homepage_info_item.dart';
import '../homepage_list_entity.dart';

/// @desc TODO
/// @time 2020/02/06 16:33
/// @author lizubing1992
class HomepageHelp extends LcfarmWidget {
  HomepageHelp({Object arguments})
      : super(arguments: arguments, routerName: "HomepageHelp");

  @override
  LcfarmWidgetState getState() {
    return _HomepageHelpState();
  }
}

class _HomepageHelpState extends LcfarmWidgetState<Presenter, HomepageHelp>
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
                return _buildLoanItem(_itemData[i]);
              },
              itemCount: _itemData.length,
            ),
      onRefresh: () async {
        // 开始加载数据
        _controller.finishRefresh();
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

  ///授信进度item
  Widget _buildLoanItem(HomepageListEntity bean) {
    return HomepageListItem(bean: bean, isCredit: true);
  }

  @override
  void queryData() {
    showLoadSuccess();
    showList();
  }

  @override
  Presenter createPresenter() {
    return HomepageHelpPresenter();
  }
}
