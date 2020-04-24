import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:local/widget/BlankToolBarTool.dart';

class TextEditState implements Cloneable<TextEditState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  // Step1: 响应空白处的焦点的Node
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  TextEditState clone() {
    return TextEditState()
      ..nameController = nameController
      ..pwdController = pwdController
      ..codeController = codeController
      ..blankToolBarModel = blankToolBarModel;
  }
}

TextEditState initState(Map<String, dynamic> args) {
  return TextEditState();
}
