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

@end

@implementation TINProductTableViewCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (TINProductTableViewCell *)reusableCellForTableView:(UITableView *)tableView
{
    TINProductTableViewCell *cell = [[TINProductTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                                   reuseIdentifier:[self reuseIdentifier]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.imageView.image = [UIImage TIN_imageWithColor:[UIColor whiteColor]];
}

- (void)setProduct:(NSDictionary *)product
{
    _product = product;
    
    self.textLabel.text = product[@"name"];
    self.detailTextLabel.text = product[@"category"];
    self.imageView.image = [UIImage TIN_imageWithColor:[UIColor whiteColor]];

    NSURL *imageURL = [NSURL URLWithString:product[@"image_url"]];
    
    [[TINSessionManager sharedInstance] fetchImageForURL:imageURL
                                              completion:^(UIImage *image, NSError *error) {
                                                  if (!error) {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          self.imageView.image = image;
                                                      });
                                                  }
                                              }];
}

@end
