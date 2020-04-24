import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCgmwebview {


  static FlutterCgmwebview _instance;

  static FlutterCgmwebview get instance => _getInstance();

  factory FlutterCgmwebview() => _getInstance();

  static FlutterCgmwebview _getInstance() {
    if (_instance == null) {
      _instance = FlutterCgmwebview._internal();
    }
    return _instance;
  }

  FlutterCgmwebview._internal() {}

  static const MethodChannel _channel =
  const MethodChannel('flutter_cgmwebview');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///打开webview
  Future<Map> openWebView(String url) async {
    Map params = <String, dynamic>{
      "url": url,
    };
    return await _channel.invokeMethod('openwebview', params);
  }
  ///将订单详细信息传给webview
  Future<Map> ordermsg(Map<String, dynamic> orderMsg) async {
    return await _channel.invokeMethod('ordermsg', orderMsg);
  }
  ///将支付结果传给webview
  Future<Map> payResult(Map<String, dynamic> orderMsg) async {
    return await _channel.invokeMethod('payResult', orderMsg);
  }
  ///分享邀请码
  Future<Map> shareInvite(Map<String, dynamic> orderMsg) async {
    return await _channel.invokeMethod('shareinvite', orderMsg);
  }
  ///flutter 操作关闭webview
  Future<Map> closeWebView() async {
    return await _channel.invokeMethod('closewebview', null);
  }
}
