
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalThemeStyles{
  ///默认语言
  static Locale themeLocale =Locale('zh', 'CN');

  ///主题色
  static const List<Color> themeColors = <Color>[
    _VIOLET,
    ORANGE,
  ];
  //基本文字颜色
  static const List<Color> baseTitleColor=<Color>[
    READ,
    BLUE
  ];
  ///背景颜色
  static const List<Color> backGroundColor=<Color>[
    BAC_GRAY,
    YELLOW
  ];
  static const Color _VIOLET = const Color(0xFF68129A);
  static const Color MIDDLE_VIOLET = const Color(0xFF431CA7);
  static const Color LIGHT_VIOLET = const Color(0xE5CEED);
  static const Color GREEN = const Color(0xFF11BB0D);
  static const Color READ = const Color(0xFFDE0A0A);
  static const Color ORANGE = const Color(0xFFF9820E);
  static const Color VIOLET_THIN = const Color(0xFFE2D0EC);
  static const Color YELLOW = const Color(0xFFFFEB8C);
  static const Color BLACK = const Color(0xFF000000);
  static const Color BLUE = const Color(0xFF256CEC);
  static const Color BLUE_THIN = const Color(0xFF1B96EB);
  static const Color WHITE = const Color(0xFFFFFFFF);


  static const Color HALF_TRANSPARENT = const Color(0x90000000);
  static const Color BAC_GRAY = const Color(0xFFEBEBEB);
  static const Color FONT_GRAY = const Color(0xFF999999);
  static const Color PLACEHOLDER_GRAY = const Color(0x99999999);
  static const Color PAY_QR_CODE_BACK = const Color(0x4D1B96EB);
  static const Color SCAN_QR_CODE_BACK = const Color(0x4D999999);
  static const Color BASE_FONT_COLOR = const Color(0xFF333333);
  static const Color BASE_YELLOW_COLOR = Color(0xFFFFCC00);
  static const Color SCAN_QR_CODE_BACK12 = Colors.transparent;
  static const Color KEYBOARD_BACK = const Color(0xFFc0c0c0);
}