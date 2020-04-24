import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TestThemeState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestThemeState>>{
      TestThemeAction.action: _onAction,
    },
  );
}

TestThemeState _onAction(TestThemeState state, Action action) {
  final TestThemeState newState = state.clone();
  return newState;
}
