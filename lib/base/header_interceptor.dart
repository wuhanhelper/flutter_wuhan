import 'package:dio/dio.dart';
import 'package:wuhan/utils/lcfarm_util.dart';

/// @desc  添加 cookie
/// @time 2019/3/18 9:20 AM
/// @author chenyun
class HeaderInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    ///注入公共 header
    options.headers.addAll(await LcfarmUtil.getHeaders());

    return super.onRequest(options);
  }
}
