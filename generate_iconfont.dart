import 'dart:io';

/// 字体文件地址. https://www.iconfont.cn/manage/index
/// @desp: iconfont.ttf 转换 lcfarm_icon.dart
/// @time 2019/3/13 3:05 PM
/// @author chenyun
void main() {
  Convert();
}

class Convert {
//  static const String _const_iconfont = 'iconfont';
  static const String _const_css_file_name = 'iconfont';
  final String className = 'LcfarmIcon';
  final String distName = 'lcfarm_icon';
  final String fontName = 'iconfont';
  Convert() {
    String flutterCode = '''
import 'package:flutter/widgets.dart';

/// @desc: flutter项目自定义字体图标
/// @Date: {date}
/// @author: chenyun
class {class_name}{
    static const __FONT_NAME__ = '{font_name}';
{FLUTTER_CODE}
}''';
    // 目录分割符
    String pathSeparator = Platform.pathSeparator.toString();
    print('开始转换...');
    File('fonts$pathSeparator$_const_css_file_name.css')
        .readAsString()
        .then((String content) {
//      RegExp exp = new RegExp(r'.icon(icon.*?):[\s\S]*?"\\(.*?)";');
      RegExp exp = RegExp(r'.(icon_.*?):[\s\S]*?"\\(.*?)";');
      Iterable<Match> matches = exp.allMatches(content);
      String string = '';
      print("--------$content");
      for (Match m in matches) {
        String iconName = m.group(1);
        String value = m.group(2);
        int idx = string.indexOf('static const IconData icon$iconName =');
        if (iconName != null && value != null && idx < 0) {
          iconName = iconName.toLowerCase().replaceAll('-', '_');
          string +=
              '    static const IconData $iconName = const IconData(0x$value, fontFamily: __FONT_NAME__);\n';
        }
        //print(match);
      }
      List now = DateTime.now().toString().split(' ');
      flutterCode = flutterCode.replaceFirst('{FLUTTER_CODE}', string);
      flutterCode = flutterCode.replaceFirst('{class_name}', className);
      flutterCode = flutterCode.replaceFirst('{font_name}', fontName);
      flutterCode = flutterCode.replaceFirst('{date}', now[0]);
      File('lib${pathSeparator}utils$pathSeparator$distName.dart')
          .writeAsString(flutterCode)
          .then((File file) {
        print('转换完成');
      });
    });
  }
}
