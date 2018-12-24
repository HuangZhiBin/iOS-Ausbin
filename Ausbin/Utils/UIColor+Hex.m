//
//  UIColor+Hex.m
//  Languages
//
//  Created by BinHuang on 2017/6/19.
//  Copyright © 2017年 Dianbo.co. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)color
{
    return [UIColor colorWithHex:color alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(float)alpha
{
    return [UIColor colorWithRed:(((color & 0xFF0000) >> 16)) / 255.0f
                           green:(((color & 0xFF00) >> 8)) / 255.0f
                            blue:((color & 0xFF)) / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString;
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor whiteColor];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}

@end
