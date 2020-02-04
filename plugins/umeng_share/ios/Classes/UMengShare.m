//
//  UMengShare.m
//  Runner
//
//  Created by zhouyun on 2019/10/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UMengShare.h"
#import <UMShare/UMShare.h>
#import "WXApi.h"
#import "UMShareUtils.h"
#import <UMCommon/UMConfigure.h>
#import "UMengShare.h"
#import "UMengshareView.h"
#import "Masonry.h"
#import "NJQAutosize.h"
#import "UIView+Toast.h"
#import "UMShareModel.h"


@interface UMengShare()
@property (nonatomic, strong) UMengshareView *shareView;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) UIView *maskView;
@end


@implementation UMengShare


+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static UMengShare *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[UMengShare alloc] init];
    });
    return shareInstance;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.5];
    }
    return _maskView;
}

- (void)showShareView:(UMShareModel *)model
         shareSuccess:(ShareCompletionHandler)shareCompletionHandler{
    
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    NSString *tips = [self __notInstallTips:model.supportPlatform];
    if (tips && tips.length) {
        [keyWindow makeToast:tips duration:3.0 position:CSToastPositionCenter];
        shareCompletionHandler(@"tips", nil, nil);
        return;
    }
    
    if (self.isShowing) return;
    self.isShowing = YES;
    
    
    // maskView
    [keyWindow addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    // shareView
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSheetView)];
    [self.maskView addGestureRecognizer:tap];
    
    
    UMengshareView *shareView = [[UMengshareView alloc] initWithModel:model];
    shareView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, kNJQAutoSize375(190));
    [keyWindow addSubview:shareView];
    self.shareView = shareView;
    
    __weak typeof (UMengShare *)weakSelf = self;
    self.shareView.cancelBtnClickBlock = ^{
        __strong typeof(UMengShare *) strongSelf = weakSelf;
        [strongSelf hideSheetView];
    };
    
    self.shareView.shareBtnClickBlock = ^(UMShareModel * _Nonnull model, NSString * _Nonnull sharePlatform) {
        
        __strong typeof(UMengShare *) strongSelf = weakSelf;
        [strongSelf hideSheetView];
        [UMengShare shareWithModel:model sharePlatform:sharePlatform shareSuccess:^(id  _Nullable result, NSError * _Nullable error, NSString *platform) {
            shareCompletionHandler(result, error, sharePlatform);
        }];
    };
    
    
    
    CGRect frame = self.shareView.frame;
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:3
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.shareView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
    }];
    
    
}

/// 没有安装平台的提示:没安装才会有提示
- (NSString *)__notInstallTips:(NSString *)supportPlatform
{
    NSString *tipStr = nil;
    NSArray *supportPlatformList = [self supportPlatformList:supportPlatform];
    
    for (NSString *platform in supportPlatformList) {
        
        if ([platform isEqualToString:kAll] && ![UMShareUtils isWXAppInstalled] && ![UMShareUtils isQQInstalled] && ![UMShareUtils isQQTimInstalled]) {
            tipStr = @"请先安装微信或QQ才能分享~";
        } else {
            if (([platform isEqualToString:kWechatSession] || [platform isEqualToString:kWechatTimeLine])
                && ![UMShareUtils isWXAppInstalled]) {
                tipStr = @"请先安装微信或QQ才能分享~";
            }else if ([platform isEqualToString:kQQ]  && ![UMShareUtils isQQInstalled] && ![UMShareUtils isQQTimInstalled]) {
                tipStr = @"请先安装微信或QQ才能分享~";
            }else if ([platform isEqualToString:kQZone] && ![UMShareUtils isQQInstalled]) {
                tipStr = @"请先安装微信或QQ才能分享~";
            } else {
                tipStr = nil;
                break;
            }
        }
    }
    
    return tipStr;
}

- (NSArray *)supportPlatformList:(NSString *)aStr {
    
    return [[aStr uppercaseString] componentsSeparatedByString:@"#"];

}


- (void)hideSheetView {
    
    
    CGRect frame = self.shareView.frame;
    [UIView animateWithDuration:0.25
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height;
        self.shareView.frame = CGRectMake(frame.origin.x,
                                          y,
                                          frame.size.width,
                                          frame.size.height);
    } completion:^(BOOL finished) {
        [self.shareView removeFromSuperview];
        self.shareView = nil;
        self.isShowing = NO;
        [self.maskView removeFromSuperview];
    }];
}



/// 初始化分享
+ (void)configUMShareSDKWithWeChatAppID:(NSString *)weChatAppID
                        weChatAppSecret:(NSString *)weChatAppSecret
                                qqAppID:(NSString *)qqAppID
                            qqAppSecret:(NSString *)qqAppSecret
                        shareDefaultUrl:(NSString *)shareDefaultUrl
{
    //    if (DEBUG) {
    //        [[UMSocialManager defaultManager] openLog:YES];
    //    }
    
    // 报错处理 本应该集中处理
    // https://www.jianshu.com/p/695bea006c78
    // TODO: 运行demo需要设置下面这一行代码
    // [UMConfigure initWithAppkey:@"5a9df8eaf29d9832630002e3" channel:@"ios"];
    
    
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;

    // 微信 、 朋友圈
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:weChatAppID
                                       appSecret:weChatAppSecret
                                     redirectURL:shareDefaultUrl];
    /* QQ 、 QZone
     * 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     * 100424468.no permission of union id
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:qqAppID/*设置QQ平台的appID*/
                                       appSecret:qqAppSecret
                                     redirectURL:shareDefaultUrl];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Tim
                                          appKey:qqAppID/*设置QQ平台的appID*/
                                       appSecret:qqAppSecret
                                     redirectURL:shareDefaultUrl];
}


/// 分享
+ (void)shareWithModel:(UMShareModel *)model
         sharePlatform:(NSString *)sharePlatform
          shareSuccess:(ShareCompletionHandler)shareSuccess {
    

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    id image = model.shareImage;
    if ([model.shareImage isKindOfClass:[NSString class]] && model.shareImage.length && ![(NSString *)model.shareImage hasPrefix:@"http"]) {
        image = [[NSData alloc] initWithBase64EncodedString:model.shareImage options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    if (!image
        || [image isKindOfClass:[NSNull class]]
        || ([image isKindOfClass:[NSString class]] && ((NSString *)image).length == 0)) {
        image = [self getAppIconName];
    }
    
    if ([kShareTypeImage isEqualToString:model.shareType]) {
        /// 图片分享
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:image];
        messageObject.shareObject = shareObject;
        
    } else {
        /// 文案链接分享
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.title
                                                                                 descr:model.content
                                                                             thumImage:image];
        shareObject.webpageUrl = model.url;
        messageObject.shareObject = shareObject;
    }
    
    ///  点击分享接口
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:[self platformType:sharePlatform]
                                        messageObject:messageObject
                                currentViewController:[[UIApplication sharedApplication].keyWindow rootViewController]
                                           completion:^(id data, NSError *error)
     {
//        if (DEBUG) {
//            // [self degbug_handleShareCompletionWith:data error:error];
//        }
        if (!error && shareSuccess)  {
            // 分享成功回调
             shareSuccess(data, error, sharePlatform);
        }
    }];
}



#pragma mark - Help Methods

+ (void)degbug_handleShareCompletionWith:(id)data error:(NSError *)error
{
    
    if (error) {
        
        UMSocialLogInfo(@"************Share fail with error %@*********",error);
        
    }else{
        
        if ([data isKindOfClass:[UMSocialShareResponse class]]) {
            UMSocialShareResponse *resp = data;
            //分享结果消息
            UMSocialLogInfo(@"response message is %@",resp.message);
            //第三方原始返回的数据
            UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            
        }else{
            UMSocialLogInfo(@"response data is %@",data);
        }
    }
    
    // 测试环境进行Log日志
    [self alertWithError:error];
}


+ (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    } else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}




+ (UIImage *)getAppIconName{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    
    //打印icon名字
    //NSLog(@"iconsArr: %@", iconsArr);
    //NSLog(@"iconLastName: %@", iconLastName);
    /*
     打印日志：
     iconsArr: (
         AppIcon29x29,
         AppIcon40x40,
         AppIcon60x60
     )
     iconLastName: AppIcon60x60
     */
    
    return [UIImage imageNamed:iconLastName];
}

+ (UMSocialPlatformType)platformType:(NSString *)platform {
    
    if ([platform isEqualToString:kWechatSession]) {
        
        return UMSocialPlatformType_WechatSession;
        
    } else if ([platform isEqualToString:kWechatTimeLine]) {
        
        return UMSocialPlatformType_WechatTimeLine;
        
    } else  if ([platform isEqualToString:kQQ]) {
        
        if ([UMShareUtils isQQInstalled]) {
            
            return UMSocialPlatformType_QQ;
            
        } else {
            return UMSocialPlatformType_Tim;
        }
        
    } else  if ([platform isEqualToString:kQZone]) {
        
        return UMSocialPlatformType_Qzone;
        
    } else {
        
        return UMSocialPlatformType_UnKnown;
        
    }
}

@end
