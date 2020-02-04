import 'package:flutter/cupertino.dart';

///
///
/// sharePlatform 参数类型（QQ, WEIXIN, WEIXIN_CIRCLE, QZONE
///
///
///  shareType  分享类型 TEXT(文本) IMAGE(图片)
///
///  title           标题
///  content         内容
///  shareImage      图片，可以是 base64(Base64.decode('base64', 2) 或者http/https
///  url             分享链接
///  缩略图也取shareImage，不传默认会取app的启动图标

class ShareMenus {
  static const String TEXT = 'TEXT';

  static const String IMAGE = 'IMAGE';

  static const types = [TEXT, IMAGE];

  ///分享平台  QQ, WEIXIN, WEIXIN_CIRCLE, QZONE
  String supportPlatform;

  String platformName;

  String platformIcon;

  ///   分享类型
  ///   TEXT  文字分享
  ///   IMAGE  图片分享
  String shareType;

  /// 标题
  String title;

  /// 内容
  String content;

  /// 链接
  String url;

  /// 图片 （以 http, https 开头为网络图片）,
  /// 也可以是base64图片
  String shareImage;

  ///
  /// shareImage图片
  ///
  ShareMenus.imageMenus(this.shareImage, {this.supportPlatform}) {
    this.shareType = IMAGE;
    if (supportPlatform == null) {
      supportPlatform = 'ALL';
    }
  }

  ///
  /// title标题
  /// content内容
  /// url链接
  /// shareImage缩略图
  ///
  ShareMenus.textMenus(
      {@required this.title, @required this.content, @required this.url, this.shareImage, this.supportPlatform}) {
    this.shareType = TEXT;

    if (supportPlatform == null) {
      supportPlatform = 'ALL';
    }

  }


  @override
  String toString() {
    return 'ShareMenus{supportPlatform: $supportPlatform, platformName: $platformName, platformIcon: $platformIcon, shareType: $shareType, title: $title, content: $content, url: $url, shareImage: $shareImage}';
  }

  Map toShareMap() {
    Map map = {
      "shareType": shareType,
      "title": title,
      "content": content,
      "shareImage": shareImage,
      "url": url,
      "supportPlatform": supportPlatform,
    };

    return map;
  }

  ShareMenus.fromMap(Map map) {

    this.shareType = map['shareType']; //分享类型   TEXT(文本)  IMAGE(图片)  必传

    if (this.shareType == null || !types.contains(shareType)) {
      print('ShareMenus fromMap shareType 不正确');
    }

    this.title = map['title']; //标题
    this.content = map['content']; //内容
    this.shareImage = map['shareImage']; //图片，可以是 base64 或者http/https
    this.url = map['url']; //分享链接
    this.supportPlatform =
    map['supportPlatform'] == null ? 'ALL' : map['supportPlatform'];
  }
}

