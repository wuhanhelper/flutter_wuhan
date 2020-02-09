
import 'package:flutter/material.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/home.dart';
import 'package:wuhan/module/login/login_page.dart';
import 'package:wuhan/utils/shared_preferences_utils.dart';

import '../../config.dart';

class SplashPage extends StatefulWidget{
  static const String router = Router.splash;

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}


//class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
class SplashPageState extends State<SplashPage>{


  @override
  void initState() {
    // TODO: implement initState
    getLoginInfo();
    super.initState();
  }

  void getLoginInfo() async{


    String userInfo =  await SharedPreferencesUtils.get(Config.USER_LOGIN_INFO);

    if(userInfo != null && userInfo.trim().length == 11){
      Navigator.pushReplacementNamed(context, Home.router);
    }else{
      Navigator.pushReplacementNamed(context, LoginPageMain.router);

    }




  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container()
    );
  }

}