//
//  TINSessionManager.h
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TINSessionManager : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)fetchImageForURL:(NSURL *)url completion:(void (^)(UIImage *image, NSError *error))completion;

@end
