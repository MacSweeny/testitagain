//
//  UIImage+TIN.h
//  TestItNow
//
//  Created by Michael Soares on 7/10/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TIN)

- (UIImage *)imageScaledToSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
