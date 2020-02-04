#import "UmengSharePlugin.h"
#import "UMengShare.h"
#import "UMShareModel.h"
#import "UMShareUtils.h"

@implementation UmengSharePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"umeng_share"
                                                                binaryMessenger:[registrar messenger]];
    UmengSharePlugin* instance = [[UmengSharePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
     NSLog(@"call.method= %@   call.arguments = %@", call.method, call.arguments);

    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
        
    } else  if ([@"openShareWindow" isEqualToString:call.method]) {
        /// 打开分享面板
        UMShareModel *model = [UMShareModel modelWithShareType:call.arguments[@"shareType"]
                                                         title:call.arguments[@"title"]
                                                       content:call.arguments[@"content"]
                                                           url:call.arguments[@"url"]
                                                    shareImage:call.arguments[@"shareImage"]
                                               supportPlatform:call.arguments[@"supportPlatform"]];
        
        [[UMengShare shared] showShareView:model shareSuccess:^(id  _Nullable shareResult, NSError * _Nullable error, NSString *platform) {
            result(@{@"result" : shareResult, @"error" : error, @"platform" : platform});
        }];
        
        
    } else  if ([@"share_availablePlatform" isEqualToString:call.method]) {
        
        ///  平台是否可用
        result(@{
            @"qqAvailable" : @([UMShareUtils isQQInstalled]),
            @"qqTimAvailable" : @([UMShareUtils isQQTimInstalled]),
            @"weChatAvailable" : @([UMShareUtils isWXAppInstalled]),
        });
        
    } else  if ([@"registerQQWeChat" isEqualToString:call.method]) {
        
        /// 注册QQ微信分享平台
        [UMengShare configUMShareSDKWithWeChatAppID:call.arguments[@"weChatAppId"]
                                    weChatAppSecret:call.arguments[@"weChatSecret"]
                                            qqAppID:call.arguments[@"qqAppId"]
                                        qqAppSecret:call.arguments[@"qqAppKey"]
                                    shareDefaultUrl:call.arguments[@"shareDefaultUrl"]];
        
    } else {
        NSLog(@"call.method = %@", call.method);
        result(FlutterMethodNotImplemented);
    }
}

@end
