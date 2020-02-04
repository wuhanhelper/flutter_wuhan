import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';

import 'lcfarm_color.dart';

/// @desc: 格式 颜色_字号  废弃
/// 静态只初始化一次（屏幕大小未取得，算出有问题），再次 build 时不会重新去计划
/// style前缀+10(10%)两位不透明度百分比+6位颜色值(FFFFFF字母统一大写)+下划线+字号大小
/// @time 2019/3/13 4:44 PM
/// @author chenyun
class LcfarmStyle {
  ///白色相关字号
  static final TextStyle styleFFFFFF_10 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(10),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF7A05_32_m = TextStyle(
    color: LcfarmColor.colorff7a05,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFF7A05_30_m = TextStyle(
    color: LcfarmColor.colorff7a05,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.w500,
  );
  static final TextStyle styleFF7A05_30_m_40 = TextStyle(
    color: LcfarmColor.colorff7a05_40,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFF7A05_20_m = TextStyle(
    color: LcfarmColor.colorff7a05,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.w500,
  );
  static final TextStyle styleFF7A05_20_m_40 = TextStyle(
    color: LcfarmColor.colorff7a05_40,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFF7A05_13 = TextStyle(
    color: LcfarmColor.colorff7a05,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFF7A05_14 = TextStyle(
    color: LcfarmColor.colorff7a05,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFFFFFF_12 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_12_m = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFFFFFF_12_m_40 = TextStyle(
    color: LcfarmColor.colorFFFFFF_40,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.w500,
  );
  static final TextStyle styleFFFFFF_12_m_80 = TextStyle(
    color: LcfarmColor.colorFFFFFF_80,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFFFFFF_13 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );



  static final TextStyle styleFFFFFF_13_m = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFFFFFF_13_m_40 = TextStyle(
    color: LcfarmColor.colorFFFFFF_40,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );
  static final TextStyle styleFFFFFF_13_m_80 = TextStyle(
    color: LcfarmColor.colorFFFFFF_80,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle styleFFFFFF_14 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_44 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(44),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60FFFFFF_12 = TextStyle(
    color: LcfarmColor.color60FFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style20FFFFFF_12 = TextStyle(
    color: LcfarmColor.color20FFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style20FFFFFF_13 = TextStyle(
    color: LcfarmColor.color20FFFFFF,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style20FFFFFF_16 = TextStyle(
    color: LcfarmColor.color20FFFFFF,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_18 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_16 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFFFFFF_22 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(22),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_20 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_24 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_32 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFFFFFF_34 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(34),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_36 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(36),
    fontWeight: FontWeight.normal,
  );

  ///黑色相关

  static final TextStyle style000000_12 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_14 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_16 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_14 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_14 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_18 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_18_m = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style000000_22 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(22),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle style000000_22_m = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(22),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style000000_22_w600 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(22),
    fontWeight: FontWeight.w600,
  );
  static final TextStyle style000000_20 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_28 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(28),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_30 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style333333_18_m = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style333333_18_w600 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.w600,
  );

  static final TextStyle style80000000_46 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(46),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style08000000_12 = TextStyle(
    color: LcfarmColor.color08000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_12 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_16 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_12 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_13 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_14 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_15 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(15),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_16 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_18 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_20 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_24 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_11 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_11 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_14 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_14_40 = TextStyle(
    color: LcfarmColor.color666666_40,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_15_m = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(15),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style666666_15_m_40 = TextStyle(
    color: LcfarmColor.color666666_40,
    fontSize: LcfarmSize.sp(15),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style666666_13 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_16 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleC08A3A_12 = TextStyle(
    color: LcfarmColor.colorC08A3A,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleC08A3A_11 = TextStyle(
    color: LcfarmColor.colorC08A3A,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style666666_20 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle style666666_28 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(28),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_12 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_14 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_16 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_18 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_12 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_16 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_18 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_20 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_24 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_32 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_36 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(36),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_48 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(48),
    fontWeight: FontWeight.normal,
  );

  ///主色相关
  static final TextStyle style3776E9_10 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(10),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_11 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_12 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_13 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_14 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_15 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(15),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_18 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle style3776E9_16 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_32 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style503776E9_14 = TextStyle(
    color: LcfarmColor.color503776E9,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style074FD1_14 = TextStyle(
    color: LcfarmColor.color074FD1,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleD9D9D9_14 = TextStyle(
    color: LcfarmColor.colorD9D9D9,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style999999_13 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style999999_13_40 = TextStyle(
    color: LcfarmColor.color999999_40,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style999999_13_m = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style999999_13_m_40 = TextStyle(
    color: LcfarmColor.color999999_40,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style999999_14 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style454545_14 = TextStyle(
    color: LcfarmColor.color454545,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style454545_16 = TextStyle(
    color: LcfarmColor.color454545,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style074FD1_16 = TextStyle(
    color: LcfarmColor.color074FD1,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style074FD1_20 = TextStyle(
    color: LcfarmColor.color074FD1,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  ///colorFF6060相关
  static final TextStyle styleFF6060_14 = TextStyle(
    color: LcfarmColor.colorFF6060,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_14 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF6060_18 = TextStyle(
    color: LcfarmColor.colorFF6060,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_18 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style70FF6060_12 = TextStyle(
    color: LcfarmColor.color70FF6060,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_12 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF3221_14 = TextStyle(
    color: LcfarmColor.colorFF3221,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF3221_12 = TextStyle(
    color: LcfarmColor.colorFF3221,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  ///colorFF5656相关
  static final TextStyle styleFF5656_12 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(12),
  );

  static final TextStyle styleFF5656_14 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle styleFF5656_16 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(16),
  );

  static final TextStyle styleFF5656_24 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFF5656_30 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleFF5656_46 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(46),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleC3C3C3_14 = TextStyle(
    color: LcfarmColor.colorFFC3C3C3,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle styleC3C3C3_18 = TextStyle(
    color: LcfarmColor.colorFFC3C3C3,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleC3C3C3_18_m = TextStyle(
    color: LcfarmColor.colorFFC3C3C3,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style333333_16 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style333333_16_m = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle style333333_30 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleF34532_14 = TextStyle(
    color: LcfarmColor.colorF34532,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style333333_13_m = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.w500,
  );
  static final TextStyle style333333_13 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );
  static final TextStyle style333333_14 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );
}
