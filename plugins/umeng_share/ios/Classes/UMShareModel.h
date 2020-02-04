//
//  UMShareModel.h
//  Pods-Runner
//
//  Created by zhouyun on 2019/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static  NSString *const kAll            = @"ALL";     //全平台
static  NSString *const kWechatSession  = @"WEIXIN";
static  NSString *const kWechatTimeLine = @"WEIXIN_CIRCLE";
static  NSString *const kQQ             = @"QQ";
static  NSString *const kQZone          = @"QZONE";

static  NSString *const kShareTypeImage = @"IMAGE";
static  NSString *const kShareTypeText  = @"TEXT";


@interface UMShareModel : NSObject
/// 分享 TEXT  文字分享 IMAGE  图片分享
@property (nonatomic, copy) NSString *shareType;
/// 标题
@property (nonatomic, copy) NSString *title; /**< 标题 */
/// 内容
@property (nonatomic, copy) NSString *content;
/// 分享链接
@property (nonatomic, copy) NSString *url;
/// 分享图片
@property (nonatomic, copy) NSString *shareImage;
/// 支持分享平台
@property (nonatomic, copy) NSString *supportPlatform;

+ (instancetype)modelWithShareType:(NSString *)shareType
                             title:(NSString *)title
                           content:(NSString *)content
                               url:(NSString *)url
                        shareImage:(NSString *)shareImage
                     supportPlatform:(NSString *)supportPlatform;

@end

NS_ASSUME_NONNULL_END
