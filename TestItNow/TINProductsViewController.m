//
//  TINProductsViewController.m
//  TestItNow
//
//  Created by Michael Soares on 7/9/15.
//  Copyright (c) 2015 Postmates. All rights reserved.
//

#import "TINProductsViewController.h"
#import "TINProducts.h"
#import "TINProductTableViewCell.h"

@interface TINProductsViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *products;

@end

@implementation TINProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Test It Now";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.products = [TINProducts products];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TINProductTableViewCell" bundle:nil]
         forCellReuseIdentifier:[TINProductTableViewCell reuseIdentifier]];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    self.tableView.frame = frame;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    TINProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TINProductTableViewCell reuseIdentifier]
                                                                    forIndexPath:indexPath];
    NSDictionary *product = [self.products objectAtIndex:indexPath.row];
    [cell setProduct:product forTableView:tableView indexPath:indexPath];
    return cell;
}

@end
