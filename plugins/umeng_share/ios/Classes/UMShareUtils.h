//
//  UMShareUtils.h
//  Runner
//
//  Created by zhouyun on 2019/10/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMShareUtils : NSObject

+ (BOOL)isWXAppInstalled;

+ (BOOL)isQQInstalled;

+ (BOOL)isQQTimInstalled;

@end

NS_ASSUME_NONNULL_END
