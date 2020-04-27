// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.webviewflutter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import io.flutter.Log;
import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * Java platform implementation of the webview_flutter plugin.
 *
 * <p>Register this in an add to app scenario to gracefully handle activity and context changes.
 *
 * <p>Call {@link #registerWith(Registrar)} to use the stable {@code io.flutter.plugin.common}
 * package instead.
 */
public class WebViewFlutterPlugin implements FlutterPlugin, PluginRegistry.ActivityResultListener , ActivityAware {

  private FlutterCookieManager flutterCookieManager;
  public static Activity activity;
 private WebViewFactory factory;
  public WebViewFlutterPlugin() {}
  public static void registerWith(Registrar registrar) {
    registrar
        .platformViewRegistry()
        .registerViewFactory(
            "plugins.flutter.io/webview",
            new WebViewFactory(registrar.messenger(), registrar.view()));

    Log.v("userlogin","我要走着");
    new FlutterCookieManager(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    Log.v("userlogin","onAttachedToEngine");
    BinaryMessenger messenger = binding.getBinaryMessenger();
    factory=new WebViewFactory(messenger, null);
    binding
        .getFlutterEngine()
        .getPlatformViewsController()
        .getRegistry()
        .registerViewFactory(
            "plugins.flutter.io/webview",factory);
    Context appContext = binding.getApplicationContext();
//    binding.getApplicationContext()
    if (appContext instanceof FlutterApplication) {
      Activity currentActivity = ((FlutterApplication) appContext).getCurrentActivity();
      if (currentActivity != null) {
        activity = currentActivity;
      }
    }
    flutterCookieManager = new FlutterCookieManager(messenger);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    if (flutterCookieManager == null) {
      return;
    }
    activity=null;
    flutterCookieManager.dispose();
    flutterCookieManager = null;
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    Log.v("userlogin","onActivityResult in plugin");
    if (factory!=null&&factory.getFlutterWebView()!=null){
        return factory.getFlutterWebView().activityResult(requestCode,resultCode,data);
    }
    return false;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    Log.v("userlogin","onAttachedToActivity");
    activity=binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }


}
