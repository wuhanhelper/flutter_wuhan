import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/utils/string_util.dart';

/// @desc 自定义单行输入框(默认左边 label)
/// @time 2019-05-14 16:16
/// @author chenyun
class LcfarmInput extends StatefulWidget {
  ///输入框提示文字
  final String hint;

  ///hit Style
  final TextStyle hitStyle;

  ///textStyle
  final TextStyle textStyle;

  ///输入框左边文字
  final String label;

  ///输入框左边文字样式
  final TextStyle labelStyle;

  ///左边 label 大小
  final double labelWidth;

  final TextAlign textAlign;

  final int maxLength;

  ///是否展示分割线
  final isShowBottomSeparator;

  ///右边图标
  final Widget suffix;

  ///输入监听
  final TextEditingController controller;

  final List<TextInputFormatter> inputFormatters;

  ///键盘类型
  final TextInputType keyboardType;

  ///方法回调Function，或者通知 EventBus 通信
  final callback;

  final obscureText;
  FocusNode focus;
  LcfarmInput(
      {this.hint = "",
      this.hitStyle,
      this.textStyle,
      this.isShowBottomSeparator = true,
      this.label,
      this.labelStyle,
      this.labelWidth,
      this.maxLength,
      this.textAlign = TextAlign.start,
      this.suffix,
      this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.callback,
      this.obscureText = false,
      this.focus});

  @override
  _LcfarmInputState createState() => _LcfarmInputState();
}

class _LcfarmInputState extends State<LcfarmInput> {
  ///焦点监听
  FocusNode _focus;

  ///输入监听
  TextEditingController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller != null ? widget.controller : TextEditingController();

    _focus = widget.focus != null ? widget.focus : FocusNode();

    if (widget.callback != null) {
      _controller.addListener(() {
        widget.callback(_controller.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [];
    if (widget.label != null) {
      childrenList.add(_buildLabel());
    }
    childrenList.add(Expanded(child: _buildTextField()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: childrenList,
        ),
        widget.isShowBottomSeparator
            ? Divider(
                color: _focus.hasFocus
                    ? LcfarmColor.color3776E9
                    : LcfarmColor.color08000000,
                height: LcfarmSize.dp(1),
              )
            : Container(),
      ],
    );
  }

  Widget _buildLabel() {
    if (widget.labelWidth != null) {
      return Container(
        constraints: BoxConstraints(
          minWidth: widget.labelWidth,
        ),
        child: Text(
          widget.label,
          style: widget.labelStyle != null
              ? widget.labelStyle
              : LcfarmStyle.style80000000_14,
        ),
      );
    } else {
      return Text(
        widget.label,
        style: widget.labelStyle != null
            ? widget.labelStyle
            : LcfarmStyle.style80000000_14,
      );
    }
  }

  Alignment _hitAlignment() {
    if (TextAlign.left == widget.textAlign ||
        TextAlign.start == widget.textAlign ||
        TextAlign.justify == widget.textAlign) {
      return Alignment.centerLeft;
    } else if (TextAlign.right == widget.textAlign ||
        TextAlign.end == widget.textAlign) {
      return Alignment.centerRight;
    } else {
      return Alignment.center;
    }
  }

  Widget _buildTextField() {
    return Stack(
      alignment: _hitAlignment(),
      children: <Widget>[
        StringUtil.isEmpty(_controller.text)
            ? Text(
                widget.hint,
                style: widget.hitStyle != null
                    ? widget.hitStyle
                    : LcfarmStyle.style40000000_14,
              )
            : Container(),
        TextFormField(
          obscureText: widget.obscureText,
          textAlign: widget.textAlign,
          controller: _controller,
          onChanged: (val) {
            setState(() {});
          },
          focusNode: _focus,
          maxLength: widget.maxLength,
          style: widget.textStyle != null
              ? widget.textStyle
              : LcfarmStyle.style80000000_20,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
//            hintText: widget.hint,
//            hintStyle: widget.hitStyle != null
//                ? widget.hitStyle
//                : LcfarmStyle.style40000000_14,
            border: InputBorder.none,
            suffixIcon: widget.suffix,
            counterText: "",
          ),
        ),
      ],
    );
  }
}
