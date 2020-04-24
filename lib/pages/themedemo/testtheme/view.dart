import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:local/app_route.dart';
import 'package:local/base_tools.dart';
import 'package:local/constants/global_theme_styles.dart';
import 'package:local/i10n/localization_intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TestThemeState state, Dispatch dispatch, ViewService viewService) {
  println("TestThemeState-------"+AppLocalizations.of(viewService.context)
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
              Navigator.pushNamed(viewService.context, RoutePath.TEST_INTL);
//          _launchURL();
            },
            child: Container(
              child: Text("前去切换页面"),
            ),
          )

,
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(viewService.context, RoutePath.TEST_INTL);
//          _launchURL();
            },
            child: Container(
              child: Text("测试列表"),
            ),
          )
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

