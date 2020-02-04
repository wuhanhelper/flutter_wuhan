import 'package:flutter/cupertino.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:umeng_share/share_menus.dart';
import 'package:umeng_share/umeng_share.dart';
import 'permissions_manager.dart';

class ShareUtil {
  ///
  /// shareMap = {
  ///   shareType  = 'IMAGE',
  ///   shareImage  = '图片',
  ///   supportPlatform  = '支持平台（可选参数）',
  /// }
  ///
  ///
  /// shareMap = {
  ///   shareType  = 'TEXT',
  ///   title  = '标题',
  ///   content  = '内容',
  ///   url  = 'https://www.nongfadai.com',
  ///   shareImage  = '缩图片（可选参数）',
  ///   supportPlatform  = '支持平台（可选参数）',
  /// }
  ///
  /// 非必传  shareMap['supportPlatform'];
  /// supportPlatform 参数类型 （大写字符串 ）（QQ, WEIXIN, WEIXIN_CIRCLE, QZONE,ALL ）
  /// （ALL 或者不传都是支持所有平台）,多个可以用 '#' 拼接 如：'QQ#WEIXIN#WEIXIN_CIRCLE'
  ///
  ///  shareType 必传 shareMap['shareType'];   分享类型（大写字符串 ） 'TEXT' (文本) , 'IMAGE' (图片)
  ///
  ///  以下根据参数 shareType的 类型 选传
  ///
  ///  当shareType  = 'TEXT'
  ///  shareMap['title'];           标题
  ///  shareMap['content'];         内容
  ///  shareMap['url'];             分享链接
  ///  shareMap['shareImage'];      选传（传了就是缩略图,不传会选默认的桌面icon作为缩略图）可以是 base64(Base64.decode('base64', 2) 或者http/https
  ///
  ///  当shareType = 'IMAGE'
  ///  shareMap['shareImage'];      图片，可以是 base64(Base64.decode('base64', 2) 或者http/https
  ///  缩略图也取shareImage，不传默认会取app的启动图标

  static void share(BuildContext context, Map shareMap,
      {ShareCallback sheetCallback}) {
    LogUtil.v('share shareMap = $shareMap');

    ShareMenus shareMenus = ShareMenus.fromMap(shareMap);

    //android6.0 QQ图片分享需要外部存储权限
    PermissionsManager.storagePermission(context).then((granted) {
      if (granted) {
        UmengShare.openShareWindow(shareMenus);
      }
    });
  }

  ///
  /// supportPlatform  需要分享哪些平台
  ///
  static void appShare(BuildContext context, ShareMenus shareMenus,
      {String supportPlatform, ShareCallback shareCallback}) {
    LogUtil.v('shareMenus = ${shareMenus.toString()}');

    //android6.0 QQ图片分享需要外部存储权限
    PermissionsManager.storagePermission(context).then((granted) {
      if (granted) {
        UmengShare.openShareWindow(shareMenus, callback: shareCallback);
      }
    });
  }
}
