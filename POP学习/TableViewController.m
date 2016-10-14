//
//  TableViewController.m
//  POP学习
//
//  Created by Jude on 16/9/29.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "TableViewController.h"
#import "MenuTableViewCell.h"
#import "UIColor+CustomColors.h"
#import "ButtonViewController.h"
#import "CircleViewController.h"

static NSString * const kCellIdentifier = @"cellIdentifier";

@interface TableViewController ()
@property(nonatomic) NSArray *items;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"popping";
    [self configureTableView];
    [self configureTitleView];
}

#pragma mark - Private Instance methods

- (void)configureTableView
{
    self.items = @[@[@"Button Animation", [ButtonViewController class]],
                   @[@"Circle Animation", [CircleViewController class]],
                   ];
    [self.tableView registerClass:[MenuTableViewCell class]
           forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.f;
}

- (void)configureTitleView
{
    UILabel *headlinelabel = [UILabel new];
    headlinelabel.font = [UIFont fontWithName:@"Avenir-Light" size:28];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = [UIColor customGrayColor];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.title];;
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor customBlueColor] range:NSMakeRange(1, 1)];
    headlinelabel.attributedText = attributeString;
    [headlinelabel sizeToFit];

    [self.navigationItem setTitleView:headlinelabel];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                              forIndexPath:indexPath];
    cell.textLabel.text = [self.items[indexPath.row] firstObject];
    return cell;
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController
                                        animated:YES];
}


@end
