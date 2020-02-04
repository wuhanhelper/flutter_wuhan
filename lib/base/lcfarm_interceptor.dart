import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_common_utils/date_util.dart';
import 'package:flutter_common_utils/event_manager.dart';
import 'package:flutter_common_utils/http/http_manager.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:wuhan/utils/string_util.dart';

import 'api.dart';
import 'const.dart';
import 'event.dart';

/// @desc 登录状态已过期/账号已被禁用/账号在别处登录，需重新登录。或者时间未同步，需重新请求
/// @time 2019-05-22 15:33
/// @author chenyun
class LcfarmInterceptor extends Interceptor {
  Map<String, int> syncTimeMap;

  LcfarmInterceptor() {
    syncTimeMap = Map();
  }

//  @override
//  onRequest(RequestOptions options) async {
//    //对于主页接口请求，强制依赖时间同步
//    if (options.path == Api.loanDetail) {
//      HttpManager().client.lock();
////      await HttpManager()
////          .requestAsync(
////            url: Api.serverTime,
////          )
////          .then((timestamp) {});
//
//      String timestamp = await syncTime();
//      options.headers.addAll({
//        'sign': "",
//      });
//      //取得同步时间
//      HttpManager().client.unlock();
//    } else {
//      options.headers.addAll({
//        'sign': "",
//      });
//    }
//    return super.onRequest(options);
//  }

  @override
  onResponse(Response response) async {
    if (response.data != null && !(response.data is ResponseBody)) {
      if (response.data is String) {
        response.data = json.decode(response.data);
      }
      String statusCode = response.data["statusCode"];
      String message = response.data["statusDesc"];
      if (!StringUtil.isEmpty(message)) {
        response.data["statusDesc"] = message.replaceAll("<br/>", "\n");
      }
      if (statusCode == Const.loginNotNormal) {
        // 在提交框处理时，假如服务器报loginNotNormal，这时会关闭掉登录弹窗，提交 loading 框无法消失,在统一弹窗管理中已处理掉
        //登录过期，重新登录
        EventManager().post(LoginEvent(Const.loginNotNormal));
        //取消显示错误 toast 提示
        response.data["statusDesc"] = "";
      } else if (statusCode == Const.loggedOnOtherDevices) {
        //多终端登录
        EventManager().post(LoginEvent(Const.loggedOnOtherDevices));
        //取消显示错误 toast 提示
        response.data["statusDesc"] = "";
      } else if (statusCode == Const.timeNotSync) {
        LogUtil.v("时间未同步");
        //不重新请求时间同步接口了，直接取接口返回的timestamp，同步当前时间
        int timestamp = response.data["timestamp"];
        await SpUtil().putInt(
            Const.syncTimeDiff, timestamp - DateUtil.getNowDateMilliseconds());
        //重新请求,最多请求三次。
        String path = response.request.path;
        if (syncTimeMap.containsKey(path)) {
          syncTimeMap.update(path, (int val) => ++val);
          int syncCount = syncTimeMap[path];
          LogUtil.v("时间未同步 $path = $syncCount");
          if (syncCount > 2) {
            LogUtil.v("时间未同步 超过三次");
            return super.onResponse(response);
          }
        } else {
          syncTimeMap[path] = 1;
        }

        return HttpManager().client.request(response.request.path,
            data: response.request.data,
            options: response.request,
            cancelToken: response.request.cancelToken);
      }
    }
    return super.onResponse(response);
  }
}
