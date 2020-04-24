import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { changeThemeColor, changelanguage ,changeAtNight}

class GlobalActionCreator {
  static Action changeThemeColor(int i) {
    return  Action(GlobalAction.changeThemeColor,payload: i);
  }

  static Action changeLanguage(String language) {
    return Action(GlobalAction.changelanguage, payload: language);
  }

//  static Action changeAtNight(bool atNight) {
//    return Action(GlobalAction.changeAtNight, payload: atNight);
//  }
}
