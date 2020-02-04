///对话框消失回调，[byCanceled] 直接关闭
typedef OnDismiss = Function(bool byCanceled);

/// @desc  常量管理
/// @time 2019-04-22 14:15
/// @author chenyun
class Const {
  ///弹窗回调
  static const String ok = "ok";
  static const String cancel = "cancel";

  ///经纬度
  static const String longitude = "longitude";
  static const String latitude = "latitude";

  ///省
  static const String province = "province";

  ///市
  static const String city = "city";

  ///区
  static const String district = "district";

  ///登录 token
  static const String loginType = "loginType"; //登录类型
  static const String token = "token";
  static const String username = "username";
  static const String CUST_ID = "custId";
  static const String innerCust = "innerCust";

  ///服务器时间差
  static const String syncTimeDiff = "syncTimeDiff";

  ///最后响应时间，用于超过5分钟唤醒时校验指纹
  static const String lastResponseTime = "lastResponseTime";

  ///服务器时间差
  static const String tokenKey = "tokenKey";

  ///登录状态已过期/账号已被禁用/账号在别处登录，需重新登录。
  static const String loginNotNormal = "LOGIN_NOT_NORMAL";

  ///时间未同步，需同步时间,重新再发起请求。
  static const String timeNotSync = "TIME_NOT_SYNC";

  static const String loggedOnOtherDevices = "LOGGED_ON_OTHER_DEVICES";

  ///修改预留手机号需要重新登录
  static const String noAuth = "NO_AUTH";

  ///数据查询失败，结果数据为空
  static const String resultNullCode = "APP_RESULT_NULL";
  static const String resultNullMessage = "数据查询失败";
  static const String resultEmptyArray = "没有相关数据";

  ///来源
  static const String fromLogin = "fromLogin";
  static const String fromRegister = "fromRegister";
  static const String fromLogout = "fromLogout";

  ///提款成功页，回到主页
  static const String fromWithdrawalSuccess = "fromWithdrawalSuccess";

  ///从后台呼起
  static const String fromBackground = "fromBackground";

  ///启动
  static const String fromStart = "fromStart";
  static const String AUTH_PWD = "AUTH_PWD";

  ///是否版本更新
  static const String CHECK_VERSION = "CHECK_VERSION";

  ///记录后台的版本信息
  static const String CHECK_VERSION_CODE = "CHECK_VERSION_CODE";

  ///------------常量配置接口字段--------------------
  static const String HOME_LEFT_TAB = 'leftTab';
  static const String HOME_RIGHT_TAB = 'rightTab';
  static const String HOME_MID_TAB = 'midTab';

  ///------------常量配置接口字段 end --------------------

}

enum GestureStatus {
  create,
  createFailed,
  verify,
  verifyFailed,
  verifyFailedCountOverflow
}
