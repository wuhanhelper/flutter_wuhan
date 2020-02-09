import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

import 'lcfarm_appbar.dart';

/// @desp:搜索appBar
/// @time 2019/8/26 16:33
/// @author lizubing

typedef OnExitCallback = Function(); //退出页面回调

typedef OnSubmitCallback = Function(String text); //提交数据的回调

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  final double elevation; //阴影
  final Widget leading;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;
  final OnSubmitCallback onSubmitCallback;
  final OnExitCallback onExitCallback;

  const SearchAppBar(
      {Key key,
      this.height = 46.0,
      this.elevation = 0.5,
      this.leading,
      this.hintText = '请输入关键词',
      this.focusNode,
      this.controller,
      this.inputFormatters,
      this.onEditingComplete,
      this.onSubmitCallback,
      this.onExitCallback,
      this.prefixIcon = Icons.search})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: Stack(
          children: <Widget>[
            Offstage(
              offstage: false,
              child: LcfarmAppBar(
                backgroundColor: LcfarmColor.colorFFFFFF,
                title: Text(""),
              ),
            ),
            Offstage(
                offstage: false,
                child: Container(
                    padding: EdgeInsets.only(top: LcfarmSize.statusBarHeight),
                    child: TextField(
                        focusNode: widget.focusNode,
                        keyboardType: TextInputType.text,
                        controller: widget.controller,
                        maxLines: 1,
                        inputFormatters: widget.inputFormatters,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: LcfarmColor.colorB6B6B6,
                            fontSize: LcfarmSize.sp(14),
                          ),
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: LcfarmSize.sp(2)),
                              child: Icon(
                                widget.prefixIcon,
                                color: LcfarmColor.colorB6B6B6,
                              )),
                          suffixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: LcfarmSize.sp(12),
                                  end: LcfarmSize.sp(15)),
                              child: InkWell(
                                  onTap: (() {
                                    if (null != widget.onExitCallback) {
                                      widget.onExitCallback();
                                    }
                                    setState(() {
                                      widget.controller.text = '';
                                    });
                                  }),
                                  child: Text(
                                    "取消",
                                    textAlign: TextAlign.center,
                                    style: LcfarmStyle.style3776E9_16,
                                  ))),
                          contentPadding:
                              EdgeInsets.fromLTRB(0, LcfarmSize.dp(10), 0, 0),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                        ),
                        onSubmitted: (text) {
                          if (null != widget.onSubmitCallback) {
                            widget.onSubmitCallback(text);
                          }
                        },
                        textInputAction: TextInputAction.search,
                        onEditingComplete: widget.onEditingComplete)))
          ],
        ),
        preferredSize: Size.fromHeight(widget.height));
  }
}
