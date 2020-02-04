import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

import 'lcfarm_loading.dart';

/// @desc 提交框
/// @time 2019-05-14 09:27
/// @author chenyun
class LcfarmSubmitDialog extends StatelessWidget {
  final String text;

  LcfarmSubmitDialog({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: SizedBox(
          width: LcfarmSize.dp(120),
          height: LcfarmSize.dp(120),
          child: Container(
            decoration: ShapeDecoration(
              color: LcfarmColor.colorFFFFFF,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(LcfarmSize.dp(8)),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LcfarmLoading(),
//                CircularProgressIndicator(
//                  valueColor:
//                      AlwaysStoppedAnimation<Color>(LcfarmColor.color3776E9),
//                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: LcfarmSize.dp(20),
                  ),
                  child: Text(
                    text ?? "正在提交...",
                    style: LcfarmStyle.style80000000_14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
