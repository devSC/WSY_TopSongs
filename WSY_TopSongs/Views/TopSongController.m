//
//  TopSongController.m
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 14/12/31.
//  Copyright (c) 2014年 wilson-yuan. All rights reserved.
//

#import "TopSongController.h"
#import "TopSongViewModel.h"
#import "TopSongArtist.h"
#import "TopSong.h"

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface TopSongController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchControl;

@property (strong, nonatomic) TopSongViewModel *viewModel;
@end

@implementation TopSongController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.viewModel = [[TopSongViewModel alloc] init];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.refreshControl = [[UIRefreshControl alloc] init];
    @weakify(self);
    RACSignal *refreshSignal = [self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged];
    RACSignal *viewApperedSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    RACSignal *segmentedChangedSignal = [self.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged];
    
    
    RAC(self.searchControl, hidden) = [self.viewModel isSongsListDisplayed];
    //给selectedChart赋值
    RAC(self.viewModel, selectedChart) = [self.segmentedControl rac_newSelectedSegmentIndexChannelWithNilValue:nil];
    
    [[[RACSignal merge:@[segmentedChangedSignal, viewApperedSignal, refreshSignal]] flattenMap:^RACStream *(id value) {
        @strongify(self);
         [self.tableView reloadData];
        return [self.viewModel fetchObjects];
    }] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } error:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];

//[refreshSignal subscribeNext:^(id x) {
//    @strongify(self);
//    [self.tableView reloadData];
//    [self.refreshControl endRefreshing];
//}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.viewModel.selectedChart == 0 ? self.viewModel.songs.count : self.viewModel.artists.count;
    } else {
        return self.viewModel.searchResults.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.tableView == tableView) {
        if (self.viewModel.selectedChart == 0) {
            TopSong *song = self.viewModel.songs[indexPath.row];
            cell.textLabel.text = song.name;
            cell.detailTextLabel.text = song.artist;
            [cell.imageView setImageWithURL:song.imageURL placeholderImage:nil];
        } else {
            TopSongArtist *artist = self.viewModel.artists[indexPath.row];
            cell.textLabel.text = artist.name;
            [cell.imageView setImageWithURL:artist.imageURL];
        }
    } else {
        TopSongArtist *artist = self.viewModel.searchResults[indexPath.row];
        cell.textLabel.text = artist.name;
        [cell.imageView setImageWithURL:artist.imageURL];
    }
    
    return cell;
}

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
////    return ![self.searchDisplayController isActive] ||
////    [self.viewModel validateQuery:searchBar.text];
//}


@end
