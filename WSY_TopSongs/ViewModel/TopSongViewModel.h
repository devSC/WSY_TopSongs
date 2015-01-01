//
//  TopSongViewModel.h
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TopSongSegmentedSelectedChart) {
    TopSongSegmentedSelectedChartSongs,
    TopSongSegmentedSelectedChartArtists,
};
@class RACSignal;
@interface TopSongViewModel : NSObject

@property (assign, nonatomic) TopSongSegmentedSelectedChart selectedChart;

@property (strong, nonatomic) NSString *region;
@property (strong, nonatomic) NSString *query;


@property (strong, nonatomic) NSArray *songs;
@property (strong, nonatomic) NSArray *artists;
@property (strong, nonatomic) NSArray *searchResults;

@property (strong, nonatomic, getter=isSongsListDisplayed) RACSignal *songsListDisplayed;

- (RACSignal *)fetchObjects;
- (BOOL)validateQuery: (NSString *)query;
- (RACSignal *)searchArtist: (NSString *)query;


@end
