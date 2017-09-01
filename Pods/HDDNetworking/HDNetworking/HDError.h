//
//  HDError.h
//  HDNewHouseDemo
//
//  Created by denglibing on 2017/6/12.
//  Copyright © 2017年 denglibing. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 网络请求中的错误类，基于系统NSError，添加了一些其他自定义的错误类
 */
@interface HDError : NSObject

+ (HDError *)hdErrorNetNotReachable;
+ (HDError *)hdErrorHttpError:(NSError *)error;

/**
 错误编码，最好是根据这个值给用户 友善 的提示
 */
@property (nonatomic,strong) NSString *errorCode;


/**
 错误的信息,可以直接显示给用户
 */
@property (nonatomic,strong) NSString *errorMessage;


/**
 错误的具体信息,不建议直接显示给用户
 */
@property (nonatomic,strong) NSString *errorMessageDescription;

@end
