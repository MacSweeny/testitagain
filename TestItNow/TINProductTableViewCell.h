//
//  TINProductTableViewCell.h
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TINProductTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) IBOutlet UILabel *categoryLabel;
@property(nonatomic, strong) IBOutlet UIImageView *productImageView;

+ (NSString *)reuseIdentifier;

- (void)setProduct:(NSDictionary *)product
      forTableView:(UITableView *)tableView
         indexPath:(NSIndexPath *)indexPath;

@end
