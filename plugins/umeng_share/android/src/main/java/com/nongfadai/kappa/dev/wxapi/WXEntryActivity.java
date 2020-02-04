package com.nongfadai.kappa.dev.wxapi;

import android.os.Bundle;
import android.util.Log;

import com.umeng.socialize.weixin.view.WXCallbackActivity;

/**
 * @author liuwaiping
 * @date 2019-10-12
 *
 * dev 测试包分享
 */
public class WXEntryActivity extends WXCallbackActivity {
    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Log.d("WXEntryActivity","kappa dev WXEntryActivity");
    }
}
