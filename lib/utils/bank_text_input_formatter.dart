import 'package:flutter/services.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:wuhan/utils/string_util.dart';

/// @desc 银行卡输入4位一分隔
/// @time 2019-06-25 11:08
/// @author chenyun
class BankTextInputFormatter extends TextInputFormatter {
  static const int defaultMaxLength = 25 + 6;

  int maxLength;

  BankTextInputFormatter({this.maxLength = defaultMaxLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    LogUtil.v("formatEditUpdate");
    String value = newValue.text;
    //光标
    int selectionIndex = newValue.selection.end;
    //旧文本的空格数
    int space = 0;
    for (int i = 0, len = oldValue.text.length; i < len; i++) {
      if (StringUtil.charAt(value, i) == " ") {
        space++;
      }
    }
    // final StringBuffer newText = StringBuffer();

    //插入下标
    int index = 0;
    //新插入总空格数
    int totalSpace = 0;
    if (value.isNotEmpty) {
      value = value.replaceAll(" ", "");
      while (index < value.length) {
        if ((index == 4 ||
            index == 9 ||
            index == 14 ||
            index == 19 ||
            index == 24 ||
            index == 29)) {
          LogUtil.v("oldValue=" + value);
          value = StringUtil.insert(value, index, " ");
          LogUtil.v("value=" + value);
          totalSpace++;
        }
        index++;
      }
    }
    //selection index
    if (totalSpace > space) {
      selectionIndex += (totalSpace - space);
    }
    if (selectionIndex > value.length) {
      selectionIndex = value.length;
    } else if (selectionIndex < 0) {
      selectionIndex = 0;
    }
    LogUtil.v("selectionIndex=$selectionIndex");
    if (value.length >= maxLength) {
      selectionIndex = maxLength;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
