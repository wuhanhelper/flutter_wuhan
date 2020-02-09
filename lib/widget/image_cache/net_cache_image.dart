import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/widget/image_cache/image_cache_manager.dart';

/// @desp:网络图片缓存
/// @time 2019/10/12 16:33
/// @author lizubing
class NetCacheImage extends StatelessWidget {
  ///网络图片url
  final String imageUrl;

  ///占位图
  final Widget placeholderWidget;

  ///错误页面占位图
  final Widget errorWidget;

  ///渐变淡出动画时间
  final int fadeOutDuration;

  ///渐变淡入动画时间
  final int fadeInDuration;

  ///进一步自定义图片，加边框什么的
  final Widget imageWidget;

  ///图片宽度
  final double width;

  ///图片高度
  final double height;

  ///布局分配空间，填充，平铺...
  final BoxFit fit;

  NetCacheImage(
      {@required this.imageUrl,
      this.placeholderWidget = const CircularProgressIndicator(
        backgroundColor: LcfarmColor.color517FE7,
        strokeWidth: 0.0,
      ),
      this.errorWidget = const Icon(Icons.error),
      this.imageWidget,
      this.width,
      this.height,
      this.fit,
      this.fadeOutDuration = 1,
      this.fadeInDuration = 1});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: ImageCacheManager(),
      imageUrl: imageUrl,
      imageBuilder:
          imageWidget == null ? null : (context, imageProvider) => imageWidget,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholderWidget,
      errorWidget: (context, url, error) => errorWidget,
      fadeOutDuration: Duration(milliseconds: fadeOutDuration),
      fadeInDuration: Duration(milliseconds: fadeInDuration),
    );
  }

  ///提供provider
  static ImageProvider provider({
    @required String url,
    double scale = 1,
    int width,
    int height,
    ErrorListener errorListener,
    Map<String, String> headers,
  }) {
    return CachedNetworkImageProvider(url,
        errorListener: errorListener,
        scale: scale,
//        targetWidth: width,
//        targetHeight: height,
        headers: headers,
        cacheManager: ImageCacheManager());
  }
}
