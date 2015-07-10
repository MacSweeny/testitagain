//
//  TINTableViewCell.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINTableViewCell.h"
#import "TINSessionManager.h"

@interface TINTableViewCell ()

@property(nonatomic, strong) NSURLSessionDataTask *imageFetchTask;

@end

@implementation TINTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (TINTableViewCell *)reusableCellForTableView:(UITableView *)tableView
{
    TINTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (!cell) {
        cell = [[TINTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:[self reuseIdentifier]];
    }
    
    return cell;
}

- (void)prepareForReuse
{
    [self.imageFetchTask cancel];
    self.imageFetchTask = nil;
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.imageView.image = [UIImage imageNamed:@"cellImage"];
}

- (void)setProduct:(NSDictionary *)product
{
    [self.imageFetchTask cancel];
    self.imageFetchTask = nil;
    _product = product;
    
    self.textLabel.text = product[@"name"];
    self.detailTextLabel.text = product[@"category"];
    self.imageView.image = [UIImage imageNamed:@"cellImage"];

    NSURL *imageURL = [NSURL URLWithString:product[@"image_url"]];
    
    __weak typeof(self) weakSelf = self;
    self.imageFetchTask = [[TINSessionManager sharedInstance] fetchImageForURL:imageURL
                                                                    completion:^(UIImage *image, NSError *error) {
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            weakSelf.imageView.image = image;
                                                                        });
                                                                    }];
}

@end
