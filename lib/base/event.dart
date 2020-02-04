/// @desc 事件管理
/// @time 2019-04-25 10:36
/// @author chenyun
class RefreshEvent {
  String from;

  RefreshEvent({this.from});
}

///登录事件
class LoginEvent {
  String type;

  LoginEvent(this.type);
}


///全剧配置接口刷新
class ConfigEvent{

}

class DownLoadUrlEvent {
  DownLoadUrlEvent();
}

enum TabbarType {
  home,

  credit,

  wealth
}

///登录事件
class SwitchTabEvent {
  TabbarType type;

  SwitchTabEvent(this.type);
}
