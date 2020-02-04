import 'dart:ui';

/// @desc:统一颜色管理,格式argb [0-255]，
/// 采用 color前缀+10(10%)两位不透明度百分比+6位颜色值(FFFFFF字母统一大写)
/// @time 2019/3/11 4:31 PM
/// @author chenyun
class LcfarmColor {
  //白色
  static const Color colorFFFFFF = Color(0xffffffff);

  static const Color color40FFFFFF = Color(0x66ffffff);

  static const Color color60FFFFFF = Color(0x99ffffff);

  static const Color color80FFFFFF = Color(0xcdffffff);

  static const Color color20FFFFFF = Color(0x56FFFFFF);

  //黑色
  static const Color color000000 = Color(0xff000000);

  static const Color color10000000 = Color(0x128000000);



  ///相当于#EBEBEB
  static const Color color08000000 = Color(0x14000000);

  static const Color color20000000 = Color(0x20000000);

  ///相当于#C2C2C2
  static const Color color24000000 = Color(0x3D000000);

  ///相当于#999999
  static const Color color40000000 = Color(0x66000000);

  ///相当于#666666
  static const Color color60000000 = Color(0x99000000);

  static const Color color666666 = Color(0xFF666666);
  static const Color colorC08A3A = Color(0xFFC08A3A);

  static const Color color70000000 = Color(0xB3000000);

  ///相当于#33333  #000000 80%
  static const Color color80000000 = Color(0xcc000000);

  //主色
  static const Color color3776E9 = Color(0xff3776E9);
  static const Color color203776E9 = Color(0x333776E9);
  static const Color color053776E9 = Color(0x133776E9);
  static const Color color503776E9 = Color(0x803776E9);

  ///相当于＃EFF4FE
  static const Color color083776E9 = Color(0x143776E9);

  static const Color color3E6BBD = Color(0xff3E6BBD);

  static const Color color074FD1 = Color(0xff074FD1);

  static const Color color3880D9 = Color(0xff3880D9);

  //其他

  static const Color color20FF7070 = Color(0x33ff7070);

  static const Color color05979797 = Color(0x0f979797);

  static const Color colorFF3221 = Color(0xffff3221);

  static const Color colorFF6161 = Color(0xffFF6161);

  static const Color colorFF6060 = Color(0xffFF6060);

  static const Color color70FF6060 = Color(0xb3FF6060);

  static const Color color40FF6060 = Color(0x66FF6060);

  static const Color color20FF6060 = Color(0x33FF6060);

  static const Color colorFF5656 = Color(0xffFF5656);

  static const Color colorF34532 = Color(0xffF34532);

  static const Color color50074FD1 = Color(0x80074FD1);

  static const Color color50D3E6FF = Color(0x80D3E6FF);

  static const Color color333333 = Color(0xff333333);

  static const Color color69C86C = Color(0xff69C86C);

  static const Color color39B25A = Color(0xff39B25A);

  static const Color colorB6B6B6 = Color(0xffB6B6B6);

  static const Color colorDDE1E9 = Color(0xffDDE1E9);

  static const Color colorB0B4BA = Color(0xffB0B4BA);

  static const Color colorCA9455 = Color(0xffCA9455);

  static const Color colorFFFFF3E7 = Color(0xfffff3e7);

  static const Color colorFFF8F2FF = Color(0xfff8f2ff);

  static const Color colorFFFFE2E2 = Color(0xffffe2e2);

  static const Color colorFFFF5656 = Color(0xffff5656);

  static const Color colorFF8A10 = Color(0xffff8a10);

  static const Color colorF7F8FA = Color(0xffF7F8FA);

  static const Color colorD9D9D9 = Color(0xffd9d9d9);

  static const Color color999999 = Color(0xff999999);

  static const Color color454545 = Color(0xff454545);

  static const Color colorDBDBDB = Color(0xffDBDBDB);

  static const Color color00000000 = Color(0x00000000);

  static const Color color1965A3 = Color(0xff1965A3);

  static const Color color1D77FA = Color(0xff1D77FA);
  static const Color color1D77F5 = Color(0xff1D77F5);
  static const Color colorF8F9FB = Color(0xffF8F9FB);

  static const Color colorC64F55 = Color(0xC64F55);
  static const Color colorE3E4E6 = Color(0xffE3E4E6);
  static const Color colorE0C083 = Color(0xffE0C083);
  static const Color colorC0965F = Color(0xffC0965F);
  static const Color colorEEEFF3 = Color(0xffEEEFF3);
  static const Color color30E3E4E6 = Color(0x4DE3E4E6);
  static const Color colorFFF8F9FB = Color(0xFFF8F9FB);
  static const Color colorFFDBDBDB = Color(0xFFDBDBDB);
  static const Color colorFFD8D8D8 = Color(0xFFD8D8D8);
  static const Color colorFFC3C3C3 = Color(0xFFC3C3C3);

  //银行卡蓝色背景
  static const Color color517FE7 = Color(0xFF517FE7);
  //银行卡红色背景
  static const Color colorDB3B49 = Color(0xFFDB3B49);
  //银行卡绿色背景
  static const Color color25A760 = Color(0xFF25A760);
  //银行卡橙色色背景
  static const Color colorF56F27 = Color(0xFFF56F27);

  static const Color colorff7a05 = Color(0xffff7a05);


  // 产品模块40%透明度颜色
  static const Color colorff7a05_40 = Color(0x66ff7a05);
  static const Color color666666_40 = Color(0x66666666);
  static const Color color999999_40 = Color(0x66999999);
  static const Color colorDBDBDB_40 = Color(0x66DBDBDB);
  static const Color colorE0C083_40 = Color(0x66E0C083);
  static const Color colorC0965F_40 = Color(0x66C0965F);
  static const Color colorFFFFFF_40 = Color(0x66ffffff);

  // 80% 透明度
  static const Color colorFFFFFF_80 = Color(0xCCffffff);




  ///
  ///十六进制字符串转color
  ///支持0x和#开头(符号后面是8位)
  ///defColor 转换失败默认的color
  ///
  static  Color hexColor(String source,{Color defColor}){

    String hexColor = '0xffffffff';


    if(source.startsWith("0x") && source.length == 10){
      hexColor = source;
    }

    if(source.startsWith("#") && source.length == 9){
      hexColor = hexColor.replaceAll('#', '0x');
    }


    return Color(int.parse(hexColor,onError: (String s){

      if(defColor != null){
        return defColor.value;
      }else{
        return 0x00000000;
      }

    }));
  }

}
