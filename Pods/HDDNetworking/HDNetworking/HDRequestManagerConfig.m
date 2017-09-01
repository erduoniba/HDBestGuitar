//
//  HDRequestManagerConfig.m
//  HDNewHouseDemo
//
//  Created by denglibing on 2017/6/9.
//  Copyright © 2017年 denglibing. All rights reserved.
//

#import "HDRequestManagerConfig.h"

const CGFloat HDRequestTimeoutInterval = 10.0f;

@implementation HDRequestManagerConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _timeoutInterval = HDRequestTimeoutInterval;
        _requestCachePolicy = HDRequestReturnLoadToCache;
    }
    return self;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    if (!_requestSerializer) {
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _requestSerializer.timeoutInterval = _timeoutInterval;
    }
    return _requestSerializer;
}

- (AFHTTPResponseSerializer *)responseSerializer {
    if (!_responseSerializer) {
        _responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _responseSerializer;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    HDRequestManagerConfig *configuration = [[HDRequestManagerConfig alloc] init];
    configuration.resultCacheDuration = self.resultCacheDuration;
    configuration.baseURL = [self.baseURL copy];
    configuration.builtinHeaders = [self.builtinHeaders copy];
    configuration.builtinBodys = [self.builtinBodys copy];
    configuration.resposeHandle = [self.resposeHandle copy];
    configuration.requestSerializer = [self.requestSerializer copy];
    configuration.responseSerializer = [self.responseSerializer copy];
    configuration.responseSerializer.acceptableContentTypes = self.responseSerializer.acceptableContentTypes;
    return configuration;
}

@end
