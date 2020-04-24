import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///常用工具类
class BaseTools {
  ///获取随机数
  static String getNonceStr() {
    //定义随机的字符
    String alphabet =
        'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890';
    // 生成的字符串固定长度
    int strlenght = 16;
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }


  ///验证手机号码格式
  static bool isPhone(String phonenumber) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(phonenumber);
  }

  static bool isEmail(String emailNum) {
    return new RegExp('\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*')
        .hasMatch(emailNum);
  }

  ///判空
  static bool isEmpty(Object object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

  ///获取屏幕宽度
  static double getWidth(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width;
  }

  ///获取屏幕高度
  static double getHeight(BuildContext ctx) {
    return MediaQuery.of(ctx).size.height;
  }

  ///登录密码
  static bool isLoginPassword(String input) {
    RegExp mobile = new RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$");
    return mobile.hasMatch(input);
  }
  ///数字密码
  static bool isValidateCaptcha(String input) {
    RegExp mobile = new RegExp(r"\d{6}$");
    return mobile.hasMatch(input);
  }


 static String requestGetParams(Map<String, String> params) {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      return paramStr;
    }
    return "";
  }

  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }
  static Future byteImage2Base64(ByteData byteData) async {
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return base64Encode(pngBytes);
  }
  ///判断是否可以加载更多
  static bool checkMore(List<dynamic> list) {
    if (list != null) {
      if (list.length >= 8) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

}
