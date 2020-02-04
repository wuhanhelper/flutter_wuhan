package com.nongfadai.kappa.wxapi;

import android.os.Bundle;
import android.util.Log;

import com.umeng.socialize.weixin.view.WXCallbackActivity;

/**
 * @author liuwaiping
 * @date 2019-10-12
 */
public class WXEntryActivity extends WXCallbackActivity {
    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        Log.d("WXEntryActivity","kappa WXEntryActivity");
    }
}
