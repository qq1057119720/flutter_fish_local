import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ThemeDemoState> buildEffect() {
  return combineEffects(<Object, Effect<ThemeDemoState>>{
    ThemeDemoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ThemeDemoState> ctx) {
}
