//
//  TINURLCache.m
//  TestItNow
//
//  Created by Michael Soares on 7/10/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINURLCache.h"

static NSString *const TINURLCacheExpirationDateKey = @"TINURLCacheExpirationDateKey";
static NSTimeInterval const TINURLCacheExpirationIntervalOneDay = 60 * 60 * 24;
static NSTimeInterval const TINURLCacheExpirationIntervalOneMonth = TINURLCacheExpirationIntervalOneDay * 30;

@implementation TINURLCache

+ (instancetype)standardURLCache
{
    static TINURLCache *s_standardURLCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_standardURLCache = [[[self class] alloc] initWithMemoryCapacity:0
                                                            diskCapacity:(15 * 1024 * 1024)
                                                                diskPath:nil];
    });
    
    return s_standardURLCache;
}

+ (void)clearStandardURLCache
{
    [[self standardURLCache] removeAllCachedResponses];
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request
{
    NSString *httpMethod = request.HTTPMethod;
    NSString *mimeType = cachedResponse.response.MIMEType;
    
    // only cache GET requests for images
    BOOL canCache = [httpMethod isEqualToString:@"GET"] && [mimeType rangeOfString:@"image/"].location != NSNotFound;
    
    if (canCache) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:cachedResponse.userInfo];
        
        // force all images to be cached for a month
        userInfo[TINURLCacheExpirationDateKey] = [[NSDate date] dateByAddingTimeInterval:TINURLCacheExpirationIntervalOneMonth];
        NSCachedURLResponse *modifiedCachedResponse = [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response
                                                                                               data:cachedResponse.data
                                                                                           userInfo:userInfo
                                                                                      storagePolicy:cachedResponse.storagePolicy];
        [super storeCachedResponse:modifiedCachedResponse forRequest:request];
    }
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
    NSCachedURLResponse *cachedResponse = [super cachedResponseForRequest:request];
    
    if (cachedResponse) {
        NSDate *cacheExpirationDate = cachedResponse.userInfo[TINURLCacheExpirationDateKey];
        
        // clear the cached response if it has expired
        if ([cacheExpirationDate compare:[NSDate date]] == NSOrderedAscending) {
            [self removeCachedResponseForRequest:request];
            return nil;
        }
    }
    
    return cachedResponse;
}

@end
