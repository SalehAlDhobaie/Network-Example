//
//  HackerNewsManager.h
//  Networking-Example
//
//  Created by Saleh AlDhobaie on 4/24/16.
//  Copyright © 2016 Saleh AlDhobaie. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@interface HackerNewsManager : AFHTTPSessionManager



+(instancetype _Nonnull)sharedManager;

- (NSURLSessionDataTask * _Nonnull)topStories:(void (^ _Nonnull)(id _Nonnull results, NSURLSessionDataTask * _Nonnull successTask ))success failure:(void (^ _Nonnull)(NSError * _Nonnull error, NSURLSessionDataTask * _Nonnull task ))failure;

- (NSURLSessionDataTask * _Nonnull)storyDetailsWithIdentifier:(NSNumber * _Nonnull)identifier success:(void (^ _Nonnull)(id _Nonnull results, NSURLSessionDataTask * _Nonnull successTask ))success failure:(void (^ _Nonnull)(NSError * _Nonnull error, NSURLSessionDataTask * _Nonnull task ))failure;

@end
