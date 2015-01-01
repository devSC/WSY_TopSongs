//
//  TopSong.h
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopSong : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *artist;
@property (strong, nonatomic) NSURL *imageURL;

+ (instancetype)objectFromDictionary:(NSDictionary *)dictionary;

@end
