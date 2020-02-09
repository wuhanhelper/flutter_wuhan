import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/module/home/homepage/homepage_contract.dart';
import 'package:wuhan/module/home/homepage/homepage_need/homepage_need.dart';
import 'package:wuhan/module/home/homepage/homepage_presenter.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/widget/home_search_app_bar.dart';

import 'homepage_help/homepage_help.dart';

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
    with SingleTickerProviderStateMixin
    implements View {
  TabController _tabController;

  List<Widget> _tabs = List<Widget>();

  @override
  Widget buildAppBar(
      {Color backgroundColor, String title, bool isAppbarBackShow}) {
    return HomeSearchAppBar(
      hintText: "可搜索地点,内容,人名",
      onSubmitCallback: (text) {},
    );
  }

  @override
  void initState() {
    innerPager(true);
    super.initState();
    _tabs.addAll(<Widget>{
      Tab(
        text: "需求",
      ),
      Tab(
        text: "援助",
      ),
    });
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void queryData() {
    disabledLoading();
  }

  @override
  Presenter createPresenter() {
    return HomepagePresenter();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(
            color: LcfarmColor.colorFFFFFF,
            child: Row(
              children: <Widget>[
                Container(
                  child: TabBar(
                      controller: _tabController,
                      labelStyle: LcfarmStyle.style3776E9_16,
                      labelColor: LcfarmColor.color3776E9,
                      unselectedLabelColor: LcfarmColor.color000000,
                      unselectedLabelStyle: LcfarmStyle.style000000_22,
                      indicatorColor: LcfarmColor.color3776E9,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: LcfarmSize.dp(2),
                      tabs: _tabs),
                  width: LcfarmSize.dp(150),
                ),
                Expanded(
                    child: Container(
                  child: Text(
                    "全部",
                    textAlign: TextAlign.right,
                  ),
                  margin: EdgeInsets.only(right: LcfarmSize.dp(15)),
                )),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(LcfarmSize.dp(40))),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomepageNeed(),
          HomepageHelp(),
        ],
      ),
    );
  }
}
