//
//  TopSongViewModel.m
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "TopSongViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LastFMClient.h"

@implementation TopSongViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.region = @"russia";
        self.songsListDisplayed = [RACObserve(self, selectedChart) map:^id(NSNumber *value) {
            return @([value integerValue] == TopSongSegmentedSelectedChartSongs);
        }];
        
    }
    return self;
}
- (RACSignal *)fetchObjects {
    RACSignal *dataSignal;
    if (self.selectedChart == TopSongSegmentedSelectedChartSongs) {
        dataSignal = [[[LastFMClient sharedClient] topTracksForRegion:self.region] doNext:^(NSArray *tracks) {
            self.songs = tracks;
        }];
    }else if(self.selectedChart == TopSongSegmentedSelectedChartArtists) {
        dataSignal = [[[LastFMClient sharedClient] topArtistsForRegion:self.region] doNext:^(NSArray *artist) {
            self.artists = artist;
        }];
    }
    return dataSignal;
}


@end
