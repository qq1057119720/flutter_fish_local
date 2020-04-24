import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TestListviewState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestListviewState>>{
      TestListviewAction.action: _onAction,
    },
  );
}

TestListviewState _onAction(TestListviewState state, Action action) {
  final TestListviewState newState = state.clone();
  return newState;
}
