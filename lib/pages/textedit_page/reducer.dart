import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TextEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<TextEditState>>{
      TextEditAction.initState: _initState,
    },
  );
}

TextEditState _initState(TextEditState state, Action action) {
  final TextEditState newState = state.clone();
  return newState;
}
