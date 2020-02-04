import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/common_bean/version_bean.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

typedef UpgradeCallback = void Function(String url);
typedef CloseCallback = Function();

/// @desc 版本升级框
/// @time 2019-05-27 10:49
/// @author chenyun
class UpgradeDialog extends StatelessWidget {
  final VersionBean versionBean;
  final UpgradeCallback callback;

  final CloseCallback closeCallback;
  UpgradeDialog(this.versionBean, this.callback, this.closeCallback);

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [];
    childrenList.add(_buildContent(context));
    if (!versionBean.forceUpdate) {
      childrenList.add(_buildClose(context));
    }

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: LcfarmSize.screenWidth * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: childrenList,
          ),
        ),
      ),
    );
  }

  Widget _buildClose(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: LcfarmSize.dp(8)),
      child: IconButton(
        icon: Icon(
          LcfarmIcon.icon_dialog_close,
          color: LcfarmColor.colorFFFFFF,
          size: LcfarmSize.dp(40),
        ),
        onPressed: () {
          NavigatorManager().pop(context);
          if (closeCallback != null) {
            closeCallback();
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(
            'images/home/bg_upgrade.png',
          ).image,
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(10))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          _buildHeader(),
          Padding(
            padding: EdgeInsets.only(
                left: LcfarmSize.dp(36), top: LcfarmSize.dp(30)),
            child: Text(
              "版本升级",
              style: LcfarmStyle.styleFFFFFF_24,
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: LcfarmSize.dp(36), top: LcfarmSize.dp(8)),
            padding: EdgeInsets.symmetric(
                horizontal: LcfarmSize.dp(8), vertical: LcfarmSize.dp(4)),
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: LcfarmColor.colorFFFFFF,
            ),
            child: Text(
              "v${versionBean.version}",
              style: LcfarmStyle.style3776E9_14,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: LcfarmSize.dp(60)),
            padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(36)),
            decoration: BoxDecoration(
              color: LcfarmColor.colorFFFFFF,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(LcfarmSize.dp(10)),
                  bottomRight: Radius.circular(LcfarmSize.dp(10))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "为了让您获得更好体验，建议您升级到最新版本!",
                  style: LcfarmStyle.style80000000_16,
                ),
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: LcfarmSize.dp(200),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: LcfarmSize.dp(20)),
                          child: Text(
                            versionBean.remark,
                            style: LcfarmStyle.style80000000_14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildUpgradeButton(context),
              ],
            ),
          )
//          Flexible(
//            child: Container(
//              margin: EdgeInsets.only(top: LcfarmSize.dp(60)),
//              padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(36)),
//              decoration: BoxDecoration(
//                color: LcfarmColor.colorFFFFFF,
//              ),
//              child: ListView(
//                shrinkWrap: true,
//                children: <Widget>[
//                  Text(
//                    "为了让您获得更好体验，建议您升级到最新版本!",
//                    style: LcfarmStyle.style80000000_16,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(top: LcfarmSize.dp(24)),
//                    child: Text(
//                      versionBean.remark,
//                      style: LcfarmStyle.style80000000_14,
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),

//          Container(
//            width: double.infinity,
//            decoration: BoxDecoration(
//              color: LcfarmColor.colorFFFFFF,
//              borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(LcfarmSize.dp(10)),
//                  bottomRight: Radius.circular(LcfarmSize.dp(10))),
//            ),
//            child: _buildUpgradeButton(),
//          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: LcfarmSize.dp(30), bottom: LcfarmSize.dp(24)),
      child: SizedBox(
        width: LcfarmSize.dp(182),
        height: LcfarmSize.dp(44),
        child: FlatButton(
          onPressed: () {
            callback(versionBean.downloadPage);
          },
          color: LcfarmColor.color3776E9,
          shape: StadiumBorder(),
          child: Text(
            versionBean.btnText ?? "立即更新",
            style: LcfarmStyle.styleFFFFFF_18,
          ),
        ),
      ),
    );
  }
}
