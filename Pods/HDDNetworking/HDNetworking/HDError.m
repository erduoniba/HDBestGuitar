//
//  HDError.m
//  HDNewHouseDemo
//
//  Created by denglibing on 2017/6/12.
//  Copyright © 2017年 denglibing. All rights reserved.
//

#import "HDError.h"

@implementation HDError

static inline NSDictionary* errorMessageMap() {
    return @{
             @"999999" : @"当前暂无网络",
             };
}


+ (HDError *)hdErrorNetNotReachable {
    HDError *hdError = [HDError new];
    hdError.errorCode = @"999999";
    NSString *errorMessage = errorMessageMap()[hdError.errorCode];
    if (errorMessage) {
        hdError.errorMessage = errorMessage;
    }
    else {
        hdError.errorMessage = @"当前暂无网络";
    }
    hdError.errorMessageDescription = @"AFNetwork监测当前暂无网络";
    return hdError;
}

+ (HDError *)hdErrorHttpError:(NSError *)error {
    HDError *hdError = [HDError new];
    hdError.errorCode = [NSString stringWithFormat:@"%d", (int)error.code];
    hdError.errorMessage = error.localizedDescription;
    hdError.errorMessageDescription = error.localizedDescription;
    return hdError;
}

@end
