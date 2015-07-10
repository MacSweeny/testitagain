//
//  TINProducts.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINProducts.h"

@implementation TINProducts

+ (NSArray *)products
{
    static NSArray *s_products;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // we're not going to worry about error handling while reading in this file
        // we can safely assume for the purpose of this project that the JSON is sane
        NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"products" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
        NSError *error;
        s_products = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingMutableContainers
                                                       error:&error];
    });
    
    return s_products;
}

@end
