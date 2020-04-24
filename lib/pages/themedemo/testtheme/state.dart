import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:local/global_store/state.dart';
class TestThemeState implements GlobalBaseState<TestThemeState> {

  @override
  Locale languageLocale;
  @override
  int theme;
  @override
  bool isAtNight;
  @override
  TestThemeState clone() {
    return TestThemeState()..languageLocale=languageLocale..theme=theme;
  }
}

TestThemeState initState(Map<String, dynamic> args) {
  return TestThemeState();
}
