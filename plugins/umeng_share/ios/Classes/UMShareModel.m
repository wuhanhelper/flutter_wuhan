//
//  UMShareModel.m
//  Pods-Runner
//
//  Created by zhouyun on 2019/10/15.
//

#import "UMShareModel.h"

@implementation UMShareModel

+ (instancetype)modelWithShareType:(NSString *)shareType
                             title:(NSString *)title
                           content:(NSString *)content
                               url:(NSString *)url
                        shareImage:(NSString *)shareImage
                     supportPlatform:(NSString *)supportPlatform {
    UMShareModel *model = [[UMShareModel alloc] init];
    model.shareType = shareType;
    model.title = title;
    model.content = content;
    model.url = url;
    model.shareImage = shareImage;
    model.supportPlatform = supportPlatform;
    return model;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{shareType = %@, \n title = %@, \n content = %@, \n url = %@, \n shareImage = %@, \n sharePlatform = %@, }",self.shareType, self.title, self.content,  self.url, self.shareImage, self.supportPlatform];
}

@end
