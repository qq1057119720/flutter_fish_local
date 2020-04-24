package com.cgm.flutter.cgmwebview.ui;

import android.content.Context;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.animation.Animation;
import android.widget.TextView;

import com.cgm.flutter.cgmwebview.R;

import java.util.Map;

import razerdp.basepopup.BasePopupWindow;

public class PayOrderPopup extends BasePopupWindow {
    private Map<String, Object> payMap;
    private View popupView;
    private Context context;
    private PayClickListener payClickListener;
    private String payPwd;
    private TextView tvPrice;
    private TextView tvPayunit;
    private TextView tvBusname;
    private TextView tvPaytype;
    public void setPayClickListener(PayClickListener payClickListener) {
        this.payClickListener = payClickListener;
    }

    public PayOrderPopup(Context context, Map<String, Object> payMap, final PayClickListener payClickListener) {
        super(context);
        this.context = context;
        payPwd="";
        this.payMap = payMap;
        setPopupGravity(Gravity.BOTTOM);
        bindEvent();
        this.payClickListener=payClickListener;
        initData();
        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                if (!TextUtils.isEmpty(payPwd)){
                    if (payClickListener!=null){
                        payClickListener.payPassFinish(payPwd);
                    }
                }else {
                    if (payClickListener!=null){
                        payClickListener.payClose();
                    }
                }

            }
        });
    }

    @Override
    protected Animation onCreateShowAnimation() {
        return getTranslateVerticalAnimation(1f, 0, 300);
    }

    @Override
    protected Animation onCreateDismissAnimation() {
        return getTranslateVerticalAnimation(0, 1f, 300);
    }

    @Override
    public View onCreateContentView() {
        return createPopupById(R.layout.dlialog_pay_msg);
    }

    private void bindEvent() {
        findViewById(R.id.iv_close).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();

            }
        });
        findViewById(R.id.tv_next).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                payDialog();
            }
        });
        tvPrice=findViewById(R.id.tv_price);
        tvPayunit=findViewById(R.id.tv_payunit);
        tvBusname=findViewById(R.id.tv_busname);
        tvPaytype=findViewById(R.id.tv_paytype);

    }
    private void initData(){
        java.text.DecimalFormat   df   =new   java.text.DecimalFormat("#0.00");
        tvPrice.setText(df.format(Double.parseDouble(payMap.get("grandTotal").toString())));
        tvBusname.setText(payMap.get("productStoreName").toString());
//        tvPayunit.setText(payMap.get("currencyUom").toString());
        tvPaytype.setText(payMap.get("payWay").toString());
    }

    private void payDialog() {
        final PayPassDialog dialog = new PayPassDialog(context);
        dialog.getPayViewPass().setPayClickListener(new PayPassView.OnPayClickListener() {
            @Override
            public void onPassFinish(String passContent) {
                payPwd=passContent;
                dialog.dismiss();
             dismiss();
            }

            @Override
            public void onPayClose() {
                payPwd="";
                dialog.dismiss();

            }

            @Override
            public void onPayForget() {
                payPwd="";
                dialog.dismiss();

            }
        });
    }

    public interface PayClickListener{
        void payPassFinish(String passContent);
        void payClose();


    }
}