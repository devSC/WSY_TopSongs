//
//  TopSongArtist.m
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "TopSongArtist.h"

@implementation TopSongArtist
+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary
{
    TopSongArtist *artist = [[self alloc] init];
    artist.name = dictionary[@"name"];
    artist.imageURL = [NSURL URLWithString:dictionary[@"image"][2][@"#text"]];
    return artist;
}
@end
