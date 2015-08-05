//
//  TINProductTableViewCell.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINProductTableViewCell.h"
#import "TINSessionManager.h"
#import "UIImage+TIN.h"

@interface TINProductTableViewCell ()

@property(nonatomic, strong) NSURLSessionDataTask *imageFetchTask;
@property(nonatomic, strong) NSURL *imageURL;

@end

@implementation TINProductTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)setProduct:(NSDictionary *)product forTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    self.nameLabel.text = product[@"name"];
    self.categoryLabel.text = product[@"category"];
    self.productImageView.image = nil;
    
    NSURL *imageURL = [NSURL URLWithString:product[@"image_url"]];
    self.imageURL = imageURL;
    
    __weak typeof(self) weakSelf = self;
    [self.imageFetchTask cancel];
    self.imageFetchTask = [[TINSessionManager sharedInstance] fetchImageForURL:imageURL
                                                                    completion:^(UIImage *image, NSError *error) {
                                                                        if (!error) {
                                                                            image = [image TIN_imageScaledToSize:CGSizeMake(44, 44)];
                                                                            
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                __strong typeof(weakSelf) strongSelf = weakSelf;
                                                                                
                                                                                if (strongSelf && [strongSelf.imageURL isEqual:imageURL]) {
                                                                                    strongSelf.imageView.alpha = 0.0f;
                                                                                    strongSelf.productImageView.image = image;
                                                                                    [UIView animateWithDuration:0.2
                                                                                                          delay:0
                                                                                                        options:UIViewAnimationOptionCurveEaseIn
                                                                                                     animations:^{
                                                                                                         strongSelf.imageView.alpha = 1.0f;
                                                                                                     }
                                                                                                     completion:nil];
                                                                                }
                                                                            });
                                                                        }
                                                                    }];
}

@end