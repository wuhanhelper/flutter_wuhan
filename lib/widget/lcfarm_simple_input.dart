import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/utils/string_util.dart';

/// @desc: 简单的输入框
/// @author: yuming
/// @time: 2019-05-07 11:17:41
class LcfarmSimpleInput extends StatefulWidget {
  ///输入框提示文字
  final String hint;

  ///输入悬停文字
  final String label;

  ///方法回调Function，或者通知 EventBus 通信
  final callback;

  ///键盘模式
  final keyboardType;

  ///字符限制
  final maxLength;

  ///输入监听器
  final controller;

  ///字段校验
  final validator;

  const LcfarmSimpleInput({
    @required this.hint,
    @required this.label,
    this.callback,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.controller,
    this.validator,
  });

  @override
  LcfarmSimpleInputState createState() => LcfarmSimpleInputState();
}

class LcfarmSimpleInputState extends State<LcfarmSimpleInput> {
  ///输入监听器
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  bool _offstage = true;

  ///label浮到上方
  static double _topFontSize = 16;
  static double _topPaddingTop = 14.5;
  static double _topPaddingBottom = 12.0;

  ///label回到中间
  static double _middleFontSize = 18;
  static double _middlePaddingTop = 9.0;
  static double _middlePaddingBottom = 16.0;

  ///label当前行高
  double _labelFontSize = _middleFontSize;
  double _paddingTop = _middlePaddingTop;
  double _paddingBottom = _middlePaddingBottom;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      //setState(() {});
      _text = _controller.text;
      if (!_focusNode.hasFocus) {
        _setLabelHeight();
      } else {
        if (!StringUtil.isEmpty(_text)) {
          if (_offstage != false) {
            setState(() {
              _offstage = false;
            });
          }
        } else {
          if (_offstage != true) {
            setState(() {
              _offstage = true;
            });
          }
        }
      }

      if (widget.callback != null) {
        widget.callback(_text);
      }
    });

    _focusNode.addListener(() {
      _setLabelHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _buildTextField(),
      Positioned(
        top: LcfarmSize.dp(24.0),
        right: 0.0,
        child: Offstage(
          offstage: _offstage,
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                LcfarmSize.dp(4.0),
                LcfarmSize.dp(5.0),
                0.0,
                LcfarmSize.dp(5.0),
              ),
              child: Icon(
                LcfarmIcon.icon_clear,
                size: LcfarmSize.dp(20.0),
                color: LcfarmColor.color24000000,
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _controller.text = '';
              _setLabelHeight();
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(widget.maxLength ?? -1),
        widget.keyboardType == TextInputType.phone
            ? WhitelistingTextInputFormatter.digitsOnly
            : WhitelistingTextInputFormatter(RegExp(r'\S| +')),
      ],
      style: LcfarmStyle.style80000000_18,
      decoration: InputDecoration(
        isDense: true,
        alignLabelWithHint: true,
        hintText: widget.hint,
        hintStyle: LcfarmStyle.style40000000_18,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: LcfarmColor.color40000000,
          fontSize: LcfarmSize.sp(_labelFontSize),
          height: 0.4,
        ),
        contentPadding: EdgeInsets.only(
          top: LcfarmSize.dp(_paddingTop),
          bottom: LcfarmSize.dp(_paddingBottom),
        ),
        suffix: Offstage(
          offstage: _offstage,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: LcfarmSize.dp(8.0),
              horizontal: LcfarmSize.dp(16.0),
            ),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: LcfarmColor.color08000000,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: LcfarmColor.color3776E9,
          ),
        ),
      ),
      validator: (val) {
        return widget.validator != null ? widget.validator(val) : null;
      },
    );
  }

  void _setLabelHeight() {
    if (mounted) {
      setState(() {
        if (!_focusNode.hasFocus) {
          if (StringUtil.isEmpty(_text)) {
            _labelFontSize = _middleFontSize;
            _paddingTop = _middlePaddingTop;
            _paddingBottom = _middlePaddingBottom;
          } else {
            _labelFontSize = _topFontSize;
            _paddingTop = _topPaddingTop;
            _paddingBottom = _topPaddingBottom;
          }
          _offstage = true;
        } else {
          _labelFontSize = _topFontSize;
          _paddingTop = _topPaddingTop;
          _paddingBottom = _topPaddingBottom;
          if (!StringUtil.isEmpty(_text)) {
            _offstage = false;
          }
        }
      });
    }
  }
}
