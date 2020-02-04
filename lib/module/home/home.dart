import 'package:flutter/material.dart';
import 'package:flutter_common_utils/date_util.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:provider/provider.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/home_contract.dart';
import 'package:wuhan/module/home/home_presenter.dart';
import 'package:wuhan/module/home/page_view_app.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_util.dart';

import '../../developer.dart';
import 'bottom_bar_app.dart';
import 'homepage_notifier.dart';

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
  ///当前选中底部导航下标
  HomepageNotifier _homepageNotifier;

  ///PageView 控制器
  PageController _pageController;

  @override
  Widget buildWidget(BuildContext context) {
    return PageViewApp(_pageController = PageController(initialPage: BottomBarApp.homeIndex));
  }

  @override
  void initState() {
    super.initState();
    hiddenAppbar();
    _homepageNotifier = HomepageNotifier(BottomBarApp.homeIndex);
    _pageController = PageController(initialPage: _homepageNotifier.index);
  }

  @override
  Widget buildScaffold(BuildContext context, {bool resizeToAvoidBottomInset}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomepageNotifier>.value(
          value: _homepageNotifier,
        )
      ],
      child: Scaffold(
        body: super.buildBody(bottom: false),
        //框架页不用4态，子页里面已有
//        body: buildWidget(context),
        bottomNavigationBar: _buildBottomNavigationBar(),
        floatingActionButton: LcfarmUtil.isTest()
            ? FloatingActionButton(
                onPressed: () {
                  //配置抓包。
                  NavigatorManager().pushNamed(context, Developer.router);
                },
                child: Text(
                  "开发者模式",
                  textAlign: TextAlign.center,
                ),
                backgroundColor: LcfarmColor.color3776E9,
              )
            : null,
      ),
    );
  }

  ///根据不同登录，初始化不同菜单
  Widget _buildBottomNavigationBar() {
    return Consumer<HomepageNotifier>(
        builder: (context, homepageNotifier, _) => BottomBarApp(
              index: homepageNotifier.index,
              appBarClick: (int index) {
                LogUtil.v("index---$index");
                _homepageNotifier.index = index;
                _pageController.jumpToPage(index);
              },
            ));
  }

  int last = 0;

  @override
  void onKeycodeBack() {
    int now = DateUtil.getNowDateMilliseconds();
    if (now - last > 2000) {
      last = DateUtil.getNowDateMilliseconds();
      LcfarmUtil.makeToast("再按一次退出");
    } else {
      LcfarmUtil.exitApp();
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _homepageNotifier.dispose();
    super.dispose();
  }

  @override
  void queryData() {
    disabledLoading();
  }

  @override
  Presenter createPresenter() {
    return HomePresenter();
  }
}
