//
//  LastFMClient.m
//  
//
//  Created by 袁仕崇 on 15/1/1.
//
//

#import "LastFMClient.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TopSong.h"
#import "TopSongArtist.h"

@implementation LastFMClient
+ (instancetype)sharedClient
{
    static LastFMClient *lastFMclient;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        lastFMclient = [LastFMClient manager];
    });
    return lastFMclient;
}
+ (instancetype)manager
{
    return [[self alloc] initWithBaseURL:nil];
}

- (RACSignal *)topTracksForRegion:(NSString *)region
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperation *op = [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"geo.gettoptracks", @"country": region, @"api_key": @"d906be6d99e5b63a6b21bef23d8086fb", @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@", responseObject);
            NSArray *artists = [[[responseObject[@"toptracks"][@"track"] rac_sequence] map:^id(NSDictionary *artist) {
                return [TopSong objectFromDictionary:artist];
            }] array];
            [subscriber sendNext:artists];
            [subscriber sendCompleted];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [op cancel];
        }];
    }] replayLazily];
}

- (RACSignal *)topArtistsForRegion:(NSString *)region
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"geo.gettopartists", @"country": region, @"api_key": @"d906be6d99e5b63a6b21bef23d8086fb", @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *artists = [[[responseObject[@"topartists"][@"artist"] rac_sequence] map:^id(NSDictionary *artist) {
                return [TopSongArtist objectFromDictionary:artist];
            }] array];
            [subscriber sendNext:artists];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }] replayLazily];
}

- (RACSignal *)searchArtist:(NSString *)query
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:@"http://ws.audioscrobbler.com/2.0/" parameters:@{@"method": @"artist.search", @"artist": query, @"api_key": @"d906be6d99e5b63a6b21bef23d8086fb", @"format": @"json"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject[@"results"][@"artistmatches"][@"artist"]) {
                NSArray *artists = [[[responseObject[@"results"][@"artistmatches"][@"artist"] rac_sequence] map:^id(NSDictionary *artist) {
                    return [TopSongArtist objectFromDictionary:artist];
                }] array];
                [subscriber sendNext:artists];
            } else {
                [subscriber sendNext:nil];
            }
            
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }] replayLazily];

}
@end
