package com.cgm.flutter.cgmwebview.activity;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.ClipData;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.cgm.flutter.cgmwebview.R;
import com.cgm.flutter.cgmwebview.FlutterCgmwebviewPlugin;
import com.cgm.flutter.cgmwebview.utils.StatusBarTxtUtil;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class WebViewActivity extends Activity {
    WebView webView;
    ProgressBar progressBar;
    private WebSettings webSetting;

    private LinearLayout llTopView;

    private RelativeLayout rlTopview;

    private TextView tvTitle;

    private View vStatus;
    public String url;
    private ValueCallback<Uri> uploadMessage;
    private ValueCallback<Uri[]> uploadMessageAboveL;
    private final static int FILE_CHOOSER_RESULT_CODE = 10000;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        StatusBarTxtUtil.setStatusFullScreen(this);
        FlutterCgmwebviewPlugin.context = this;
        FlutterCgmwebviewPlugin.webViewActivity = this;
        setContentView(R.layout.activity_webview);
        webView = findViewById(R.id.webview);
        llTopView = findViewById(R.id.ll_top);
        rlTopview = findViewById(R.id.rl_topview);
        tvTitle = findViewById(R.id.tv_title);
        vStatus = findViewById(R.id.v_status);
        findViewById(R.id.iv_topback).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                webView.goBack();
            }
        });
        progressBar = findViewById(R.id.act_web_pro);
        FlutterCgmwebviewPlugin.webView = webView;
        findViewById(R.id.iv_close).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        url = getIntent().getStringExtra("url");
//        webView.addJavascriptInterface(new JavascriptHandler(), "postMessage");
        webSetting = webView.getSettings();
        //支持javascript
        webSetting.setJavaScriptEnabled(true);
        // 设置可以支持缩放
        webSetting.setSupportZoom(true);
        //扩大比例的缩放
        webSetting.setUseWideViewPort(true);
        //建立缩放控制
        webSetting.setBuiltInZoomControls(true);
        //缩放按钮显示
        webSetting.setDisplayZoomControls(false);
        //自适应屏幕
        webSetting.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
        webSetting.setLoadWithOverviewMode(true);
        webSetting.setCacheMode(WebSettings.LOAD_NO_CACHE);
        webSetting.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.NORMAL);
        webSetting.setBlockNetworkImage(false);
        webSetting.setAllowUniversalAccessFromFileURLs(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webSetting.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
//            webView.evaluateJavascript("postMessage", new ValueCallback<String>() {
//                @Override
//                public void onReceiveValue(String value) {
//                    Log.v("userlogin",value);
//                }
//            });
        }

        initListener();
//        webView.loadUrl(url);
        webView.loadUrl("file:////android_asset/index.html");

    }

    class JavascriptHandler {
        @JavascriptInterface
        public String postMessage(final String msg) {
            runOnUiThread(new Runnable() {
                @TargetApi(Build.VERSION_CODES.KITKAT)
                @Override
                public void run() {
                    Log.d("MainActivity", "JS Call Java msg=" + msg);
                    String jsmethod = "postMessage(\'JavaCallJSMethod" + msg + "\')";
//          android 4.4 开始使用evaluateJavascript调用js函数 ValueCallback获得调用js函数的返回值
//                    mWebView.loadUrl(jsmethod);
                    webView.evaluateJavascript(jsmethod, new ValueCallback<String>() {

                        @Override
                        public void onReceiveValue(String value) {
                            Log.d("MainActivity", "onReceiveValue value=" + value);
                        }
                    });
                }
            });
            return "Java result " + msg;
        }

    }

    public void initListener() {
        webView.setWebChromeClient(new WebChromeClient() {


            // For Android < 3.0
            public void openFileChooser(ValueCallback<Uri> valueCallback) {
                uploadMessage = valueCallback;
                openImageChooserActivity();
            }

            // For Android  >= 3.0
            public void openFileChooser(ValueCallback valueCallback, String acceptType) {
                uploadMessage = valueCallback;
                openImageChooserActivity();
            }

            //For Android  >= 4.1
            public void openFileChooser(ValueCallback<Uri> valueCallback, String acceptType, String capture) {
                uploadMessage = valueCallback;
                openImageChooserActivity();
            }

            // For Android >= 5.0
            @Override
            public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> filePathCallback, FileChooserParams fileChooserParams) {
                uploadMessageAboveL = filePathCallback;
                openImageChooserActivity();
                return true;
            }




            @Override
            public void onProgressChanged(WebView view, int newProgress) {

//                if (newProgress == 100) {
//                    progressBar.setVisibility(View.GONE);
//                } else {
//                    progressBar.setVisibility(View.VISIBLE);
//                    progressBar.setProgress(newProgress);
//                }
            }


        });

        //如果不设置WebViewClient，请求会跳转系统浏览器
        webView.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                webView.loadUrl("javascript:window.handler.resize(document.body.getBoundingClientRect().height)");
                super.onPageFinished(view, url);
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                //该方法在Build.VERSION_CODES.LOLLIPOP以前有效，从Build.VERSION_CODES.LOLLIPOP起，建议使用shouldOverrideUrlLoading(WebView, WebResourceRequest)} instead
                //返回false，意味着请求过程里，不管有多少次的跳转请求（即新的请求地址），均交给webView自己处理，这也是此方法的默认处理
                //返回true，说明你自己想根据url，做新的跳转，比如在判断url符合条件的情况下，我想让webView加载http://ask.csdn.net/questions/178242

//                if (!TxtUtil.isEmpty(url)) {
////                    view.loadUrl(url);
//                    openFuJian(url);
//                    return true;
//                }
//                Log.v("userlogin",url);
//
//                return false;
                // 步骤2：根据协议的参数，判断是否是所需要的url
                // 一般根据scheme（协议格式） & authority（协议名）判断（前两个参数）
                //假定传入进来的 url = "js://webview?arg1=111&arg2=222"（同时也是约定好的需要拦截的）
                Log.v("userlogin112", url);
                Uri uri = Uri.parse(url);
                // 如果url的协议 = 预先约定的 js 协议
                // 就解析往下解析参数
                if (uri.getScheme().equals("js")) {
                    // 如果 authority  = 预先约定协议里的 webview，即代表都符合约定的协议
                    // 所以拦截url,下面JS开始调用Android需要的方法
                    if (uri.getAuthority().equals("webview")) {
                        //  步骤3：
                        // 执行JS所需要调用的逻辑
                        System.out.println("js调用了Android的方法");
                        // 可以在协议上带有参数并传递到Android上
                        HashMap<String, String> params = new HashMap<>();
                        Set<String> collection = uri.getQueryParameterNames();

                    }
                    return true;
                }
                return super.shouldOverrideUrlLoading(view, url);
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                //返回false，意味着请求过程里，不管有多少次的跳转请求（即新的请求地址），均交给webView自己处理，这也是此方法的默认处理
                //返回true，说明你自己想根据url，做新的跳转，比如在判断url符合条件的情况下，我想让webView加载http://ask.csdn.net/questions/178242

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    if (!TextUtils.isEmpty(request.getUrl().toString())) {
                        if (request.getUrl().getScheme().equals("cgmcomm")) {
                            if (request.getUrl().getAuthority().equals("openCgmPay")) {
                                Map<Object, Object> map = new HashMap<>(4);
                                map.put("type", "success");
                                map.put("authority", "openCgmPay");
                                map.put("accessToken", request.getUrl().getQueryParameter("payToken"));
                                map.put("orderId", request.getUrl().getQueryParameter("orderId"));

                                if (FlutterCgmwebviewPlugin.pendingResult != null) {
                                    FlutterCgmwebviewPlugin.pendingResult.success(map);
                                    FlutterCgmwebviewPlugin.pendingResult = null;
                                }

                                Log.v("userlogin", request.getUrl().toString());
                            } else if (request.getUrl().getAuthority().equals("openCgmIm")) {
                                Map<Object, Object> map = new HashMap<>();
                                map.put("type", "success");
                                map.put("authority", "openCgmIm");
                                map.put("toUserId", request.getUrl().getQueryParameter("toUserId"));
                                if (FlutterCgmwebviewPlugin.pendingResult != null) {
                                    FlutterCgmwebviewPlugin.pendingResult.success(map);
                                    FlutterCgmwebviewPlugin.pendingResult = null;
                                }
                            } else if (request.getUrl().getAuthority().equals("statusBarDeploy")) {
                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("hiden"))) {
                                    if (request.getUrl().getQueryParameter("hiden").equals("ture")) {
                                        hidenStatusBar(View.GONE);
                                    } else {
                                        hidenStatusBar(View.VISIBLE);
                                    }
                                }
                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("statusBarColor"))) {
                                    setStatusBarColor(request.getUrl().getQueryParameter("statusBarColor"));
                                }
                            }else if (request.getUrl().getAuthority().equals("navigationDeploy")) {

                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("hiden"))) {
                                    if (request.getUrl().getQueryParameter("hiden").equals("ture")) {
                                        hidenTopView(View.GONE);
                                    } else {
                                        hidenTopView(View.VISIBLE);
                                        hidenStatusBar(View.VISIBLE);
                                    }

                                }

                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("backColor"))) {
                                    setTopViewColor(request.getUrl().getQueryParameter("backColor"));
                                }

                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("titleColor"))) {
                                    setTopTitleColor(request.getUrl().getQueryParameter("titleColor"));
                                }



                                if (!TextUtils.isEmpty(request.getUrl().getQueryParameter("titleName"))) {
                                    setTopTitleName(request.getUrl().getQueryParameter("titleName"));
                                }
                            }
                        } else {
                            view.loadUrl(request.getUrl().toString());
                        }
//                        view.loadUrl(request.getU rl().toString());
//                        dealUrl(view, request.getUrl().toString());
//                        openFuJian(request.getUrl().toString());
                        return true;
                    } else {
                        view.loadUrl(request.getUrl().toString());
                    }

                }
                return true;
            }

            @Override
            public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
                super.onReceivedError(view, request, error);
                view.stopLoading();
                Message msg = handler.obtainMessage();//发送通知，加入线程
                msg.what = -1;//通知加载自定义404页面
                handler.sendMessage(msg);//通知发送！
            }

            @Override
            public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
                view.stopLoading();
                Message msg = handler.obtainMessage();//发送通知，加入线程
                msg.what = -1;//通知加载自定义404页面
                handler.sendMessage(msg);//通知发送！
            }

            @Override
            public void onReceivedHttpError(WebView view, WebResourceRequest request, WebResourceResponse errorResponse) {
            }
        });


    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case -1:
                    progressBar.setVisibility(View.GONE);
                    break;
            }
        }
    };


    @Override
    protected void onDestroy() {
        if (FlutterCgmwebviewPlugin.pendingResult != null) {
            FlutterCgmwebviewPlugin.pendingResult.success(null);
            FlutterCgmwebviewPlugin.pendingResult = null;
        }
        super.onDestroy();
    }

    /**
     * 显示或者隐藏状态栏背景
     *
     * @param hiden
     */
    private void hidenStatusBar(int hiden) {
        if (vStatus != null && rlTopview != null) {

            //如果标题在显示，此时禁掉隐藏状态栏的操作
            if (rlTopview.getVisibility() == View.VISIBLE && hiden == View.GONE) {

            } else {
                vStatus.setVisibility(hiden);
            }
        }
    }

    /**
     * 隐藏显示顶部标题
     *
     * @param hiden
     */
    private void hidenTopView(int hiden) {
        if (rlTopview != null) {

            rlTopview.setVisibility(hiden);
        }
    }

    /**
     * 设置顶部的背景颜色
     */
    private void setTopViewColor(String color) {
        if (llTopView != null) {
            llTopView.setBackgroundColor(Color.parseColor("#" + color));
        }
    }

    private void setStatusBarColor(String color) {
        if (vStatus != null) {
            vStatus.setBackgroundColor(Color.parseColor("#" + color));
        }
    }

    /**
     * 设置标题颜色
     */
    private void setTopTitleColor(String color) {
        if (tvTitle != null) {
            tvTitle.setTextColor(Color.parseColor("#" + color));
        }
    }

    /**
     * 设置标题文字
     */
    private void setTopTitleName(String name) {
        if (tvTitle != null) {
            tvTitle.setText(name);
        }
    }

    private void openImageChooserActivity() {
        Intent i = new Intent(Intent.ACTION_GET_CONTENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("video/*;image/*;application/*;text/*;audio/*;");
        startActivityForResult(Intent.createChooser(i, "选择文件"), FILE_CHOOSER_RESULT_CODE);
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == FILE_CHOOSER_RESULT_CODE) {
            if (null == uploadMessage && null == uploadMessageAboveL) {
                return;
            }
            Uri result = data == null || resultCode != RESULT_OK ? null : data.getData();
            if (uploadMessageAboveL != null) {
                onActivityResultAboveL(requestCode, resultCode, data);
            } else if (uploadMessage != null) {
                uploadMessage.onReceiveValue(result);
                uploadMessage = null;
            }
        }
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private void onActivityResultAboveL(int requestCode, int resultCode, Intent intent) {
        if (requestCode != FILE_CHOOSER_RESULT_CODE || uploadMessageAboveL == null)
        {
            return;
        }
        Uri[] results = null;
        if (resultCode == Activity.RESULT_OK) {
            if (intent != null) {
                String dataString = intent.getDataString();
                ClipData clipData = intent.getClipData();
                if (clipData != null) {
                    results = new Uri[clipData.getItemCount()];
                    for (int i = 0; i < clipData.getItemCount(); i++) {
                        ClipData.Item item = clipData.getItemAt(i);
                        results[i] = item.getUri();
                    }
                }
                if (dataString != null)
                {
                    results = new Uri[]{Uri.parse(dataString)};
                }
            }
        }
        uploadMessageAboveL.onReceiveValue(results);
        uploadMessageAboveL = null;
    }
    /**
     * APP处理虚拟键点击事件
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK&&webView.canGoBack()) {
            webView.goBack();
            return true;
        }else {
            onBackPressed();
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack();
        } else {
            finish();
        }
    }
}
