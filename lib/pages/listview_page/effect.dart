import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TestListviewState> buildEffect() {
  return combineEffects(<Object, Effect<TestListviewState>>{
    TestListviewAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TestListviewState> ctx) {
}
