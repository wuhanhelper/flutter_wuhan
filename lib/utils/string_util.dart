import 'package:flutter_common_utils/log_util.dart';

import 'numer_util.dart';

/// @desp: 字符串判断
/// @time 2019/3/12 5:24 PM
/// @author chenyun
class StringUtil {
  ///判断字符串是否为空
  static bool isEmpty(String s) {
    return s == null || s.isEmpty;
  }

  ///是否 不为空字符串 或 null
  static bool isNotEmpty(String s) {
    return s != null && s.isNotEmpty;
  }

  ///是否 不为空字符串 或 null
  static bool isBoolTrue(bool s) {
    return s != null && s;
  }

  ///插入字符
  static String charAt(String oldStr, int index) {
    if (index > oldStr.length) {
      //下标超过了最大长度
      return "";
    }
    if (index - 1 < 0) {
      return "";
    }
    return oldStr.substring(index - 1, index);
  }

  ///插入字符
  static String insert(String oldStr, int index, String newChar) {
    return oldStr.substring(0, index) + newChar + oldStr.substring(index);
  }

  /// 每隔 x位 加 pattern
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text?.replaceAllMapped(RegExp("(.{$digit})"), (Match match) {
      return "${match.group(0)}$pattern";
    });
    if (text != null && text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  /// 每隔 x位 加 pattern, 从末尾开始
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: 3, pattern: ',');
    temp = reverse(temp);
    return temp;
  }

  /// 每隔4位加空格
  static String formatSpace4(String text) {
    return formatDigitPattern(text);
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。int型。
  static String formatComma3(Object num) {
    return formatDigitPatternEnd(num?.toString(), digit: 3, pattern: ',');
  }

  /// hideNumber
  static String hideNumber(String phoneNo,
      {int start = 3, int end = 7, String replacement = '****'}) {
    return phoneNo?.replaceRange(start, end, replacement);
  }

  /// replace
  static String replace(String text, Pattern from, String replace) {
    return text?.replaceAll(from, replace);
  }

  /// split
  static List<String> split(String text, Pattern pattern,
      {List<String> defValue = const []}) {
    List<String> list = text?.split(pattern);
    return list ?? defValue;
  }

  /// reverse
  static String reverse(String text) {
    if (isEmpty(text)) return '';
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }

  /// reverse
  static String getLast4Number(String text) {
    if (isEmpty(text)) return '';
    if (text.length <= 4) return text;
    return text.substring(text.length - 4, text.length);
  }



  /// 判断是否是新版本
  /// currentVersion 当前版本名  格式：1.0.0
  /// latestVersion 最新发布的版本名   格式：1.0.0
  /// true 有最新版本
  static bool hasNewVersion(String currentVersion, String latestVersion) {
    if (isNotEmpty(latestVersion) &&
        isNotEmpty(currentVersion) &&
        latestVersion != currentVersion) {
      //去小数点
      String lv = latestVersion.replaceAll(".", "");
      //去小数点
      String cv = currentVersion.replaceAll(".", "");
      LogUtil.v("==========版本信息========最新版本:" + lv + "/当前版本:" + cv);
      if (lv.length < 3) {
        //转化为3位数
        lv += "0";
      }
      if (cv.length < 3) {
        //转化为3位数
        cv += "0";
      }
      LogUtil.v("lv=" + lv + "cv=" + cv);
      if (NumberUtil.getDoubleByValueStr(lv) >
          NumberUtil.getDoubleByValueStr(cv)) {
        LogUtil.v("true");
        return true;
      }
    }
    return false;
  }
}
