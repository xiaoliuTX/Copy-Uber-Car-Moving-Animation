//
//  UIImage+Color.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIColor *)colorAtPoint:(CGPoint )point;
//more accurate method ,colorAtPixel 1x1 pixel
- (UIColor *)colorAtPixel:(CGPoint)point;
//返回该图片是否有透明度通道
- (BOOL)hasAlphaChannel;
/**
 *  用颜色生成一张图片
 *
 *  @param color 颜色
 *
 *  @return 该颜色的图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;
@end
