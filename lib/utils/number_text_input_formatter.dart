import 'package:flutter/services.dart';

/// @desc 只允许输入两位小数
/// @time 2019-06-25 11:08
/// @author chenyun
class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value.indexOf(".") > 0 &&
        value.length - value.indexOf(".") - 1 > 2) {
      //小数点超过三位，则不允许输入
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
