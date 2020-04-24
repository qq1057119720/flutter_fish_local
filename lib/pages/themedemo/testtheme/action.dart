import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TestThemeAction { action }

class TestThemeActionCreator {
  static Action onAction() {
    return const Action(TestThemeAction.action);
  }
}
