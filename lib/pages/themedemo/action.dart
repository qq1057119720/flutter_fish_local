import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ThemeDemoAction { action,globalResources, }

class ThemeDemoActionCreator {
  static Action onAction() {
    return const Action(ThemeDemoAction.action);
  }
  static Action globalResources(var resources) {
    return Action(ThemeDemoAction.globalResources, payload: resources);
  }
}
