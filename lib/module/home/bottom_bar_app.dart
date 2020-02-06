import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:wuhan/base/const.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

typedef OnAppBarClick = void Function(int index);

/// @desc 标准菜单，外层通过 provider 更新，所以弄成 StatelessWidget
/// @time 2019-09-27 10:39
/// @author chenyun
class BottomBarApp extends StatelessWidget {
  ///选中下标
  final int index;

  ///点击回调
  final OnAppBarClick appBarClick;

  BottomBarApp({this.index = 0, @required this.appBarClick});

  ///首页
  static const homeIndex = 0;

  ///发布
  static const publishIndex = 1;

  ///我的
  static const mineIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LcfarmColor.colorFFFFFF,
//        boxShadow: [
//          BoxShadow(
//            color: LcfarmColor.color08000000,
//            offset: Offset(0, -LcfarmSize.dp(1)),
//            blurRadius: LcfarmSize.dp(3),
//          )
//        ],
      ),
      child: SafeArea(
          top: false,
          child: SizedBox(
            height: LcfarmSize.dp(52),
            child: BottomAppBar(
              color: LcfarmColor.colorFFFFFF,
              elevation: 0.0,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: LcfarmSize.dp(0.5),
                    color: LcfarmColor.color08000000,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(child: _buildHomeWidget()),
                      Expanded(child: _buildPublishWidget()),
                      Expanded(child: _buildMineWidget()),
                    ],
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )),
                ],
              ),
            ),
          )),
    );
  }

  bool get isMine => index == mineIndex;

  ///我的控件
  Widget _buildMineWidget() {
    return GestureDetector(
      onTap: () {
        appBarClick(mineIndex);
      },
//          radius: LcfarmSize.dp(38),
      child: Container(
        color: LcfarmColor.colorFFFFFF,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isMine
                  ? LcfarmIcon.icon_account_normal
                  : LcfarmIcon.icon_account_normal,
              color:
                  isMine ? LcfarmColor.color3776E9 : LcfarmColor.color60000000,
              size: LcfarmSize.dp(26),
            ),
            Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(4))),
            Padding(
                padding: EdgeInsets.only(
                  left: LcfarmSize.dp(2),
                  //  right: LcfarmSize.dp(2),
                ),
                child: Text(
                  SpUtil().get(Const.HOME_MID_TAB) ?? "我的",
                  style: isMine
                      ? LcfarmStyle.style3776E9_11
                      : LcfarmStyle.style60000000_11,
                ))
          ],
        ),
      ),
    );
  }

  bool get isHome => index == homeIndex;

  ///首页控件
  Widget _buildHomeWidget() {
    return GestureDetector(
      onTap: () {
        appBarClick(homeIndex);
      },
//        radius: LcfarmSize.dp(38),
      child: Container(
        color: LcfarmColor.colorFFFFFF,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isHome
                  ? LcfarmIcon.icon_account_normal
                  : LcfarmIcon.icon_account_normal,
              color:
                  isHome ? LcfarmColor.color3776E9 : LcfarmColor.color60000000,
              size: LcfarmSize.dp(26),
            ),
            Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(4))),
            Padding(
              padding: EdgeInsets.only(
                left: LcfarmSize.dp(2),
                //  right: LcfarmSize.dp(2),
              ),
              child: Text(
                SpUtil().get(Const.HOME_LEFT_TAB) ?? "首页",
                style: isHome
                    ? LcfarmStyle.style3776E9_11
                    : LcfarmStyle.style60000000_11,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///财富控件
  Widget _buildPublishWidget() {
    return GestureDetector(
      onTap: () {
        appBarClick(publishIndex);
      },
//          radius: LcfarmSize.dp(38),
      child: Container(
        color: LcfarmColor.colorFFFFFF,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isPublish
                  ? LcfarmIcon.icon_account_normal
                  : LcfarmIcon.icon_account_normal,
              color: isPublish
                  ? LcfarmColor.color3776E9
                  : LcfarmColor.color60000000,
              size: LcfarmSize.dp(26),
            ),
            Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(4))),
            Padding(
                padding: EdgeInsets.only(
                  left: LcfarmSize.dp(2),
                  //  right: LcfarmSize.dp(2),
                ),
                child: Text(
                  SpUtil().get(Const.HOME_RIGHT_TAB) ?? "发布",
                  style: isPublish
                      ? LcfarmStyle.style3776E9_11
                      : LcfarmStyle.style60000000_11,
                ))
          ],
        ),
      ),
    );
  }

  bool get isPublish => index == publishIndex;
}
