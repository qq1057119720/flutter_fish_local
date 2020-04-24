package com.cgm.flutter.cgmwebview.activity;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.Nullable;

import com.bumptech.glide.Glide;
import com.cgm.flutter.cgmwebview.R;
import com.cgm.flutter.cgmwebview.utils.ZXingUtils;

import java.io.ByteArrayOutputStream;

public class ShareViewActivity extends Activity {
    private String shareurl;
    private String invitecode;
    private String backurl;
    private ImageView ivBackimage;
    private ImageView ivErweima;
    private TextView tvInvitecode;
    private FrameLayout flShareview;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shareview);
        ivBackimage = findViewById(R.id.iv_backimage);
        ivErweima = findViewById(R.id.iv_erweima);
        tvInvitecode = findViewById(R.id.tv_invitecode);
        flShareview = findViewById(R.id.fl_shareview);
        shareurl = getIntent().getStringExtra("shareurl");
        backurl = getIntent().getStringExtra("backurl");
        invitecode = getIntent().getStringExtra("invitecode");
        findViewById(R.id.iv_topback).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        findViewById(R.id.tv_share_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                getShareView(flShareview).compress(Bitmap.CompressFormat.JPEG, 60, stream);
                byte[] b = stream.toByteArray();

                Uri uri = Uri.parse(MediaStore.Images.Media.insertImage(getContentResolver(),  getShareView(flShareview), null,null));

//                Intent textIntent = new Intent(Intent.ACTION_SEND);
//                textIntent.setType("application/octet-stream");
//                textIntent.putExtra(Intent.EXTRA_STREAM, b);
//                startActivity(Intent.createChooser(textIntent, "邀请好友"));

                Intent imageIntent = new Intent(Intent.ACTION_SEND);
                imageIntent.setType("image/jpeg");
                imageIntent.putExtra(Intent.EXTRA_STREAM, uri);
                startActivity(Intent.createChooser(imageIntent, "分享"));

            }
        });
        Glide.with(this)
                .load(backurl)
                .into(ivBackimage);
        ivErweima.setImageBitmap(ZXingUtils.createQRImage(shareurl, dpToPx(this, 200), dpToPx(this, 200)));

        ivErweima.setImageBitmap(ZXingUtils.createQRCodeWithLogo(shareurl,dpToPx(this, 200), BitmapFactory.decodeResource(getResources(),R.mipmap.ic_launcher,null)));
        tvInvitecode.setText(invitecode);

    }

    private int dpToPx(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    private Bitmap getShareView(View view) {
        view.setDrawingCacheEnabled(true);
        view.buildDrawingCache(); //启用DrawingCache并创建位图
        Bitmap bitmap = Bitmap.createBitmap(view.getDrawingCache()); //创建一个DrawingCache的拷贝，因为DrawingCache得到的位图在禁用后会被回收
        view.setDrawingCacheEnabled(false); //禁用DrawingCahce否则会影响性能
        return bitmap;
    }

    public byte[] bitmap2Bytes(Bitmap bm) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bm.compress(Bitmap.CompressFormat.PNG, 100, baos);
        return baos.toByteArray();
    }
}
