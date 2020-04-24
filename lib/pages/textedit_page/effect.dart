import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'action.dart';
import 'state.dart';

Effect<TextEditState> buildEffect() {
  return combineEffects(<Object, Effect<TextEditState>>{
    TextEditAction.action: _onAction,
    Lifecycle.initState: _initState,
  });
}

void _onAction(Action action, Context<TextEditState> ctx) {
}

void _initState(Action action, Context<TextEditState> ctx) {
  void focusNodeChange(){
   ctx.dispatch(TextEditActionCreator.onInitState());
  }
 ctx.state.blankToolBarModel.outSideCallback = focusNodeChange;
 cup.WidgetsBinding.instance.addPostFrameCallback((_){
   println("hhhhhhh------------------------");
 });
}
