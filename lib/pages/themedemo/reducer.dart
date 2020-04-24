import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' as ma;
import 'package:local/global_store/action.dart';
import 'package:local/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Reducer<ThemeDemoState> buildReducer() {
  return asReducer(
    <Object, Reducer<ThemeDemoState>>{
      ThemeDemoAction.action: _onAction,
      ThemeDemoAction.globalResources: _globalResources,
    },
  );
}

ThemeDemoState _onAction(ThemeDemoState state, Action action) {
  final ThemeDemoState newState = state.clone();
  return newState;
}
ThemeDemoState _globalResources(ThemeDemoState state, Action action) {
  final ThemeDemoState newState = state.clone();
  var resources = action.payload;
//  if (resources is int) {
//    ///切换主题
//    eventBus.fire(GlobalColor(resources));
//  } else if (resources is String) {
//    ///切换语言
//    eventBus.fire(GlobalLanguage(resources));
//
//  }


  return newState;
}
