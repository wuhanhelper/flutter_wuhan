import 'package:flutter_common_utils/http/http_error.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:wuhan/base/router.dart';
//TODO: dio 代理，联调时取消注释
//import 'package:wuhan/using_proxy.dart';
import 'package:wuhan/utils/lcfarm_util.dart';
import 'package:wuhan/utils/string_util.dart';

///成功回调
typedef SuccessCallback<T> = void Function(T data);

///失败回调
typedef FailureCallback = void Function(HttpError data);

/// @desc  所有地址管理
///@time 2019/3/19 3:58 PM
/// @author chenyun
class Api {
  static const String API_PROPREFIX = 'https://m.wuhan.com';
  //TODO: dio 代理，联调时取消注释
  ///默认服务器地址
//  static const String API_PREFIX = localAPI_PREFIX;

  ///--------------------------------------------------------------------------

  ///取得完成地址
  static String getUrl(String path, {String from}) {
    /// 新增容错判断 - 防止后台下发链接前面带空格识别不了
    if (path != null) {
      path = path.trimLeft();
    }

    if (path.startsWith(Router.scheme)) {
      return path;
    }
    if (path.startsWith("http")) {
      path = appendParams(path, from: from);
      return path;
    }
    String url = getBaseUrl();
    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
    }
    if (path.startsWith("/")) {
      path = path.substring(1);
    }
    path = appendParams(path, from: from);
    return "$url/$path";
  }

  static appendParams(String path, {String from}) {
    if (!StringUtil.isEmpty(from)) {
      if (path.contains("?")) {
        path = "$path&routerName=$from";
      } else {
        path = "$path?routerName=$from";
      }
    }
    return path;
  }

  //解析url上的参数
  static Map<String, String> parseUrlParameter(String url) {
    Uri uri = Uri.parse(url);

    return uri.queryParameters;

//    Map<String, String> map = {};
//    List<String> urlParts = url.split("?");
//
//    if (urlParts.length > 1) {
//      List<String> params = urlParts[1].split("&");
//
//      params.forEach((String f) {
//        List<String> keyValue = f.split("=");
//        if (keyValue.length > 1) {
//          map[keyValue[0]] = keyValue[1];
//        }
//      });
//    }
//
//    return map;
  }

  //去掉url上的参数
  static String cleanParamFromUrl(String url) {
    Uri uri = Uri.parse(url);

    return '${uri.scheme}://${uri.host}${uri.path}';
//
//
//
//    List<String> urlParts = url.split("?");
//
//    if (urlParts.isNotEmpty) {
//
//      return urlParts[0];
//
//    }
//
//    return '';
  }

  static String getBaseUrl() {
    return LcfarmUtil.isTest()
        //TODO: dio 代理，联调时取消注释
//        ? (SpUtil().getString("serverAddress") ?? Api.API_PREFIX)
        ? SpUtil().getString("serverAddress")
        : Api.API_PROPREFIX;
  }
}
