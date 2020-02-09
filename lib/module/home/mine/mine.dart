import 'package:flutter/material.dart';
import 'package:wuhan/base/dialog_bean.dart';
import 'package:wuhan/base/dialog_manager.dart';
import 'package:wuhan/base/dialog_util.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/module/home/mine/mine_contract.dart';
import 'package:wuhan/module/home/mine/mine_presenter.dart';
import 'package:wuhan/module/login/login_page.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_util.dart';

/// @desc TODO
/// @time 2020/02/04 20:32
/// @author lizubing1992 , wangbufan
class Mine extends LcfarmWidget {
  Mine({Object arguments}) : super(arguments: arguments, routerName: "Mine");

  @override
  LcfarmWidgetState getState() {
    return _MineState();
  }
}

class _MineState extends LcfarmWidgetState<Presenter, Mine> implements View {

  Widget _getMineAvatarBody(
      {String avatarImgUrl,
      String userName,
      String userPosition,
      String userSignature}) {
    ///
    /// @author: wangbufan
    /// @function: 个人页面中，顶部的头像控件
    ///
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              avatarImgUrl,
              width: 80,
              height: 80,
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName, textScaleFactor: 1.5),
              Text(userPosition),
              Text(userSignature),
            ],
          )
        ],
      ),
    );
  }

  Widget _getMineButton({String label, VoidCallback onPressed}) {
    ///
    /// @author: wangbufan
    /// @function: 个人主页中Button实体
    ///
    return Column(
      children: <Widget>[
        Container(
          height: 1,
          width: double.infinity,
          color: LcfarmColor.color40000000,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: FlatButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onClickSignOut(){
    ///
    /// @author: wangbufan
    /// @function: 推出登录的最终回调
    ///
   // LcfarmUtil.makeToast('退出登录');

    NavigatorManager().pushReplacementNamed(context,LoginPageMain.router);

  }

  Widget getDialog(){
    ///
    /// @author: wangbufan
    /// @function: 退出登录Dialog弹窗
    ///
    return  DialogUtil.createTipWidget(
      context,
      '确认退出登录?',
      hasTips: false,
      confirmText: '退出',
      cancelText: '取消',
      onConfirmListener: _onClickSignOut,
    );
  }

  Widget _getSignOutButton() {
    ///
    /// @author: wangbufan
    /// @function: 退出登录按钮实体
    ///
    return InkWell(
      onTap: () {
       DialogManager()..add(DialogBean(createDialogWidget: getDialog))..show(context);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: LcfarmColor.colorDB3B49,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          '退出登录',
          style: TextStyle(
            fontSize: 30,
            color: LcfarmColor.colorFFFFFF,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: LcfarmColor.colorFFFFFF,
        border: Border(
          top: BorderSide(
            color: LcfarmColor.color40000000,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _getMineAvatarBody(
            avatarImgUrl: 'images/avatar.png',
            userName: '王刚强',
            userPosition: '医护人员',
            userSignature: '我是武毒的守护者',
          ),
          _getMineButton(
              label: '编辑资料',
              onPressed: () {
                LcfarmUtil.makeToast('Click: 编辑资料');
              }),
          _getMineButton(
              label: '我的发布',
              onPressed: () {
                LcfarmUtil.makeToast('Click: 我的发布');
              }),
          _getMineButton(
              label: '我的收藏',
              onPressed: () {
                LcfarmUtil.makeToast('Click: 我的收藏');
              }),
          _getMineButton(
              label: '关于我们',
              onPressed: () {
                LcfarmUtil.makeToast('Click: 关于我们');
              }),
          Expanded(child: Container()),
          _getSignOutButton(),
          Padding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }

  @override
  void initState() {
    //必须要在 super.initState前调用
    innerPager(true);
    super.initState();
//    hiddenAppbar();
    setAppbar(title: '我的', hiddenBack: true);
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
