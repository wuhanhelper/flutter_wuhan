package com.nongfadai.umeng_share.util;

import android.app.Activity;
import android.graphics.BitmapFactory;
import android.text.TextUtils;
import android.util.Base64;


import com.nongfadai.umeng_share.R;
import com.nongfadai.umeng_share.widget.SharePopupWindow;
import com.umeng.socialize.media.UMImage;

/**
 * Author：cy on 2016/6/3 10:29
 * email：cy20061121@163.com
 * 分享工具类
 */
public class ShareUtil {

    /**
     * 根据不同的平台设置不同的分享内容
     */
    public static void setShareContent(Activity context, String shareTitle, String shareContent, String shareUrl, String logoUrl, String supportPlatform,SharePopupWindow.OnShareListener onShareListener) {
        UMImage shareLogo = null;
        if (TextUtils.isEmpty(logoUrl)) {
            shareLogo = new UMImage(context, BitmapFactory.decodeResource(context.getResources(), R.mipmap.icon_app));
        } else {
            shareLogo = new UMImage(context, logoUrl);
        }

        SharePopupWindow sharePopupWindow = new SharePopupWindow(context, shareTitle, shareContent, shareUrl, shareLogo, supportPlatform);
        sharePopupWindow.setOnShareListener(onShareListener);

        sharePopupWindow.show();
    }






    /**
     * 分享图片
     */
    public static void setShareImage(Activity context, String shareImage, String supportPlatform, SharePopupWindow.OnShareListener onShareListener) {
        UMImage shareLogo = null;
        if (shareImage.startsWith("http:")||shareImage.startsWith("https:")) {
            shareLogo = new UMImage(context, shareImage);
        } else {
            shareLogo = new UMImage(context, Base64.decode(shareImage, 2));
        }
        SharePopupWindow sharePopupWindow = new SharePopupWindow(context, shareLogo, supportPlatform);

        sharePopupWindow.setOnShareListener(onShareListener);

        sharePopupWindow.show();
    }
}
