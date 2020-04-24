package com.cgm.flutter.cgmwebview;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.webkit.ValueCallback;
import android.webkit.WebView;

import com.cgm.flutter.cgmwebview.activity.ShareViewActivity;
import com.cgm.flutter.cgmwebview.activity.WebViewActivity;
import com.cgm.flutter.cgmwebview.ui.PayOrderPopup;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterCgmwebviewPlugin */
public class FlutterCgmwebviewPlugin implements MethodCallHandler, PayOrderPopup.PayClickListener {


  private static FlutterCgmwebviewPlugin instance;
  private static final String CHANNEL = "flutter_cgmwebview";
  private FlutterActivity activity;
  public static Result pendingResult;
  public static Context context;
  public static WebView webView;
  public static WebViewActivity webViewActivity;
  private  Map<String,Object> orderMap;
  private final static String GET_PLATFROM_VERSION="getPlatformVersion";
  private final static String ORDER_MSG="ordermsg";
  private final static String PAY_RESULT="payResult";
  private final static String SHARE_INVITE="shareinvite";
  private final static String CLOSE_WEBVIEW="closewebview";
  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    if (instance == null) {
      final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
      instance = new FlutterCgmwebviewPlugin((FlutterActivity) registrar.activity());
      channel.setMethodCallHandler(instance);
    }
  }

  public FlutterCgmwebviewPlugin(FlutterActivity activity) {
    this.activity = activity;
  }


  @Override
  public void onMethodCall(MethodCall call, Result result) {
    pendingResult = result;
    if (call.method.equals(GET_PLATFROM_VERSION)) {
      result.success("Android " + Build.VERSION.RELEASE);
    }else if (call.method.equals("openwebview")) {
      Map<String,Object> map=(Map<String,Object>)call.arguments;
      Intent intent = new Intent(activity, WebViewActivity.class);
      intent.putExtra("url", map.get("url").toString());
      activity.startActivity(intent);
    }else if (call.method.equals(ORDER_MSG)) {

      orderMap=(Map<String,Object>)call.arguments;

      new PayOrderPopup(context,orderMap,this).showPopupWindow();
    }else if (call.method.equals(PAY_RESULT)) {
      Map<String,Object> map=(Map<String,Object>)call.arguments;

      if (map.get("message")!=null){
          if (map.get("message").toString().equals("2")){
              webView.goBack();
              return;
          }
      }
      if (map.get("resulturl")!=null){
        webView.loadUrl(map.get("resulturl").toString());
      }
      //http://www.kakacoin.net/site/success
//      webView.loadUrl("http://www.kakacoin.net/site/success");
//      Map<String,Object> map=(Map<String,Object>)call.arguments;
//      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
//        webView.evaluateJavascript("javascript:cgmcommPayMessage('"+map.get("orderId").toString()+"','"+map.get("message").toString()+"')", new ValueCallback<String>() {
//          @Override
//          public void onReceiveValue(String value) {
//            Log.d("onReceiveValue:",value);
//          }
//        });
//      }
        //通知h5
    }else if (call.method.equals(SHARE_INVITE)) {

        Map<String,Object> map=(Map<String,Object>)call.arguments;
        Intent intent = new Intent(activity, ShareViewActivity.class);
        intent.putExtra("shareurl", map.get("shareurl").toString());
        intent.putExtra("backurl", map.get("backurl").toString());
        intent.putExtra("invitecode", map.get("invitecode").toString());
        activity.startActivity(intent);

    }
    else if (call.method.equals(CLOSE_WEBVIEW)) {
      webViewActivity.finish();
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void payPassFinish(String passContent) {
    Log.v("userlogin",orderMap.get("orderId")+"----"+orderMap.get("payToken")+"----"+orderMap.get("payPassword")+"-------------开始支付");
    Map<Object, Object> map = new HashMap<>();
    map.put("type","success");
    map.put("authority","payOrder");
    map.put("payToken", orderMap.get("payToken").toString());
    map.put("orderId", orderMap.get("orderId").toString());
    map.put("payPassword", passContent);
    if (pendingResult!=null){
      pendingResult.success(map);
      pendingResult=null;
    }

  }

  @Override
  public void payClose() {
    webView.goBack();
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
      webView.evaluateJavascript("javascript:cgmcommPayMessage('"+orderMap.get("orderId").toString()+"','0')", new ValueCallback<String>() {
        @Override
        public void onReceiveValue(String value) {
          Log.d("onReceiveValue:",value);
        }
      });
    }
  }
}
