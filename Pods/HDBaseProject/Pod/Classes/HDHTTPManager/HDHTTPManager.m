//
//  HTTPMethods.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDHTTPManager.h"

#import "HDHTTPRequest.h"

@implementation HDHTTPManager

+ (void)getWeixinJingxuanPageIndex:(NSInteger)pageIndex
                           success:(httpRequestSuccess)success
                           failure:(httpRequestFailure)failure{
    [[HDHTTPRequest shareInstance] GETURLString:@"181-1" parameters:@{@"page" : @(pageIndex)} success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        
        DLog(@"response : %@",operation.responseString);
        success(responseObj);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.description);
    }];
}

@end
