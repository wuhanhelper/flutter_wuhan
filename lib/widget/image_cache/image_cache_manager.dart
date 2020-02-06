import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// @desp: 缓存配置
/// @time 2019/10/18 17:11
/// @author lizubing
class ImageCacheManager extends BaseCacheManager {
  ///缓存文件夹名字
  static const key = "ImageCacheManager";

  static ImageCacheManager _instance;

  factory ImageCacheManager() {
    if (_instance == null) {
      _instance = ImageCacheManager._();
    }
    return _instance;
  }

  ImageCacheManager._() : super(key);

  Future<String> getFilePath() async {
    if (Platform.isIOS) {
      /**
        * getExternalStorageDirectory,在iOS上，抛出异常，在Android上，这是getExternalStorageDirectory的返回值
        * getTemporaryDirectory,在iOS上，对应NSTemporaryDirectory（）返回的值，在Android上，这是getCacheDir的返回值。
        * getApplicationDocumentsDirectory,在iOS上，这对应NSDocumentsDirectory，在Android上，这是AppData目录
        **/
      var directory = await getTemporaryDirectory();
      return p.join(directory.path, key);
    } else {
      ///目录存在Android/data/包名/key/目录下
      var directory = await getExternalStorageDirectory();
      return p.join(directory.path, key);
    }
  }
}
