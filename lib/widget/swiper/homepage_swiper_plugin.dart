import 'package:flutter/cupertino.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomepageSwiperPlugin extends SwiperPlugin {
  HomepageSwiperPlugin();

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Container(
        height: LcfarmSize.dp(30),
    );
  }
}
