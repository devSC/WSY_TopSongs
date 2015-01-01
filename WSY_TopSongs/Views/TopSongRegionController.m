//
//  TopSongRegionController.m
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "TopSongControllerDataSource.h"
#import "TopSongRegionController.h"
#import "TopSongViewModel.h"

@interface TopSongRegionController ()

@property (strong, nonatomic) NSArray *regions;
@property (strong, nonatomic) TopSongControllerDataSource *controllerDataSource;

@end

@implementation TopSongRegionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.regions = @[@"china", @"USA", @"spain", @"belarus", @"russia"];
    
    
    [self setupTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, NSString *title) {
        cell.textLabel.text = title;
    };
    self.controllerDataSource = [[TopSongControllerDataSource alloc] initWithItems:self.regions cellIdentifier:@"Cell" configureCellBlock:configureCell];
    self.tableView.dataSource = self.controllerDataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.regions.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell.textLabel.text = self.regions[indexPath.row];
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.viewModel.region = self.regions[indexPath.row];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
