import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// @desc 创建主页状态数据类
/// @time 2019-07-24 16:23
/// @author chenyun
class HomepageNotifier with ChangeNotifier {
  ///当前下标
  int _index = 0;

  HomepageNotifier(this._index);

  int get index => _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }
}

class PageViewNotifier with ChangeNotifier {
  PageController _controller;

  PageController get controller => _controller;

  set controller(PageController value) {
    _controller = value;
    notifyListeners();
  }
}
