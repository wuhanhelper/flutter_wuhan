import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';

/// @desc 导航条
/// @time 2019/3/8 17:12
/// @author mrliuys
class LcfarmAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LcfarmAppBar(
      {Key key,
      this.title,
      this.underlineShape = false,
      this.navLeftAction,
      this.navRightAction,
      this.backgroundColor})
      : super(key: key);

  ///标题
  final Widget title;

  final underlineShape;

  ///背景颜色
  final Color backgroundColor;

  ///左边按钮
  final Widget navLeftAction;

  ///右边按钮
  final Widget navRightAction;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (navRightAction != null) {
      actions.add(navRightAction);
    }
    return AppBar(
      brightness: Brightness.light,
      title: title,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0.0,
      shape: underlineShape
          ? UnderlineInputBorder(
              borderSide: BorderSide(
              color: LcfarmColor.color08000000,
              width: LcfarmSize.dp(0.5),
            ))
          : null,
      leading: navLeftAction,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(LcfarmSize.dp(44));
}
