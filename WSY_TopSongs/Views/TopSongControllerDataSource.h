//
//  TopSongControllerDataSource.h
//  WSY_TopSongs
//
//  Created by 袁仕崇 on 15/1/1.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface TopSongControllerDataSource : NSObject <UITableViewDataSource>

- (id)initWithItems: (NSArray *)anItems cellIdentifier: (NSString *)aCellIdentifier
 configureCellBlock: (TableViewCellConfigureBlock)aConfigureBlock;
- (id)itemAtIndexPath: (NSIndexPath *)index;

@end
