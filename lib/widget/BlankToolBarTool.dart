import 'package:local/widget/ToolBarModel.dart';
import 'package:flutter/material.dart';

/// 用于持有FocusNode的类
class BlankToolBarModel {
  // 点击空白部分用于响应的FocusNode
  FocusNode blankModel=FocusNode();
  // 保存页面中所有InputText绑定的FocusNode
  Map<String,ToolBarModel> focusNodeMap={};

  FocusNode _currentEditingNode;
  // 用于外侧的回调
  VoidCallback outSideCallback;
  BlankToolBarModel({this.outSideCallback});

  /**
   * 通过一个key获取node，一般是通过TextEditingController对象的hashCode
   * TextEditingController nickNameController = TextEditingController();
   * String key = nickNameController.hashCode.toString();
   * FocusNode focusNode = blankToolBarModel.getFocusNode(key);
   */
  FocusNode getFocusNode(String key){
    ToolBarModel barModel = focusNodeMap[key];
    if(barModel == null){
      barModel = ToolBarModel(index: focusNodeMap.length,focusNode: FocusNode());
      barModel.focusNode.addListener(focusNodeListener);
      focusNodeMap[key] = barModel;
    }
    return barModel.focusNode;
  }
  /**
   * 通过controller获取focusNode
   */
  FocusNode getFocusNodeByController(TextEditingController controller){
    String key = controller.hashCode.toString();
    return getFocusNode(key);
  }
  /**
   * 找到正处于编辑状态的FocusNode
   */
  FocusNode findEditingNode(){
    for(ToolBarModel barModel in focusNodeMap.values){
      if(barModel.focusNode.hasFocus){
        return barModel.focusNode;
      }
    }
    return null;
  }
  // 监听FocusNode变化
  Future<Null> focusNodeListener() async {
    FocusNode editingNode = findEditingNode();
    if(_currentEditingNode != editingNode){
      _currentEditingNode = editingNode;
      print('>>>>>>>>+++++++++++');
      if(outSideCallback != null){
        outSideCallback();
      }
    }else{
      print('>>>>>>>>----------');
    }

  }
  /// 移除所有监听
  void removeFocusListeners(){
    for(ToolBarModel barModel in focusNodeMap.values){
      barModel.focusNode.removeListener(focusNodeListener);
    }
  }
  /// 关闭键盘
  void closeKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(blankModel);
  }
}
/**
 * 增加
 * 1、自动处理点击空白页面关闭键盘，
 * 2、键盘上方增加一个toolbar
 */
class BlankToolBarTool{
  static Widget blankToolBarWidget(
      // 上下文
      BuildContext context,
      {
        // 数据model
        BlankToolBarModel model,
        // 要展示的子内容
        Widget body,
        // 是否展示toolBar
        bool showToolBar = true,
        // 默认的toolBar的高度
        double toolBarHeight = 40,
        // toolBar的背景色
        Color toolBarColor = const Color(0xffeeeeee),
        // toolBar的可点击按钮的颜色
        Color toolBarTintColor = Colors.blue
      }
      ){
    if(!showToolBar){
      return GestureDetector(
        onTap: (){
          model.closeKeyboard(context);
        },
        child: body,
      );
    }
    return Stack(
      children: <Widget>[
        Positioned(top: 0,left: 00,bottom: 0,right: 0,child:
        GestureDetector(
          onTap: (){
            model.closeKeyboard(context);
          },
          child: body,
        ),
        ),
        Positioned(top: 0,left: 0,bottom: 0,right: 0,child:
        ToolBar(height: toolBarHeight,
          color: toolBarColor,
          tintColor: toolBarTintColor,
          focusNodeMap: model.focusNodeMap,
          doneCallback: (){
            // 点击空白处的处理
            model.closeKeyboard(context);
          },)
        ),
      ],
    );
  }
}
