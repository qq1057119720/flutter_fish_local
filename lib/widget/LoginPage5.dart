import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:local/widget/BlankToolBarTool.dart';

class LoginPage5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPage5State();
  }
}

class LoginPage5State extends State<LoginPage5> with WidgetsBindingObserver{
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // Step1: 响应空白处的焦点的Node
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();
  @override
  void initState() {
    // Step2.1: 焦点变化时的响应
    blankToolBarModel.outSideCallback = focusNodeChange;
    super.initState();
  }
  // Step2.2: 焦点变化时的响应操作
  void focusNodeChange(){
    println("被调用了--------");
    setState(() {});
  }
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        println("hhhhhhh--------");
//        widget.keyboardShowCallback
//            ?.call(MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  void dispose() {
    // Step3: 在销毁页面时取消监听
    blankToolBarModel.removeFocusListeners();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    println("我刷新了--------");
    return Scaffold(
      appBar: AppBar(title: Text('登录'),),
      // Step4 用tool创建body
      body: BlankToolBarTool.blankToolBarWidget(
          context,
          model:blankToolBarModel,
          body:createBody()
      ),
    );
  }

  Widget createBody(){
    return ListView(
      padding: EdgeInsets.only(left: 20,right: 20),
      children: <Widget>[
        SizedBox(height: 30),
        createInputText(nameController,hint: '请输入用户名',icon: Icons.people),
        SizedBox(height: 30),
        createInputText(pwdController,hint: '请输入密码',icon: Icons.power,obscureText:true),
        SizedBox(height: 30),
        createInputText(codeController,hint: '请输验证码',icon: Icons.nature,obscureText:true),
        SizedBox(height: 30),
        FlatButton(color: Colors.blue,child: Text('登录'),onPressed: checkLogin,)
      ],
    );
  }

  // 创建输入行
  Widget createInputText(TextEditingController controller,{obscureText: false,String hint,IconData icon}){
    // Step5.1 由controller获得FocusNode
    FocusNode focusNode = blankToolBarModel.getFocusNodeByController(controller);
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

  // 点击登录处理
  void checkLogin(){
    print(nameController.text);
    print(pwdController.text);
    print(codeController.text);
  }

}
