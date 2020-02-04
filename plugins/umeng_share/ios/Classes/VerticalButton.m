//
//  VerticalButton.m
//  Nongfadai
//
//  Created by 刘永生 on 2016/12/26.
//  Copyright © 2016年waitreplace
//

#import "VerticalButton.h"
#import "NJQAutosize.h"

@implementation VerticalButton



- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect newFrame = [self titleLabel].frame;
    
    CGPoint center = self.imageView.center;
    
    center.x = self.frame.size.width/2;
    
    center.y = center.y - newFrame.size.height/2.0  + kNJQAutoSize375(3);
    self.imageView.center = center;
    
    //Center text
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.origin.y + self.imageView.frame.size.height + kNJQAutoSize375(7);
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
