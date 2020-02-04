//
//  NJQAutosize.m
//  Nongfadai
//
//  Created by 刘永生 on 16/6/28.
//  Copyright © 2016年waitreplace
//

#import "NJQAutosize.h"

@implementation NJQAutosize

#pragma mark - 以iPhone5s为标准

+ (double)njq_AutoSize320ScaleX {
    if(ScreenHeight > 480){
        return ScreenWidth/320.0;
    }else{
        return 1.0;
    }
}

+ (double)njq_autoSize320ScaleY {
    if(ScreenHeight > 480){
        return ScreenHeight/568.0;
    }else{
        return 1;
    }
}

+ (double)njq_autoSize320:(double)aObj {
    
    return [NJQAutosize njq_AutoSize320ScaleX] * aObj;
    
}

+ (UIFont *)njq_fontAutoSize320:(double)aFontSize {
    
    return [UIFont systemFontOfSize:(aFontSize * [NJQAutosize njq_AutoSize320ScaleX])];
    
}

#pragma mark - 以iPhone6/iPhone6s为标准

+ (double)njq_AutoSize375ScaleX {
    
    return ScreenWidth/375.0;
    
}


+ (double)njq_autoSize375:(double)aObj{
    
    
    return [NJQAutosize njq_AutoSize375ScaleX] * aObj;
    
}

+ (UIFont *)njq_fontAutoSize375:(double)aFontSize{
    
    return [UIFont systemFontOfSize:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
}


+ (UIFont *)njq_boldFontAutoSize375:(double)aFontSize
{
    return [UIFont boldSystemFontOfSize:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
}

+ (UIFont *)njq_lightFontAutoSize375:(double)aFontSize
{
    if (iOS(8.2)) {
        return [UIFont systemFontOfSize:aFontSize * [NJQAutosize njq_AutoSize375ScaleX] weight:UIFontWeightLight];
    } else {
        // Avenir-Light(.为圆形) HelveticaNeue-Light(分.为正方形)
        return [UIFont fontWithName:@"HelveticaNeue-Light"
                               size:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
    }
}

+ (UIFont *)njq_thinFontAutoSize375:(double)aFontSize
{
    if (iOS(8.2)) {
        return [UIFont systemFontOfSize:aFontSize * [NJQAutosize njq_AutoSize375ScaleX] weight:UIFontWeightThin];
    } else {
        // Avenir-Light(.为圆形) HelveticaNeue-Light(分.为正方形)
        return [UIFont fontWithName:@"HelveticaNeue-Thin"
                               size:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
    }
}


+ (UIFont *)njq_mediumFontAutoSize375:(double)aFontSize
{
    if (iOS(8.2)) {
        
        return [UIFont systemFontOfSize:aFontSize * [NJQAutosize njq_AutoSize375ScaleX] weight:UIFontWeightMedium];
    } else {
        // Avenir-Light(.为圆形) HelveticaNeue-Light(分.为正方形)
        return [UIFont fontWithName:@"HelveticaNeue-Medium"
                               size:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
    }
}


+ (UIFont *)njq_semiboldFontAutoSize375:(double)aFontSize
{
    if (iOS(8.2)) {
        
        return [UIFont systemFontOfSize:aFontSize * [NJQAutosize njq_AutoSize375ScaleX] weight:UIFontWeightSemibold];
    } else {
        //Baskerville-SemiBold
        return [UIFont fontWithName:@"Baskerville-SemiBold"
                               size:(aFontSize * [NJQAutosize njq_AutoSize375ScaleX])];
    }
}



+ (UIFont *)njq_boldFontAutoSize:(double)aFontSize
{
    return [UIFont boldSystemFontOfSize:aFontSize];
}

+ (UIFont *)njq_lightFontAutoSize:(double)aFontSize
{
    if (iOS(8.2)) {
        return [UIFont systemFontOfSize:aFontSize weight:UIFontWeightLight];
    } else {
        // Avenir-Light(.为圆形) HelveticaNeue-Light(分.为正方形)
        return [UIFont fontWithName:@"HelveticaNeue-Light"
                               size:aFontSize];
    }
}

+ (UIFont *)njq_thinFontAutoSize:(double)aFontSize
{
    if (iOS(8.2)) {
        return [UIFont systemFontOfSize:aFontSize weight:UIFontWeightThin];
    } else {
        // Avenir-Light(.为圆形) HelveticaNeue-Light(分.为正方形)
        return [UIFont fontWithName:@"HelveticaNeue-Thin"
                               size:aFontSize];
    }
}

@end
