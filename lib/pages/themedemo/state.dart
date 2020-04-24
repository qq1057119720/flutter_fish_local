import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:local/global_store/state.dart';

class ThemeDemoState implements GlobalBaseState<ThemeDemoState> {


  @override
  bool isAtNight;
  @override
  Locale languageLocale;
  @override
  int theme;

  @override
  ThemeDemoState clone() {
    return ThemeDemoState()..languageLocale=languageLocale..theme=theme;
  }
}

ThemeDemoState initState(Map<String, dynamic> args) {
  return ThemeDemoState();
}
