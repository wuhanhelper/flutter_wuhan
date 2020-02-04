//
//  UMengshareView.h
//  Pods-Runner
//
//  Created by zhouyun on 2019/10/23.
//

#import <Foundation/Foundation.h>
#import "UMShareModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface UMengshareView : UIView
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, copy) void (^shareBtnClickBlock)(UMShareModel *model, NSString *sharePlatform);

@property (nonatomic, copy) void (^cancelBtnClickBlock)(void);


- (instancetype)initWithModel:(UMShareModel *)model;

@end

NS_ASSUME_NONNULL_END
