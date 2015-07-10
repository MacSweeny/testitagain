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
@property(nonatomic, strong) UIImage *placeholderImage;
@property(nonatomic, strong) NSDictionary *product;

@end

@implementation TINProductTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (TINProductTableViewCell *)reusableCellForTableView:(UITableView *)tableView
{
    TINProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (!cell) {
        cell = [[TINProductTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:[self reuseIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.placeholderImage = [UIImage imageWithColor:[UIColor whiteColor]];
    }
    
    return cell;
}

- (void)prepareForReuse
{
    [self.imageFetchTask cancel];
    self.imageFetchTask = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.imageView.image = self.placeholderImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // make it a square with 1.0f padding on top/bottom
    self.imageView.frame = ({
        CGRect frame = self.imageView.frame;
        frame.origin.y = 1.0f;
        frame.size.height = CGRectGetHeight(self.bounds) - 2.0f;
        frame.size.width = CGRectGetHeight(self.bounds) - 2.0f;
        frame;
    });
    
    // width to the right of imageView - 5.0f on each side for some padding
    CGFloat remainingWidth = CGRectGetWidth(self.bounds) - CGRectGetMaxX(self.imageView.frame) - 10.0f;
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = ({
        CGRect frame = self.textLabel.frame;
        frame.origin.x = CGRectGetMaxX(self.imageView.frame) + 5.0f;
        frame.origin.y = CGRectGetMidY(self.imageView.frame) - CGRectGetHeight(frame);
        frame.size.width = CGRectGetWidth(frame) > remainingWidth ? remainingWidth : CGRectGetWidth(frame);
        frame;
    });
    
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.frame = ({
        CGRect frame = self.detailTextLabel.frame;
        frame.origin.x = CGRectGetMaxX(self.imageView.frame) + 5.0f;
        frame.origin.y = CGRectGetMidY(self.imageView.frame);
        frame.size.width = CGRectGetWidth(frame) > remainingWidth ? remainingWidth : CGRectGetWidth(frame);
        frame;
    });
}

- (void)setProduct:(NSDictionary *)product forTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    _product = product;
    
    self.textLabel.text = product[@"name"];
    self.detailTextLabel.text = product[@"category"];
    self.imageView.image = self.placeholderImage;

    NSURL *imageURL = [NSURL URLWithString:product[@"image_url"]];
    
    __weak typeof(self) weakSelf = self;
    [self.imageFetchTask cancel];
    self.imageFetchTask = nil;
    self.imageFetchTask = [[TINSessionManager sharedInstance] fetchImageForURL:imageURL
                                                                    completion:^(UIImage *image, NSError *error) {
                                                                        if (!error) {
                                                                            // constrain it to a square, max height of the cell with some padding
                                                                            CGFloat side = CGRectGetHeight(weakSelf.bounds) - 2.0f;
                                                                            CGSize newSize = CGSizeMake(side, side);
                                                                            UIImage *newImage = [image imageScaledToSize:newSize];
                                                                            
                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                if ([tableView cellForRowAtIndexPath:indexPath]) {
                                                                                    weakSelf.imageView.alpha = 0.0f;
                                                                                    weakSelf.imageView.image = newImage;
                                                                                    [UIView animateWithDuration:0.2
                                                                                                          delay:0
                                                                                                        options:UIViewAnimationOptionCurveEaseIn animations:^{
                                                                                                            weakSelf.imageView.alpha = 1.0f;
                                                                                                        }
                                                                                                     completion:nil];
                                                                                }
                                                                            });
                                                                        }
                                                                    }];
}

@end
