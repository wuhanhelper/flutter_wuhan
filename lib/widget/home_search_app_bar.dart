import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/utils/string_util.dart';

/// @desp:首页搜索appBar
/// @time 2019/8/26 16:33
/// @author lizubing

typedef OnSubmitCallback = Function(String text); //提交数据的回调

class HomeSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  final double elevation; //阴影
  final Widget leading;
  final String hintText;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;
  final OnSubmitCallback onSubmitCallback;

  const HomeSearchAppBar(
      {Key key,
      this.height = 46.0,
      this.elevation = 0.5,
      this.leading,
      this.hintText = '请输入关键词',
      this.focusNode,
      this.inputFormatters,
      this.onEditingComplete,
      this.onSubmitCallback,
      this.prefixIcon = Icons.search})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeSearchAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class HomeSearchAppBarState extends State<HomeSearchAppBar> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: SafeArea(
          child: Container(
            color: LcfarmColor.colorFFFFFF,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: LcfarmSize.dp(15)),
                  child: Row(
                    children: <Widget>[
                      Text("上海"),
                    ],
                  ),
                ),
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    StringUtil.isEmpty(_controller?.text)
                        ? Positioned(
                            left: LcfarmSize.dp(40),
                            top: LcfarmSize.dp(6),
                            child: Text(
                              widget.hintText,
                              style: LcfarmStyle.style40000000_14,
                            ))
                        : Container(),
                    Container(
                        margin: EdgeInsets.only(
                            left: LcfarmSize.dp(10), right: LcfarmSize.dp(15)),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(LcfarmSize.dp(5))),
                            border: new Border.all(
                                width: LcfarmSize.dp(0),
                                color: Colors.grey[300])),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(widget.prefixIcon,
                                  color: LcfarmColor.colorB6B6B6,
                                  size: LcfarmSize.dp(18)),
                              margin: EdgeInsets.only(
                                  left: LcfarmSize.dp(8),
                                  right: LcfarmSize.dp(4)),
                            ),
                            Expanded(
                              child: TextField(
                                  focusNode: widget.focusNode,
                                  keyboardType: TextInputType.text,
                                  controller: _controller,
                                  maxLines: 1,
                                  style: LcfarmStyle.style000000_14,
                                  inputFormatters: widget.inputFormatters,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (text) {
                                    setState(() {});
                                    if (null != widget.onSubmitCallback) {
                                      widget.onSubmitCallback(text);
                                    }
                                  },
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                  textInputAction: TextInputAction.search,
                                  onEditingComplete: widget.onEditingComplete),
                            ),
                          ],
                        )),
                  ],
                ))
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(widget.height));
  }
}
