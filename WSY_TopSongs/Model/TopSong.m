//
//  TopSong.m
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "TopSong.h"

@implementation TopSong

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary {
    TopSong *song = [[TopSong alloc] init];
    song.name = dictionary[@"name"];
    song.artist = [dictionary valueForKey:@"artist.name"];
    song.imageURL = [NSURL URLWithString:dictionary[@"image"][2][@"#text"]];
    return song;
}



@end
