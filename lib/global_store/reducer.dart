import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux/fish_redux.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:local/cache/local_storage.dart';
import 'package:local/i10n/localization_delegate.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _changeThemeColor,
      GlobalAction.changelanguage: _changeLanguage,
      GlobalAction.changeAtNight: _changeAtNight,
    },
  );
}

GlobalState _changeThemeColor(GlobalState state, prefix0.Action action) {
  int _themeIndex = action.payload;
  GlobalState _globalState = state.clone();
  _globalState.theme=_themeIndex;
  LocalStorage.saveLocalThemeResources(_themeIndex);
  return _globalState;
}

GlobalState _changeLanguage(GlobalState state, prefix0.Action action) {
  GlobalState _globalState = state.clone();
  String _lanauage = action.payload;
  if(_lanauage=="en"){
    _globalState.languageLocale = Locale('en', 'US');
  }else{
    _globalState.languageLocale  = Locale('zh', 'CN');
  }
  AppLocalizationsDelegate.delegate.load(_globalState.languageLocale );
  LocalStorage.saveLocalThemeResources(_lanauage);
  return _globalState;
}

GlobalState _changeAtNight(GlobalState state, prefix0.Action action) {
  bool _atNight = action.payload;
//  _atNight ? Screen.setBrightness(0.3) : Screen.setBrightness(-1);
  return state.clone()..isAtNight = _atNight;
}
