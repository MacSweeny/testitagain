//
//  TINURLCache.h
//  TestItNow
//
//  Created by Michael Soares on 7/10/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TINURLCache : NSURLCache

/**
 * Returns a GINURLCache instance with a
 * 0 MB in-memory cache and 15 MB disk cache.
 */
+ (instancetype)standardURLCache;

/**
 * Clears the entire cache.
 */
+ (void)clearStandardURLCache;

@end
