

import 'package:shared_preferences/shared_preferences.dart';


///sp 简单封装
class SharedPreferencesUtils {

  ///sp 保存
  static save(String key,String value) async{
    if(key != null && key != ""){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

  }

  ///sp 获取
  static   Future<String> get(String key) async {
    String result = "";
    if(key != null && key != ""){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      result = prefs.getString(key);
      return result;
    }
  }


}