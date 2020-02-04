//
//  UMShareUtils.m
//  Runner
//
//  Created by zhouyun on 2019/10/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UMShareUtils.h"
#import "WXApi.h"

@implementation UMShareUtils

+ (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)isQQInstalled {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
        return YES;
    }
    return NO;
}

+ (BOOL)isQQTimInstalled
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"tim://"]]){
        return YES;
    }
    return NO;
}

@end
