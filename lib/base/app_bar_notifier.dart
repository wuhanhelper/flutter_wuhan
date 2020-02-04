import 'package:flutter/foundation.dart';

/// @desc 创建标题栏状态数据类
/// @time 2019-07-23 19:04
/// @author chenyun
class AppBarNotifier with ChangeNotifier {
  //这里只是简单更改标识，让 AppBar 刷新，AppBar 具体的值单独赋值。
  int _status = 0;

  int get status => _status;

  void changeStatus() {
    _status++;
    notifyListeners();
  }
}
