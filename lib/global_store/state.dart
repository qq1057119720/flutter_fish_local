import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState<T extends Cloneable<T>> implements Cloneable<T> {
  int get theme;
  set theme(int theme);
  Locale get languageLocale;
  set languageLocale(Locale languageLocale);
  bool get isAtNight;
  set isAtNight(bool isAtNight);
}

class GlobalState implements GlobalBaseState<GlobalState> {
  @override
  int theme=0;
  @override
  Locale languageLocale;
  @override
  bool isAtNight;

  @override
  GlobalState clone() {
    // TODO: implement clone
    return GlobalState()
      ..theme = theme
      ..isAtNight = isAtNight
      ..languageLocale = languageLocale;
  }
}
