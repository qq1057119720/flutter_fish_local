import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:local/widget/BlankToolBarTool.dart';
import 'package:local/widget/LoginPage5.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TextEditState state, Dispatch dispatch, ViewService viewService) {
  void checkLogin(){
    print(state.nameController.text);
    print(state.pwdController.text);
    print(state.codeController.text);
  }
  // 创建输入行
  Widget createInputText(TextEditingController controller,{obscureText: false,String hint,IconData icon}){
    // Step5.1 由controller获得FocusNode
    FocusNode focusNode = state.blankToolBarModel.getFocusNodeByController(controller);
    // 输入框
    TextField textField = TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        hintText: hint,
      ),
      obscureText: obscureText,
      // Step5.2 设置FocusNode
      focusNode: focusNode,
    );

    List<Widget> rowList = [];
    // 输入框前的提示图标
    rowList.add(SizedBox(width: 10));
    rowList.add(Icon(icon));
    // 输入框
    rowList.add(Expanded(child: textField));


    return Row(children: rowList);
  }
  Widget createBody(){
    return ListView(
      padding: EdgeInsets.only(left: 20,right: 20),
      children: <Widget>[
        SizedBox(height: 30),
        createInputText(state.nameController,hint: '请输入用户名',icon: Icons.people),
        SizedBox(height: 30),
        createInputText(state.pwdController,hint: '请输入密码',icon: Icons.power,obscureText:true),
        SizedBox(height: 30),
        createInputText(state.codeController,hint: '请输验证码',icon: Icons.nature,obscureText:true),
        SizedBox(height: 30),
        FlatButton(color: Colors.blue,child: Text('登录'),onPressed: checkLogin,)
      ],
    );
  }
  return Scaffold(
    appBar: AppBar(title: Text('登录'),),
    // Step4 用tool创建body
    body: BlankToolBarTool.blankToolBarWidget(
        viewService.context,
        model:state.blankToolBarModel,
        body:createBody()
    ),
  );
}
