//
//  UIImage+TIN.h
//  TestItNow
//
//  Created by Michael Soares on 7/10/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TIN)

- (UIImage *)TIN_imageScaledToSize:(CGSize)size;
+ (UIImage *)TIN_imageWithColor:(UIColor *)color;

@end
