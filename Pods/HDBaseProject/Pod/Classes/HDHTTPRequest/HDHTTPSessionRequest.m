//
//  HDHTTPSessionManager.m
//  Pods
//
//  Created by 邓立兵 on 2016/11/8.
//
//

#import "HDHTTPSessionRequest.h"

@implementation HDRequestManagerConfig

- (AFHTTPRequestSerializer *)requestSerializer{
    if (!_requestSerializer) {
        AFHTTPRequestSerializer *serial = [AFHTTPRequestSerializer serializer];
        serial.timeoutInterval = 20.0;
        _requestSerializer = serial;
    }
    return _requestSerializer;
}

- (AFHTTPResponseSerializer *)responseSerializer{
    return _responseSerializer ? : [AFJSONResponseSerializer serializer];
}

- (instancetype)copyWithZone:(NSZone *)zone{
    HDRequestManagerConfig *configuration = [[HDRequestManagerConfig alloc] init];
    configuration.baseURL = [self.baseURL copy];
    return configuration;
}

@end



@interface HDHTTPSessionRequest ()

/**
 *  http请求类
 */
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

@property (nonatomic, strong) NSDictionary *defaultParamters;

@end

@implementation HDHTTPSessionRequest

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.networkStatus = AFNetworkReachabilityStatusUnknown;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    }
    return self;
}

- (void)reachabilityChange:(NSNotification *)notification{
    self.networkStatus = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
}

#pragma mark - 实例化
- (AFHTTPSessionManager *)requestManager{
    if (!_requestManager) {
        _requestManager = [AFHTTPSessionManager manager] ;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        _requestManager.securityPolicy = securityPolicy;
    }
    return _requestManager;
}

- (HDRequestManagerConfig *)configuration{
    if (!_configuration) {
        _configuration = [[HDRequestManagerConfig alloc] init];
        _configuration.timeoutInterval = 20.0f;
    }
    return _configuration;
}


- (void)setDefaultParamters:(NSDictionary *)defaultParamters{
    _defaultParamters = [NSDictionary dictionaryWithDictionary:defaultParamters];
}

- (NSMutableDictionary *)appendRoutineParameterTo:(NSMutableDictionary *)dic{
    if (_defaultParamters.count > 0) {
        [dic addEntriesFromDictionary:_defaultParamters];
    }
    return dic;
}

#pragma mark - 具体请求实现
- (NSURLSessionDataTask *)get:(NSString *)url
                    paramters:(NSDictionary *)paramters
                configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                      success:(HDRequestManagerSuccess)success
                      failure:(HDRequestManagerFailure)failure{
    return [self HTTPRequestOperationWithMethod:@"GET"
                                      URLString:url
                                     parameters:paramters
                           configurationHandler:configHandler
                                        success:success
                                        failure:failure];
}

- (NSURLSessionDataTask *)post:(NSString *)url
                     paramters:(NSDictionary *)paramters
                 configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                       success:(HDRequestManagerSuccess)success
                       failure:(HDRequestManagerFailure)failure{
    return [self HTTPRequestOperationWithMethod:@"POST"
                                      URLString:url
                                     parameters:paramters
                           configurationHandler:configHandler
                                        success:success
                                        failure:failure];
}

- (NSURLSessionDataTask *)deleted:(NSString *)url
                        paramters:(NSDictionary *)paramters
                    configHandler:(void (^)(HDRequestManagerConfig *))configHandler
                          success:(HDRequestManagerSuccess)success
                          failure:(HDRequestManagerFailure)failure{
    return [self HTTPRequestOperationWithMethod:@"DELETE"
                                      URLString:url
                                     parameters:paramters
                           configurationHandler:configHandler
                                        success:success
                                        failure:failure];
}

- (NSURLSessionDataTask *)put:(NSString *)url
                   parameters:(NSDictionary *)paramters
         configurationHandler:(void (^)(HDRequestManagerConfig *))configHandler
                      success:(HDRequestManagerSuccess)success
                      failure:(HDRequestManagerFailure)failure{
    return [self HTTPRequestOperationWithMethod:@"PUT"
                                      URLString:url
                                     parameters:paramters
                           configurationHandler:configHandler
                                        success:success
                                        failure:failure];
}


- (NSURLSessionDataTask *)HTTPRequestOperationWithMethod:(NSString *)method
                                               URLString:(NSString *)URLString
                                              parameters:(NSDictionary *)parameters
                                    configurationHandler:(void (^)(HDRequestManagerConfig *))configurationHandler
                                                 success:(HDRequestManagerSuccess)success
                                                 failure:(HDRequestManagerSuccess)failure{
    HDRequestManagerConfig *configuration = [self.configuration copy];
    if (configurationHandler) {
        configurationHandler(configuration);
    }
    self.requestManager.requestSerializer = configuration.requestSerializer;
    self.requestManager.responseSerializer = configuration.responseSerializer;
    
    if (configuration.httpDefaulHeaders.count > 0) {
        for (NSString *key in configuration.httpDefaulHeaders) {
            [self.requestManager.requestSerializer setValue:configuration.httpDefaulHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    NSString *requestUrl;
    if ([URLString hasPrefix:@"http"] || [URLString hasPrefix:@"https"]) {
        requestUrl = URLString;
    }
    else {
        requestUrl = [[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:configuration.baseURL]] absoluteString];
    }
    
    if (configuration.timeoutInterval > 0) {
        self.requestManager.requestSerializer.timeoutInterval = configuration.timeoutInterval;
    }
    else {
        self.requestManager.requestSerializer.timeoutInterval = 20.0f;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    NSMutableURLRequest *request = [self.requestManager.requestSerializer requestWithMethod:method URLString:requestUrl parameters:dic error:nil];
    
    __block NSURLSessionDataTask *dataTask = nil;
    AFHTTPSessionManager *manager = self.requestManager;
    dataTask = [manager dataTaskWithRequest:request
                             uploadProgress:nil
                           downloadProgress:nil
                          completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                              if (error) {
                                  failure(dataTask, responseObject);
                              }
                              else {
                                  success(dataTask, responseObject);
                              }
                          }];
    
    [dataTask resume];
    return dataTask;
}

@end
