import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TextEditAction { action ,initState}

class TextEditActionCreator {
  static Action onAction() {
    return const Action(TextEditAction.action);
  }
  static Action onInitState() {
    return const Action(TextEditAction.initState);
  }
}
