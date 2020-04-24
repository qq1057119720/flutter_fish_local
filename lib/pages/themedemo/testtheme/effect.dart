import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TestThemeState> buildEffect() {
  return combineEffects(<Object, Effect<TestThemeState>>{
    TestThemeAction.action: _onAction,
    Lifecycle.didChangeDependencies:_didChangeDependencies,
    Lifecycle.deactivate:_deactivate,
    Lifecycle.didChangeAppLifecycleState:_didChangeAppLifecycleState,
    Lifecycle.didUpdateWidget:_didUpdateWidget,
    Lifecycle.dispose:_dispose,
  });
}

void _onAction(Action action, Context<TestThemeState> ctx) {
}
void _didChangeDependencies(Action action, Context<TestThemeState> ctx) {

  println("this is _didChangeDependencies============");
}

void _deactivate(Action action, Context<TestThemeState> ctx) {

  println("this is _deactivate============");
}

void _didChangeAppLifecycleState(Action action, Context<TestThemeState> ctx) {

  println("this is _didChangeAppLifecycleState============");
}
void _didUpdateWidget(Action action, Context<TestThemeState> ctx) {

  println("this is _didUpdateWidget============");
}

//

void _dispose(Action action, Context<TestThemeState> ctx) {

  println("this is _dispose============");
}
