//
//  HackerNewsManager.m
//  Networking-Example
//
//  Created by Saleh AlDhobaie on 4/24/16.
//  Copyright © 2016 Saleh AlDhobaie. All rights reserved.
//

#import "HackerNewsManager.h"
#import "NSDictionary+objectForKeyOrNil.h"


NSString * const HackerNewsBaseURL = @"https://hacker-news.firebaseio.com";

NSString * const HackerNewsResourceTopSories = @"/v0/topstories.json";



@implementation HackerNewsManager

#pragma mark -
#pragma mark - Singleton Method


+ (instancetype)sharedManager {
    
    
    
    static HackerNewsManager *_instanse = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURL *url = [NSURL URLWithString:HackerNewsBaseURL];
        _instanse = [[HackerNewsManager alloc]initWithBaseURL:url sessionConfiguration:config];
        
        _instanse.responseSerializer = [AFJSONResponseSerializer serializer];
        [_instanse.reachabilityManager startMonitoring];
        
    });
    
    return _instanse;
}


#pragma mark - Top Stories


- (NSURLSessionDataTask *)topStories:(void (^)(id results, NSURLSessionDataTask *successTask))success failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure {
    
    NSURLSessionDataTask *task =[self GET:HackerNewsResourceTopSories parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error, task);
    }];
    
    
    return task;
    
}



#pragma mark - Story Details

- (NSURLSessionDataTask *)storyDetailsWithIdentifier:(NSNumber *)identifier success:(void (^)(id results, NSURLSessionDataTask *successTask))success failure:(void (^)(NSError *error, NSURLSessionDataTask *task))failure {
    
    NSString * path = [NSString stringWithFormat:@"/v0/item/%@.json", identifier];
    
    NSURLSessionDataTask *task =[self GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject, task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error, task);
    }];
    
    
    return task;
    
}



@end
