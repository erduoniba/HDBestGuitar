//
//  HDHTTPSessionManager.h
//  Pods
//
//  Created by 邓立兵 on 2016/11/8.
//
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

#pragma mark -
#pragma mark - HDRequestManagerConfig
#pragma mark -

/****************************************************
 *   请求配置类，比如设置baseURL，request／response的方式
 *
 *****************************************************/
@interface HDRequestManagerConfig : NSObject

@property (nonatomic, strong) NSString *baseURL;
/**
 *  默认使用 AFHTTPRequestSerializer, 也可以使用AFJSONRequestSerializer等其他模式
 */
@property (nonatomic) AFHTTPRequestSerializer *requestSerializer;

/**
 *  默认使用 AFHTTPResponseSerializer，也可以使用AFJSONResponseSerializer等其他
 */
@property (nonatomic) AFHTTPResponseSerializer *responseSerializer;

/**
 *  请求超时设置，默认为20秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  http的header参数
 */
@property (nonatomic,strong) NSDictionary *httpDefaulHeaders;

@end



#pragma mark -
#pragma mark - HDHTTPSessionRequest
#pragma mark -

/****************************************************
 *   HTTP请求类，提供GET、POST、DELETE、PUT方法
 *
 *****************************************************/

typedef void(^HDRequestManagerSuccess)(NSURLSessionDataTask *httpbase, id responseObject);
typedef void(^HDRequestManagerFailure)(NSURLSessionDataTask *httpbase, NSError *error);

@interface HDHTTPSessionRequest : NSObject

+ (instancetype)shareInstance;

/**
 *  当前的网络状态
 */
@property(nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

/**
 *  拿到 sharedInstance 后，可以设置这个 property，当 configuration 中的某几项有变动，
 *  并且要对全局做更改时，可以再次设置这个 property
 */
@property(nonatomic, strong) HDRequestManagerConfig *configuration;


/**
 *  设置项目网络请求的默认参数，如session，token等
 *
 *  @param defaultParamters 项目网络请求的默认参数，如session，token等
 */
- (void)setDefaultParamters:(NSDictionary *)defaultParamters;


- (NSURLSessionDataTask *)get:(NSString *)url
                    paramters:(NSDictionary *)paramters
                configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                      success:(HDRequestManagerSuccess)success
                      failure:(HDRequestManagerFailure)failure;

- (NSURLSessionDataTask *)post:(NSString *)url
                     paramters:(NSDictionary *)paramters
                 configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                       success:(HDRequestManagerSuccess)success
                       failure:(HDRequestManagerFailure)failure;

- (NSURLSessionDataTask *)deleted:(NSString *)url
                     paramters:(NSDictionary *)paramters
                 configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                       success:(HDRequestManagerSuccess)success
                       failure:(HDRequestManagerFailure)failure;

- (NSURLSessionDataTask *)put:(NSString *)url
                   parameters:(NSDictionary *)paramters
         configurationHandler:(void (^)(HDRequestManagerConfig *))configHandler
                      success:(HDRequestManagerSuccess)success
                      failure:(HDRequestManagerFailure)failure;

@end
