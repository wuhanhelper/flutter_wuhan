package com.nongfadai.umeng_share.widget;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.PixelFormat;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.os.IBinder;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;
import android.widget.Toast;

import com.nongfadai.umeng_share.R;
import com.nongfadai.umeng_share.util.AppUtil;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;

import java.util.ArrayList;
import java.util.List;



/**
 * 分享面板
 *
 * @author cy cy20061121@163.com
 * @date 2016/12/28
 */

public class SharePopupWindow extends PopupWindow {

    public static boolean showing = false;

    public static final String ALL = "ALL";
    public static final String WEIXIN = "WEIXIN";
    public static final String WEIXIN_CIRCLE = "WEIXIN_CIRCLE";
    public static final String QQ = "QQ";
    public static final String QZONE = "QZONE";

    private static final int TYPE_SHARE_IMAGE = 1;
    private static final int TYPE_SHARE_TEXT = 2;
    private final Activity mActivity;
    private String supportPlatform;//分享支持平台
    private int type;

    GridView mGridView;

    Button mButton;
    private String shareTitle, shareContent, shareTargetUrl;
    private UMImage shareImage;


    private OnShareListener mOnShareListener;


    private ShareMenuAdapter shareMenuAdapter;

    private WindowManager windowManager;
    private View maskView;

    private SHARE_MEDIA mSelectedMedia;


    public SharePopupWindow(Activity activity, UMImage shareImage, String supportPlatform) {
        super(activity);
        this.mActivity = activity;
        windowManager = (WindowManager) mActivity.getSystemService(Context.WINDOW_SERVICE);
        this.shareImage = shareImage;
        this.supportPlatform = supportPlatform;
        this.type = TYPE_SHARE_IMAGE;
        initView();
    }

    public SharePopupWindow(Activity activity, String shareTitle, String shareContent, String shareUrl, UMImage shareLogo, String supportPlatform) {
        super(activity);
        this.mActivity = activity;
        windowManager = (WindowManager) mActivity.getSystemService(Context.WINDOW_SERVICE);
        this.shareTitle = shareTitle;
        this.shareContent = shareContent;
        this.shareTargetUrl = shareUrl;
        this.shareImage = shareLogo;
        this.supportPlatform = supportPlatform;
        this.type = TYPE_SHARE_TEXT;
        initView();
    }

    private void addMask(IBinder token) {
        WindowManager.LayoutParams wl = new WindowManager.LayoutParams();
        wl.width = WindowManager.LayoutParams.MATCH_PARENT;
        wl.height = WindowManager.LayoutParams.MATCH_PARENT;
        wl.format = PixelFormat.TRANSLUCENT;//不设置这个弹出框的透明遮罩显示为黑色
        wl.type = WindowManager.LayoutParams.TYPE_APPLICATION_PANEL;//该Type描述的是形成的窗口的层级关系
        wl.token = token;//获取当前Activity中的View中的token,来依附Activity
        maskView = new View(mActivity);
        maskView.setBackgroundColor(0x7f000000);
        maskView.setFitsSystemWindows(false);
        maskView.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_BACK) {
                    removeMask();
                    return true;
                }
                return false;
            }
        });
        /**
         * 通过WindowManager的addView方法创建View，产生出来的View根据WindowManager.LayoutParams属性不同，效果也就不同了。
         * 比如创建系统顶级窗口，实现悬浮窗口效果！
         */
        windowManager.addView(maskView, wl);
    }

    private void removeMask() {
        if (null != maskView) {
            windowManager.removeViewImmediate(maskView);
            maskView = null;
        }
    }

    @Override
    public void dismiss() {
        removeMask();
        super.dismiss();
    }

    private void initView() {
        final LayoutInflater inflater = LayoutInflater.from(mActivity);
        View root = inflater.inflate(R.layout.ppw_share, null);
        mGridView = root.findViewById(R.id.gridView);
        mButton = root.findViewById(R.id.cancel_btn);
        setMenuAdapter();
        setContentView(root);
        setBackgroundDrawable(new BitmapDrawable());
        this.setWidth(LinearLayout.LayoutParams.MATCH_PARENT);
        this.setHeight(LinearLayout.LayoutParams.WRAP_CONTENT);
        this.setFocusable(true);
//        //对话框可取消
//        dialog = new ProgressDialog(mActivity);
//        dialog.setCancelable(true);

        mButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cancelClick(v);
            }
        });

        mGridView.setSelector(new ColorDrawable(Color.TRANSPARENT));

        mGridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                listItemClick(parent,view,position,id);
            }
        });

        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                doCallback();
                showing = false;
            }
        });

    }

    private void setMenuAdapter() {
        List<ShareMenu> shareMenus = new ArrayList<>();
        ShareMenu shareMenu = null;
        int numColumn = 0;
        if(TextUtils.isEmpty(supportPlatform)){
            supportPlatform = ALL;
        }
        String[] platforms = supportPlatform.split("#");
        for (String platform : platforms) {
            if (AppUtil.isWeChatAvailable(mActivity) && (platform.equalsIgnoreCase(ALL) || platform.equalsIgnoreCase(WEIXIN)) && !hasAdded(shareMenus, SHARE_MEDIA.WEIXIN)) {//判断是否支持微信
                shareMenu = new ShareMenu();
                shareMenu.platform = SHARE_MEDIA.WEIXIN;
                shareMenu.resId = R.drawable.umeng_socialize_wechat;
                shareMenu.name = "微信";
                shareMenus.add(shareMenu);
                numColumn += 1;
            }
            if (AppUtil.isWeChatAvailable(mActivity) && (platform.equalsIgnoreCase(ALL) || platform.equalsIgnoreCase(WEIXIN_CIRCLE)) && !hasAdded(shareMenus, SHARE_MEDIA.WEIXIN_CIRCLE)) {//判断是否支持微信朋友圈
                shareMenu = new ShareMenu();
                shareMenu.platform = SHARE_MEDIA.WEIXIN_CIRCLE;
                shareMenu.resId = R.drawable.umeng_socialize_wxcircle;
                shareMenu.name = "朋友圈";
                shareMenus.add(shareMenu);
                numColumn += 1;
            }
            if ( (AppUtil.isQQClientAvailable(mActivity) || AppUtil.isQQTimClientAvailable(mActivity) )&& (platform.equalsIgnoreCase(ALL) || platform.equalsIgnoreCase(QQ)) && !hasAdded(shareMenus, SHARE_MEDIA.QQ)) {//判断是否支持QQ
                shareMenu = new ShareMenu();
                shareMenu.platform = SHARE_MEDIA.QQ;
                shareMenu.resId = R.drawable.umeng_socialize_qq;
                shareMenu.name = "QQ";
                shareMenus.add(shareMenu);
                numColumn += 1;
            }
            if (AppUtil.isQQClientAvailable(mActivity) && (platform.equalsIgnoreCase(ALL) || platform.equalsIgnoreCase(QZONE)) && !hasAdded(shareMenus, SHARE_MEDIA.QZONE)) {////判断是否支持QZONE
                shareMenu = new ShareMenu();
                shareMenu.platform = SHARE_MEDIA.QZONE;
                shareMenu.resId = R.drawable.umeng_socialize_qzone;
                shareMenu.name = "QQ空间";
                shareMenus.add(shareMenu);
                numColumn += 1;
            }
        }
        mGridView.setNumColumns(numColumn);
        shareMenuAdapter = new ShareMenuAdapter(mActivity, shareMenus);
        mGridView.setAdapter(shareMenuAdapter);
    }

    public void show() {
        if(showing){
            Log.d("SharePopupWindow","SharePopupWindow is showing");
            return;
        }
        if (mGridView.getAdapter().getCount() == 0) {
            doCallback();
            Toast.makeText(mActivity,"请先安装微信和QQ进行分享",Toast.LENGTH_SHORT).show();
        } else {
            View showAtView = mActivity.getWindow().getDecorView();
            addMask(showAtView.getWindowToken());
            showing = true;
            showAtLocation(showAtView, Gravity.BOTTOM, 0, 0);
        }
    }

    public boolean hasAdded(List<ShareMenu> shareMenus, SHARE_MEDIA platform) {
        boolean b = false;
        for (ShareMenu shareMenu : shareMenus) {
            if (shareMenu.platform == platform) {
                b = true;
                break;
            }
        }
        return b;
    }


    public void listItemClick(AdapterView<?> parent, View view, int position, long id) {
        ShareAction shareAction = new ShareAction(mActivity);
        switch (type) {
            case TYPE_SHARE_TEXT:
                UMWeb web = new UMWeb(shareTargetUrl);
                web.setTitle(shareTitle);//标题
                web.setThumb(shareImage);  //缩略图
                web.setDescription(shareContent);//描述
                shareAction.withText(shareTitle).withMedia(web);
                break;
            case TYPE_SHARE_IMAGE:
                shareImage.setThumb(new UMImage(mActivity, R.mipmap.icon_app));
//                shareImage.setThumb(shareImage);
                shareImage.compressStyle = UMImage.CompressStyle.SCALE;//大小压缩，默认为大小压缩，适合普通很大的图
                shareAction.withMedia(shareImage);
                break;
        }

        mSelectedMedia = shareMenuAdapter.getItem(position).platform;

        if (isShowing()) {
            dismiss();
        }

        //友盟回调监听
        shareAction.setPlatform(mSelectedMedia).setCallback(mUMShareListener).share();


    }


    private UMShareListener mUMShareListener = new UMShareListener() {
        @Override
        public void onStart(SHARE_MEDIA platform) {
//            SocializeUtils.safeShowDialog(dialog);
            Log.d("SharePopupWindow","onStart");
        }

        @Override
        public void onResult(SHARE_MEDIA platform) {
//            SocializeUtils.safeCloseDialog(dialog);
            Log.d("SharePopupWindow","onResult");

//            doCallback(platform,"onResult");
        }


        @Override
        public void onError(SHARE_MEDIA platform, Throwable t) {
//            SocializeUtils.safeCloseDialog(dialog);
            Log.d("SharePopupWindow","onError");
//            doCallback(platform,"onError");
        }

        @Override
        public void onCancel(SHARE_MEDIA platform) {
//            SocializeUtils.safeCloseDialog(dialog);
            //返回时不执行回调，所以先取消对话框加载
            Log.d("SharePopupWindow","onCancel");
//            doCallback(platform,"onCancel");
        }
    };


    public void cancelClick(View view) {
        if (isShowing()) {
            dismiss();
        }
    }


    private void doCallback() {

        if (mOnShareListener != null) {

            ///没点击分享平台
            if(mSelectedMedia == null){
                mOnShareListener.shareCallback("分享取消了");
                return;
            }

            String platformName = "";
            switch (mSelectedMedia) {
                case WEIXIN:
                    platformName = WEIXIN;
                    break;
                case WEIXIN_CIRCLE:
                    platformName = WEIXIN_CIRCLE;
                    break;
                case QQ:
                    platformName = QQ;
                    break;
                case QZONE:
                    platformName = QZONE;
                    break;
            }

            mOnShareListener.shareCallback(platformName);

        }
    }

    static class ShareMenuAdapter extends AbstractAdapter<ShareMenu> {

        public ShareMenuAdapter(Context context, List<ShareMenu> dataList) {
            super(context, dataList);
        }

        @Override
        public View getView(int position, View view, ViewGroup viewGroup) {
            ViewHolder viewHolder = null;
            if (view == null) {
                view = getInflater().inflate(R.layout.item_share_menu, viewGroup, false);
                viewHolder = new ViewHolder(view);
                view.setTag(viewHolder);
            } else {
                viewHolder = (ViewHolder) view.getTag();
            }
            viewHolder.mMenuTv.setText(getItem(position).name);
            viewHolder.mMenuIv.setImageResource(getItem(position).resId);
            return view;
        }


    }

    static class ViewHolder {


        TextView mMenuTv;
        ImageView mMenuIv;

        public ViewHolder(View view) {
            mMenuTv = view.findViewById(R.id.menu_tv);
            mMenuIv = view.findViewById(R.id.menu_iv);
        }
    }


    static class ShareMenu {
        public SHARE_MEDIA platform;
        public int resId;
        public String name;
    }


    public SharePopupWindow setOnShareListener(OnShareListener onShareListener) {
        this.mOnShareListener = onShareListener;
        return this;
    }

    public interface OnShareListener {
        void shareCallback(String platform);
    }


}
