//
//  MenuItemModel.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/8.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "MenuItemModel.h"

@implementation MenuItemModel
//-(UIImage *)image{
//    return [UIImage imageNamed:_imageName];
//}
//-(UIImage *)bigImage{
//    return [UIImage imageNamed:_bigImageName];
//}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    _image = [UIImage imageNamed:imageName];
   
}
-(void)setBigImageName:(NSString *)bigImageName{
    _bigImageName = bigImageName;
    _bigImage = [UIImage imageNamed:bigImageName];
}
-(UIColor *)color{
    return [MenuItemModel colorWithHexString:_colorArray];
}
+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
