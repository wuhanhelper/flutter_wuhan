//
//  UMengshareView.m
//  Pods-Runner
//
//  Created by zhouyun on 2019/10/23.
//

#import "UMengshareView.h"
#import "VerticalButton.h"
#import "UIColor+common.h"
#import "Masonry.h"
#import "UMShareUtils.h"
#define kShareViewHeight kNJQAutoSize375(53 + 136)

@interface UMengshareView()
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) VerticalButton *wxBtn;    /**< 微信按钮 */
@property (nonatomic, strong) VerticalButton *pyqBtn;   /**< 朋友圈按钮 */
@property (nonatomic, strong) VerticalButton *qqBtn;    /**< qq按钮 */
@property (nonatomic, strong) VerticalButton *qqkjBtn;  /**< qq空间按钮 */

@property (nonatomic, strong) UMShareModel *model ;

@end

@implementation UMengshareView

- (instancetype)initWithModel:(UMShareModel *)model{
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.model = model;
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.shareView];
    
    [self.shareView addSubview:self.wxBtn];
    [self.shareView addSubview:self.pyqBtn];
    [self.shareView addSubview:self.qqBtn];
    [self.shareView addSubview:self.qqkjBtn];
    
    //添加创建控件
    [self makeConstraints];
}

- (void)makeConstraints {
    
    //布局
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kNJQAutoSize375(53));
    }];
    
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.cancelBtn.mas_top);
        make.height.mas_equalTo(kShareViewHeight - kNJQAutoSize375(53));
        
    }];
    
    
    NSMutableArray * array = [NSMutableArray array];
    
    
    // 控制哪些平台展示
    NSArray *supportPlatformList = [self supportPlatformList:self.model.supportPlatform];
    
    if ([UMShareUtils isWXAppInstalled]) {
        
        if ([supportPlatformList containsObject:kAll]) {
            
            [array addObject:self.wxBtn];
            [array addObject:self.pyqBtn];
            
        } else {
            if ([supportPlatformList containsObject:kWechatSession]) {
                
                [array addObject:self.wxBtn];
            }
            
            if ([supportPlatformList containsObject:kWechatTimeLine]) {
                [array addObject:self.pyqBtn];
            }
        }
        
        
    }
    
    // 因为TIM没有像QQ一样集成QQ空间所以需要额外判断是否 显示QZone图标
    if ([UMShareUtils isQQInstalled] || [UMShareUtils isQQTimInstalled]){
        
        
        if ([supportPlatformList containsObject:kAll]) {
            
            [array addObject:self.qqBtn];
            
            if ([UMShareUtils isQQInstalled]) {
                [array addObject:self.qqkjBtn];
            }
            
        } else {
            if ([supportPlatformList containsObject:kQQ]) {
                [array addObject:self.qqBtn];
            }
            
            if ([supportPlatformList containsObject:kQZone] && [UMShareUtils isQQInstalled]) {
                [array addObject:self.qqkjBtn];
            }
        }
        
    }
    
    
    [self makeEqualWidthViews:array
                       inView:self.shareView
                    LRpadding:0
                  viewPadding:0];
}


- (NSArray *)supportPlatformList:(NSString *)aStr {
    
    return [[aStr uppercaseString] componentsSeparatedByString:@"#"];
    
}

/**
 添加视图 并 等分视图
 */
-(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
{
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}

#pragma mark - Click

- (void)clickCancel {
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
}

- (void)clickWXBtn:(UIButton *)sender {
    
    if (self.shareBtnClickBlock) {
        self.shareBtnClickBlock(self.model, kWechatSession);
    }
    
}

- (void)clickPYQBtn:(UIButton *)sender {
    if (self.shareBtnClickBlock) {
        self.shareBtnClickBlock(self.model, kWechatTimeLine);
    }
}


// 目前先简单处理QQTIM 如果有QQ优先调用QQ 如果没有则调用QQTim，如果两者都没有则不会显示
- (void)clickQQBtn:(UIButton *)sender {
    if (self.shareBtnClickBlock) {
        self.shareBtnClickBlock(self.model, kQQ);
    }
}

- (void)clickQQKJBtn:(UIButton *)sender {
    if (self.shareBtnClickBlock) {
        self.shareBtnClickBlock(self.model, kQZone);
    }
}

#pragma mark - Proprety

- (UIButton *)cancelBtn {
    
    if(!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor color333333] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kNJQAutoSizeFont375(17);
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        
        [_cancelBtn addTarget:self
                       action:@selector(clickCancel)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)shareView {
    
    if(!_shareView) {
        _shareView = [[UIView alloc] init];
        _shareView.backgroundColor = [UIColor colorf7f7f7];
    }
    return _shareView;
}

- (UIImage *)njq_sk_imageNamed:(NSString *)imageName {
    
    NSString *bundlePath = [[NSBundle bundleForClass:NSClassFromString(@"umeng_share")].resourcePath
                            stringByAppendingPathComponent:@"/umeng_share.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resource_bundle
           compatibleWithTraitCollection:nil];
    
    return image;
    
}

- (VerticalButton *)wxBtn {
    
    if(!_wxBtn) {
        _wxBtn = [[VerticalButton alloc] init];
        [_wxBtn setImage:[self njq_sk_imageNamed:@"icon_umeng_wx"] forState:UIControlStateNormal];
        [_wxBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [_wxBtn setTitleColor:[UIColor color333333] forState:UIControlStateNormal];
        _wxBtn.titleLabel.font = kNJQAutoSizeFont375(12);
        
        [_wxBtn addTarget:self action:@selector(clickWXBtn:)
         forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _wxBtn;
}

- (VerticalButton *)pyqBtn {
    
    if(!_pyqBtn) {
        _pyqBtn = [[VerticalButton alloc] init];
        [_pyqBtn setImage:[self njq_sk_imageNamed:@"icon_umeng_pyq"] forState:UIControlStateNormal];
        [_pyqBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
        [_pyqBtn setTitleColor:[UIColor color333333] forState:UIControlStateNormal];
        _pyqBtn.titleLabel.font = kNJQAutoSizeFont375(12);
        
        [_pyqBtn addTarget:self action:@selector(clickPYQBtn:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _pyqBtn;
}

- (VerticalButton *)qqBtn {
    
    if(!_qqBtn) {
        _qqBtn = [[VerticalButton alloc] init];
        [_qqBtn setImage:[self njq_sk_imageNamed:@"icon_umeng_qq"] forState:UIControlStateNormal];
        [_qqBtn setTitle:@"QQ" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:[UIColor color333333] forState:UIControlStateNormal];
        _qqBtn.titleLabel.font = kNJQAutoSizeFont375(12);
        
        [_qqBtn addTarget:self action:@selector(clickQQBtn:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

- (VerticalButton *)qqkjBtn {
    
    if(!_qqkjBtn) {
        _qqkjBtn = [[VerticalButton alloc] init];
        [_qqkjBtn setImage:[self njq_sk_imageNamed:@"icon_umeng_kj"] forState:UIControlStateNormal];
        [_qqkjBtn setTitle:@"QQ空间" forState:UIControlStateNormal];
        [_qqkjBtn setTitleColor:[UIColor color333333] forState:UIControlStateNormal];
        _qqkjBtn.titleLabel.font = kNJQAutoSizeFont375(12);
        
        [_qqkjBtn addTarget:self action:@selector(clickQQKJBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqkjBtn;
}


@end
