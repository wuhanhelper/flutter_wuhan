import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

/// @desc: 大按钮
/// @author: yuming
/// @time: 2019-05-07 14:36:04
class LcfarmLargeButton extends StatefulWidget {
  ///按钮上的文字
  final String label;

  ///方法回调Function，或者通知 EventBus 通信
  final VoidCallback onPressed;

  final Color color;
  final Color disabledColor;


  const LcfarmLargeButton({@required this.label, @required this.onPressed, this.color = LcfarmColor.color3776E9, this.disabledColor = LcfarmColor.color203776E9});

  @override
  LcfarmLargeButtonState createState() => LcfarmLargeButtonState();
}

class LcfarmLargeButtonState extends State<LcfarmLargeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: LcfarmSize.dp(48.0),
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        color: widget.color,
        disabledColor: widget.disabledColor,
        textColor: LcfarmColor.colorFFFFFF,
        disabledTextColor: LcfarmColor.colorFFFFFF,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LcfarmSize.dp(24.0))),
        child: Text(widget.label, style: LcfarmStyle.styleFFFFFF_18),
        onPressed: widget.onPressed,
      ),
    );
  }
}
