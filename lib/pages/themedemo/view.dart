import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:local/base_tools.dart';
import 'package:local/constants/global_theme_styles.dart';
import 'package:local/global_store/action.dart';
import 'package:local/global_store/store.dart';
import 'package:local/i10n/localization_intl.dart';
import 'package:url_launcher/url_launcher.dart';


import 'action.dart';
import 'state.dart';

Widget buildView(ThemeDemoState state, Dispatch dispatch, ViewService viewService) {
  println("ThemeDemoState------"+AppLocalizations.of(viewService.context)
      .testintl);
  println(AppLocalizations.of(viewService.context).locale.toString());
  return Scaffold(
    backgroundColor: GlobalThemeStyles.backGroundColor[state.theme],
    body: SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[

          Container(
            height: 50,
            width: BaseTools.getWidth(viewService.context),
            color: GlobalThemeStyles.themeColors[state.theme],
            alignment: Alignment.center,
            child: Text("标题"),
          ),
          Container(
            child: Text(AppLocalizations.of(viewService.context)
                .testintl,style: TextStyle(color: GlobalThemeStyles.baseTitleColor[state.theme]),
                ),
          ),

          GestureDetector(
            onTap: (){
              println("切换中英文");
              GlobalStore.store.dispatch(GlobalActionCreator.changeLanguage("en"));
            },
            child: Container(
              child: Text("切换英文"),
            ),
          ),
          GestureDetector(
            onTap: (){
              println("切换中英文");
              GlobalStore.store.dispatch(GlobalActionCreator.changeLanguage("zh"));
            },
            child: Container(
              child: Text("切换中文"),
            ),
          ),


          GestureDetector(
            onTap: (){
              GlobalStore.store.dispatch(GlobalActionCreator.changeThemeColor(0));
            },
            child: Container(
              child: Text("切换主题1"),
            ),
          ),


          GestureDetector(
            onTap: (){
              _launchURL();
//              GlobalStore.store.dispatch(GlobalActionCreator.changeThemeColor(1));
            },
            child: Container(
              child: Text("切换主题2"),
            ),
          ),
        ],
      ),
    ),
  );
}
_launchURL() async {
  String url ="taobao://";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
