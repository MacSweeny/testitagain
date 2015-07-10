//
//  UIImage+TIN.m
//  TestItNow
//
//  Created by Michael Soares on 7/10/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "UIImage+TIN.h"

@implementation UIImage (TIN)

- (UIImage *)TIN_imageScaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)TIN_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
