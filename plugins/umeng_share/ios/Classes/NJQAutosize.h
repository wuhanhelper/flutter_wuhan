//
//  NJQAutosize.h
//  Nongfadai
//
//  Created by 刘永生 on 16/6/28.
//  Copyright © 2016年waitreplace
//

#import <Foundation/Foundation.h>


#define font(a) [UIFont systemFontOfSize:a]
#define lightFont(a) [NJQAutosize njq_lightFontAutoSize:a]
#define boldFont(a) [NJQAutosize njq_boldFontAutoSize:a]
#define thinFont(a) [NJQAutosize njq_thinFontAutoSize:a]

/** iPone6为基准的字体适配 */
#define thinFont375(a) [NJQAutosize njq_thinFontAutoSize375:a]
#define lightFont375(a) [NJQAutosize njq_lightFontAutoSize375:a]
#define font375(a) [NJQAutosize njq_fontAutoSize375:a]
#define boldFont375(a) [NJQAutosize njq_boldFontAutoSize375:a]
#define mediumFont375(a) [NJQAutosize njq_mediumFontAutoSize375:a]
#define semiboldFont375(a) [NJQAutosize njq_semiboldFontAutoSize375:a]


#define kNJQAutoSize375(a) [NJQAutosize njq_autoSize375:a]
#define kNJQAutoSizeFont375(a) [NJQAutosize njq_fontAutoSize375:a]
#define kNJQAutoSizeBoldFont375(a) [NJQAutosize njq_boldFontAutoSize375:a]


#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenScale [UIScreen mainScreen].scale
#define iOS(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)


#define weakify(...) \
    rac_keywordify \
    metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)


#define strongify(...) \
    rac_keywordify \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
    _Pragma("clang diagnostic pop")

/**
 *  4s按照iPhone5s的比例.不缩放,
 *  iPhone6s/iPhone6 Plus根据缩放宽度的缩放比例进行释放
 *  height 也是按照 宽度的比例进行缩放
 */
@interface NJQAutosize : NSObject

#pragma mark - 以iPhone5s为基准
/**
 *  以iPhone5s为基准, 传入宽度/高度, 返回 对应的宽度/高度
 */
+ (double)njq_autoSize320:(double)aObj;

/**
 *  以iPhone5s为基准, 传入 字号 ,返回对应 字号
 */
+ (UIFont *)njq_fontAutoSize320:(double)aFontSize;


+ (double)njq_AutoSize375ScaleX ;

#pragma mark - 以iPhone6s为基准

/**
 *  以iPhone6s为基准, 传入宽度/高度, 返回 对应的宽度/高度
 */
+ (double)njq_autoSize375:(double)aObj;


/**
 *  以iPhone6/iPhone6s为基准, 传入 字号 ,返回对应 字号
 */
+ (UIFont *)njq_fontAutoSize375:(double)aFontSize;

+ (UIFont *)njq_boldFontAutoSize375:(double)aFontSize;
+ (UIFont *)njq_lightFontAutoSize375:(double)aFontSize;
+ (UIFont *)njq_thinFontAutoSize375:(double)aFontSize;
+ (UIFont *)njq_mediumFontAutoSize375:(double)aFontSize;
+ (UIFont *)njq_semiboldFontAutoSize375:(double)aFontSize;


+ (UIFont *)njq_boldFontAutoSize:(double)aFontSize;
+ (UIFont *)njq_lightFontAutoSize:(double)aFontSize;
+ (UIFont *)njq_thinFontAutoSize:(double)aFontSize;

@end
