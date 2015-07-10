//
//  TINSessionManager.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINSessionManager.h"

@interface TINSessionManager () <NSURLSessionDelegate>

@property(nonatomic, strong) NSURLSession *session;

@end

@implementation TINSessionManager

+ (instancetype)sharedInstance
{
    static TINSessionManager *s_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[TINSessionManager alloc] init];
    });
    
    return s_sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:nil];
    }

    return self;
}

- (NSURLSessionDataTask *)fetchImageForURL:(NSURL *)url completion:(void (^)(UIImage *image, NSError *error))completion
{
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url
                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 UIImage *image = nil;
                                                 
                                                 if (!error) {
                                                     image = [UIImage imageWithData:data];
                                                 }
                                                 
                                                 if (completion) {
                                                     completion(image, error);
                                                 }
                                             }];
    
    [task resume];
    return task;
}

@end
