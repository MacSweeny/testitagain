//
//  TINProductTableViewCell.h
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TINProductTableViewCell : UITableViewCell

@property(nonatomic, strong) NSDictionary *product;

+ (NSString *)reuseIdentifier;

+ (TINProductTableViewCell *)reusableCellForTableView:(UITableView *)tableView;

@end
