import 'package:flutter/foundation.dart';

import 'loader_container.dart';

/// @desc 创建加载状态数据类
/// @time 2019-07-23 15:14
/// @author chenyun
class LoaderNotifier with ChangeNotifier {
  ///加载类型
  LoaderType _loaderType = LoaderType.Loading;

  ///自定义空白视图图片及文本
  String _noDataImgPath;
  String _noDataMessage;

  ///错误代码
  String _errorCode;

  ///错误消息
  String _errorMessage;

  ///是否显示导航栏，为了设置错误跟空白视图距上面的间距
  bool _isAppbarShow = true;

  /// 获取当前加载器的状态
  LoaderType get loaderType => _loaderType;

  ///错误内容
  String get errorMessage => _errorMessage;

  ///错误编码
  String get errorCode => _errorCode;

  ///无数据时提示内容
  String get noDataMessage => _noDataMessage;

  ///无数据时提示图片
  String get noDataImgPath => _noDataImgPath;

  bool get isAppbarShow => _isAppbarShow;

  bool isLoadingSuccess() {
    return loaderType == LoaderType.Success;
  }

  /// 修改状态
  ///
  /// [type]  LoaderType的取值
  void setLoaderType({
    LoaderType type,
    String errorCode,
    String errorMessage,
    String noDataImgPath,
    String noDataMessage,
  }) {
    _loaderType = type;
    _errorCode = errorCode;
    _errorMessage = errorMessage;
    _noDataImgPath = noDataImgPath;
    _noDataMessage = noDataMessage;
    notifyListeners();
  }

  ///设置是否存在 appbar
  ///
  /// [isAppbarShow] appbar 是否显示
  void setAppbarState(bool isShow) {
    _isAppbarShow = isShow;
    notifyListeners();
  }
}
