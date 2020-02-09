import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/module/home/homepage/homepage_list_entity.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

class HomepageListItem extends StatefulWidget {
  final HomepageListEntity bean;

  final GestureTapCallback onTap;

  HomepageListItem({@required this.bean, this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _HomepageListItemState();
  }
}

class _HomepageListItemState extends State<HomepageListItem> {
  final double _screenWidth = LcfarmSize.screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          color: LcfarmColor.colorFFFFFF,
          padding: EdgeInsets.only(
              left: LcfarmSize.dp(15),
              top: LcfarmSize.dp(8),
              right: LcfarmSize.dp(15),
              bottom: LcfarmSize.dp(16)),
          margin: EdgeInsets.only(top: LcfarmSize.dp(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    LcfarmIcon.icon_account_normal,
                    size: LcfarmSize.dp(25),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "武汉协和医院",
                      ),
                      Text("2020-02-02 14:30:30")
                    ],
                  )),
                  Text("医院"),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
              RichText(
                  text: TextSpan(
                text:
                    "求助求助！！！求求大家的帮助！！！已经开始发烧到40多度，真的非常急需一个床位！！！希望大家帮助，太感谢了...",
                style: LcfarmStyle.style666666_14,
                children: [
                  TextSpan(text: "更多", style: LcfarmStyle.style3776E9_13),
                ],
              )),
              Container(
                width: LcfarmSize.dp(75),
                height: LcfarmSize.dp(75),
                color: Colors.grey[200],
                padding: EdgeInsets.only(left:LcfarmSize.dp(2),right: LcfarmSize.dp(2)),
                margin: EdgeInsets.only(top: LcfarmSize.dp(8)),
                child: Text(""
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: LcfarmSize.dp(8)),
                child: Text(
                  "紧缺物资",
                ),
              ),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.only(left:LcfarmSize.dp(2),right: LcfarmSize.dp(2)),
                margin: EdgeInsets.only(top: LcfarmSize.dp(8)),
                child: Text(
                  "N95口罩",
                ),
              ),
            ],
          ),
        ));
  }
}
