//
//  LastFMClient.h
//  
//
//  Created by 袁仕崇 on 15/1/1.
//
//

#import "AFHTTPRequestOperationManager.h"

@class RACSignal;

@interface LastFMClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
- (RACSignal *)topTracksForRegion: (NSString *)region;
- (RACSignal *)topArtistsForRegion: (NSString *)region;
- (RACSignal *)searchArtist: (NSString *)query;

@end
