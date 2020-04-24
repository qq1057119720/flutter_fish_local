import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ToolBarModel {
  int index;
  FocusNode focusNode;
  ToolBarModel({this.index,this.focusNode});
}
class ToolBar extends StatefulWidget {
  Map <String,ToolBarModel> focusNodeMap;
  VoidCallback doneCallback;
  double height=40;
  Color color = Color(0xffeeeeee);
  Color tintColor = Colors.blue;

  ToolBar({this.focusNodeMap,this.doneCallback,this.height=40,this.color = const Color(0xffeeeeee),this.tintColor = Colors.blue});

  @override
  State<StatefulWidget> createState() {
    return ToolBarState(focusNodeMap: focusNodeMap,
        doneCallback: doneCallback,
        height: height,
        color: color,
        tintColor: tintColor);
  }
}
class ToolBarState extends State<ToolBar>{
  Map <String,ToolBarModel> focusNodeMap;
  VoidCallback doneCallback;
  double height=40;
  Color color = Color(0xffeeeeee);
  Color tintColor = Colors.blue;
  ToolBarState({this.focusNodeMap,this.doneCallback,this.height=40,this.color = const Color(0xffeeeeee),this.tintColor = Colors.blue});
  @override
  Widget build(BuildContext context) {
    ToolBarModel barModel = currentEditingFocusNode();
    if(barModel == null){
      // 没有任何输入框处于编辑状态，则返回的是0高度的容器
      return Column(children: <Widget>[
        Flexible(child: Container()),
        Container(height: 0)
      ],
      );
    }else{
      return Column(children: <Widget>[
        Flexible(child: Container()),
        createToolBar(barModel)
      ],
      );
    }
  }
  Widget createToolBar(ToolBarModel barModel){
    // 有输入框在编辑状态
    int currentIndex = barModel.index;
    bool isFirst = currentIndex==0;
    bool isLast = currentIndex==(focusNodeMap.length-1);
    // 前一个
    Widget preIcon = Icon(Icons.arrow_forward_ios,
      color: isFirst?Colors.grey:tintColor,size: 20.0,);
    Widget preBtn = InkWell(
      child:Transform(
          transform: Matrix4.identity()..rotateZ(math.pi),// 旋转的角度
          origin: Offset(10,10),
          child: preIcon
      ),
      onTap: (){
        focusNodeAtIndex(currentIndex-1);
      },
    );
    // 下一个
    Widget nextBtn = InkWell(
      child:Icon(Icons.arrow_forward_ios,
        color:isLast?Colors.grey:tintColor,
        size: 20,),
      onTap:(){
        focusNodeAtIndex(currentIndex+1);
      },
    );

    // 关闭
    // Widget doneBtn = CupertinoButton(
    //   child: Container(height: 40,width: 200,child: Text('关闭')),
    //   onPressed: doneCallback
    // );
    Widget doneBtn = InkWell(
        child: Text('关闭',style: TextStyle(color: tintColor),),
        onTap: doneCallback
    );

    return Container(
      height: height,color: color,
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Row(
        children: <Widget>[
          preBtn,
          SizedBox(width: 40,),
          nextBtn,
          Flexible(child: Container(),),
          doneBtn
        ],
      ),
    );
  }
  // 获取当前获得焦点的对象
  ToolBarModel currentEditingFocusNode(){
    for(ToolBarModel barModel in focusNodeMap.values){
      if(barModel.focusNode.hasFocus){
        return barModel;
      }
    }
    return null;
  }
  /// 让指定的某个node获得焦点
  void focusNodeAtIndex(int selectIndex){
    if(selectIndex<0||selectIndex>=focusNodeMap.length){
      return;
    }
    for(ToolBarModel barModel in focusNodeMap.values){
      if(selectIndex == barModel.index){
        barModel.focusNode.requestFocus();
        setState(() {

        });
        return;
      }
    }
  }
}
