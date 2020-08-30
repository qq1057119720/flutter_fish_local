import 'dart:convert';
import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:local/pages/listview_page/PickerData.dart';
import 'package:local/widget/Picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TestListviewState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: SlidingValidation(),
  );
  showPickerModal(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(PickerData)),
        changeToFirst: true,
        hideHeader: false,
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.adapter.text);
        }).showModal(viewService.context); //_scaffoldKey.currentState);
  }

  Widget _buildItemView(int i) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            height: 30,
            child: Text("${i}"),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20),
            child: Text("${i + 1}"),
          ),
          Container(
            height: 30,
            child: Text("${i + 2}"),
          )
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemBuilder: (c, i) => _buildItemView(i),
//        separatorBuilder: (c, i) => Divider(
//          color: UnifiedThemeStyles.backGrayColor,
//        ),
        itemCount: 100);
  }

  ;

  return Scaffold(
    body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            height: 50,
            child: Text("我是个列表啊"),
          ),
          RaisedButton(
            child: Text('Picker Show Modal'),
            onPressed: () {
              showPickerModal(viewService.context);
            },
          ),
//          Container(
//            height: 90,
//        margin: EdgeInsets.only(top: 70),
//            child: _buildListView(),
//          )
        ],
      ),
    ),
  );
}

class SlidingValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.white,
      home: Scaffold(
        body: SafeArea(
          child: _Drag2(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _Drag2 extends StatefulWidget {
  @override
  _DragState2 createState() => new _DragState2();
}
///获取屏幕宽度
 double getWidth(BuildContext ctx) {
return MediaQuery.of(ctx).size.width;
}

///获取屏幕高度
 double getHeight(BuildContext ctx) {
return MediaQuery.of(ctx).size.height;
}

class _DragState2 extends State<_Drag2> with SingleTickerProviderStateMixin {
  //Text 上下间距
  static double textMargin=0;
  //Text 高度
 static double textHeight=20;
  //Text 宽度
  static double textWidth=80;
  //转动的半径
  static double radius=100;

  //text1 的坐标
  double textTop1=radius-sqrt(radius*radius-textWidth*textWidth);
  double textRight1=0;

  //text2 的坐标
  double textTop2=radius;
  double textRight2=radius-textWidth;

  //text3 的坐标
  double textTop3=radius+sqrt(radius*radius-textWidth*textWidth);
  double textRight3=0;

  double textTop4=radius*2;
  double textRight4=-textWidth;
  String text1="课程1";
  String text2="课程2";
  String text3="课程3";
  Color textColor1=Color(0xff8d8d8d);
  Color textColor2=Color(0xff00C569);
  Color textColor3=Color(0xff8d8d8d);
  Color textColor4=Color(0xff8d8d8d);
  //手指按下的坐标
  DragDownDetails downDetails;

  //改变top
  double changeTop(double top,double moveY){
    //先处理 top
    top=top-moveY;
    //如果此时top是0，则将Text移动到最低端
    if(top<=0){
      top=radius*2;
    }
    return top;
  }
  double changeRight(double right,double top,double moveY){
    //需要判断是在上半区还是下半区

    if(top<=radius){
      //上半区
      //计算y
      double y=radius-top+moveY;
      right=sqrt(radius*radius-y*y)-textWidth;
      if(right<=-textWidth){
        right=-80;
      }
    }else{
      //下半区
      //计算y
      double y=top-radius-moveY;
      right=sqrt(radius*radius-y*y)-textWidth;
    }
    if(right.isNaN){
      right=-80;
    }

    println(right.toString()+"-------------");
    return right;
  }

  @override
  Widget build(BuildContext context) {
    double scWidth=getWidth(context);
    double scHeight=getHeight(context);

    //计算
    double res=sqrt(9);
    println(res.toString());
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 100),
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: textTop1,
              right: textRight1,
              child: Container(
                width: textWidth,
                height: textHeight,
                color: Colors.red,
                margin: EdgeInsets.only(top: textMargin,bottom: textMargin),
                child: Text("课程1",style: TextStyle(fontSize: 16),),
              ),
            ),
            Positioned(
              top: textTop2,
              right: textRight2,
              child: Container(
                width: textWidth,
                height: textHeight,
                color: Colors.red,
                margin: EdgeInsets.only(top: textMargin,bottom: textMargin),
                child: Text("课程2",style: TextStyle(fontSize: 16),),
              ),
            ),
            Positioned(
              top: textTop3,
              right: textRight3,
              child: Container(
                width: textWidth,
                height: textHeight,
                color: Colors.red,
                margin: EdgeInsets.only(top: textMargin,bottom: textMargin),
                child: Text("课程3",style: TextStyle(fontSize: 16),),
              ),
            ),
            Positioned(
              top: textTop4,
              right: textRight4,
              child: Container(
                width: textWidth,
                height: textHeight,
                color: Colors.red,
                margin: EdgeInsets.only(top: textMargin,bottom: textMargin),
                child: Text("课程4",style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        ),
        //手指按下时会触发此回调
        onPanDown: (DragDownDetails e) {
          //打印手指按下的位置(相对于屏幕)
          print("用户手指按下：${e.globalPosition}");
          setState(() {
            downDetails=e;
          });
        },
        //手指滑动时会触发此回调
        onPanUpdate: (DragUpdateDetails e) {
//          print("用户手指滑动：${e.globalPosition}");

          //计算Y轴 的移动距离
          print("Y轴移动距离：${downDetails.globalPosition.dy-e.globalPosition.dy}");
          //移动的Y轴的距离，
          double moveY;
        if(downDetails.globalPosition.dy-e.globalPosition.dy>0){
          moveY=(downDetails.globalPosition.dy-e.globalPosition.dy)%radius;
        }else{
          moveY=(e.globalPosition.dy-downDetails.globalPosition.dy)%radius;
        }



          print("moveY：${moveY}");
          moveY=moveY*0.1;
          setState(() {
            /*
                移动轨迹说明：
                当right=textWidth时候，将该text放到最底部
               */
            if(moveY>0){
              textRight1=changeRight(textRight1, textTop1, moveY);
              textTop1=changeTop(textTop1, moveY);

              if(textTop1>radius-20&&textTop1<radius+20){
                textColor1= Color(0xff00C569);
              }else{
                textColor1= Color(0xff8d8d8d);
              }
              println("text one "+textRight1.toString()+"---"+textTop1.toString());
              textRight2=changeRight(textRight2, textTop2, moveY);
              textTop2=changeTop(textTop2, moveY);
              println("text two "+textRight2.toString()+"---"+textTop2.toString());
              textRight3=changeRight(textRight3, textTop3, moveY);
              textTop3=changeTop(textTop3, moveY);
              println("text three "+textRight3.toString()+"---"+textTop3.toString());
              textRight4=changeRight(textRight4, textTop4, moveY);
              textTop4=changeTop(textTop4, moveY);
              println("text four "+textRight4.toString()+"---"+textTop4.toString());
            }


          });

          //用户手指滑动时，更新偏移，重新构建
//          setState(() {
//            _left += e.delta.dx;
//            _top += e.delta.dy;
//
//            double resultsTop = _top - 520;
//            double resultsLeft = _left - 200;
//            bool boolTop = false;
//            bool boolLeft = false;
//            if (resultsLeft < 0 && resultsLeft > -20) {
//              boolLeft = true;
//            } else if (resultsLeft >= 0 && resultsLeft < 20) {
//              boolLeft = true;
//            }
//
//            if (resultsTop < 0 && resultsTop > -20) {
//              boolTop = true;
//            } else if (resultsTop >= 0 && resultsTop < 20) {
//              boolTop = true;
//            }
//            if (boolTop && boolLeft) {
////                    Fluttertoast.showToast(msg: "验证成功");
//
//            }
//          });
        },
        onPanEnd: (DragEndDetails e) {
          //打印滑动结束时在x、y轴上的速度
//          print(_top.toString() + ":" + _left.toString());
//          double resultsTop = _top - 520;
//          double resultsLeft = _left - 200;
//          bool boolTop = false;
//          bool boolLeft = false;
//          if (resultsLeft < 0 && resultsLeft > -20) {
//            boolLeft = true;
//          } else if (resultsLeft >= 0 && resultsLeft < 20) {
//            boolLeft = true;
//          }
//
//          if (resultsTop < 0 && resultsTop > -20) {
//            boolTop = true;
//          } else if (resultsTop >= 0 && resultsTop < 20) {
//            boolTop = true;
//          }
//          if (boolTop && boolLeft) {
////                  Fluttertoast.showToast(msg: "验证成功");
//          } else {
//            setState(() {
//              _top = 60;
//              _left = 60;
//            });
//          }
        },
      ),
    );
  }
}

class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 60.0; //距顶部的偏移
  double _left = 60.0; //距左边的偏移

  double _btop = 520.0; //距顶部的偏移
  double _bleft = 200.0; //距左边的偏移
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: _btop,
            left: _bleft,
            child: GestureDetector(
              child:
                  CircleAvatar(backgroundColor: Colors.green, child: Text("B")),
            ),
          ),
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e) {
                print("用户手指滑动：${e.globalPosition}");
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;

                  double resultsTop = _top - 520;
                  double resultsLeft = _left - 200;
                  bool boolTop = false;
                  bool boolLeft = false;
                  if (resultsLeft < 0 && resultsLeft > -20) {
                    boolLeft = true;
                  } else if (resultsLeft >= 0 && resultsLeft < 20) {
                    boolLeft = true;
                  }

                  if (resultsTop < 0 && resultsTop > -20) {
                    boolTop = true;
                  } else if (resultsTop >= 0 && resultsTop < 20) {
                    boolTop = true;
                  }
                  if (boolTop && boolLeft) {
//                    Fluttertoast.showToast(msg: "验证成功");

                  }
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print(_top.toString() + ":" + _left.toString());
                double resultsTop = _top - 520;
                double resultsLeft = _left - 200;
                bool boolTop = false;
                bool boolLeft = false;
                if (resultsLeft < 0 && resultsLeft > -20) {
                  boolLeft = true;
                } else if (resultsLeft >= 0 && resultsLeft < 20) {
                  boolLeft = true;
                }

                if (resultsTop < 0 && resultsTop > -20) {
                  boolTop = true;
                } else if (resultsTop >= 0 && resultsTop < 20) {
                  boolTop = true;
                }
                if (boolTop && boolLeft) {
//                  Fluttertoast.showToast(msg: "验证成功");
                } else {
                  setState(() {
                    _top = 60;
                    _left = 60;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Color postitiveColor = new Color(0xFFEF0078);
  Color negetiveColor = new Color(0xFFFFFFFF);
  double percentage = 0.0;
  double initial = 0.0;

  double baseX = -1;
  double baseY = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'CUSTOM SLIDER',
          style: TextStyle(color: postitiveColor),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                initial = details.globalPosition.dx;
              },
              onPanUpdate: (DragUpdateDetails details) {
                double distance = details.globalPosition.dx - initial;
                double percentageAddition = distance / 100;

                print('distancex ' + details.globalPosition.dx.toString());
                print('distancey ' + details.globalPosition.dy.toString());
//                setState(() {
//                  print('percentage ' +
//                      (percentage + percentageAddition)
//                          .clamp(0.0, 100.0)
//                          .toString());
//                  percentage =
//                      (percentage + percentageAddition).clamp(0.0, 100.0);
//                });
              },
              onPanEnd: (DragEndDetails details) {
                initial = 0.0;
                percentage = 0;
                print('onPanEnd ');
                print('初始化为0 ');
              },
              child: Container(
                alignment: Alignment(baseX, baseY),
                child: Text("为何物一我hiu"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  double totalWidth = 200.0;
  double totalWidth1 = 160.0;
  double percentage;
  Color positiveColor;
  Color negetiveColor;

  CustomSlider({this.percentage, this.positiveColor, this.negetiveColor});

  @override
  Widget build(BuildContext context) {
    print((percentage / 100) * totalWidth);
    print((1 - percentage / 100) * totalWidth);
    return Container(
//      width: totalWidth + 4.0,
//      height: 30.0,
      alignment: Alignment(0.0, 0.5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Offstage(
            offstage: percentage == 0 ? true : false,
            child: Container(
              decoration: BoxDecoration(
                  color: positiveColor,
                  border: Border.all(
                      color: Colors.yellow, width: percentage == 0 ? 0 : 1)),
              height: 30,
              width: (percentage / 100) * totalWidth1,
            ),
          ),
          Container(
              width: 40,
              child: Image(
                image: AssetImage("assets/images/huakuai_btn.png"),
                width: 40,
                height: 30,
                color: null,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              )),
          Offstage(
            offstage: percentage == 100 ? true : false,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.green, width: percentage == 1 ? 1 : 0)),
              height: 30,
              width: (1 - percentage / 100) * totalWidth1,
            ),
          )
        ],
      ),
    );
  }
}
//创建一个环形链表
class LinkList{
   Node dummyHead;
   int size;
    void add(int index, String t) {
     if (index < 0 || index > size) {
       return;
     }
     Node prev = dummyHead;
     for (int i = 0; i < index ; i++) {
       prev = prev.next;
     }
     prev.next = new Node(t, prev.next);
     prev.next.next=dummyHead;
     size++;
   }
    ///队尾添加
    void addLast(String t) {
     add(size, t);
   }
    String get(int index) {
     if (index < 0 || index > size) {
       return null;
     }
     Node cur = dummyHead.next;
     for (int i = 0; i < index; i++) {
       cur = cur.next;
     }
     return cur.name;
   }
}
class Node{
   String name;
   Node next;
   Node(this.name,this.next);

}