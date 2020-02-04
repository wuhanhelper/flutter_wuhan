//
//  UMengShare.h
//  Runner
//
//  Created by zhouyun on 2019/10/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMShareModel.h"

typedef void (^ShareCompletionHandler)(id _Nullable result,NSError * _Nullable error, NSString * _Nullable platform);

NS_ASSUME_NONNULL_BEGIN

@interface UMengShare : NSObject

+ (instancetype)shared;

- (void)showShareView:(UMShareModel *)model
         shareSuccess:(ShareCompletionHandler)shareCompletionHandler;

#pragma mark - 初始化分享
+ (void)configUMShareSDKWithWeChatAppID:(NSString *)weChatAppID
                        weChatAppSecret:(NSString *)weChatAppSecret
                                qqAppID:(NSString *)qqAppID
                            qqAppSecret:(NSString *)qqAppSecret
                        shareDefaultUrl:(NSString *)shareDefaultUrl;





@end

NS_ASSUME_NONNULL_END
