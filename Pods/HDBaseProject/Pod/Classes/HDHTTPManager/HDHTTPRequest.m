//
//  HTTPRequest.m
//  Shop
//
//  Created by Harry on 13-12-25.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

#import "HDHTTPRequest.h"

@implementation HDHTTPRequest{
    NSDictionary *_defaultParamters;
}

+ (instancetype)shareInstance
{
    return [self shareInstanceWithBaseDemail:@""];
}

+ (instancetype)shareInstanceWithBaseDemail:(NSString *)baseDemail{
    static dispatch_once_t once;
    static HDHTTPRequest *instance = nil;
    dispatch_once(&once, ^{
        instance = [[HDHTTPRequest alloc] initWithBaseURL:[NSURL URLWithString:baseDemail]];
    });
    return instance;
}

- (id)initWithBaseURL:(nullable NSURL *)url{
	self = [super initWithBaseURL:url];
	if (self) {
		[self loadCookies];
        _defaultParamters = [NSDictionary dictionary];
	}
	return self;
}

- (void)setDefaultParamters:(NSDictionary *)defaultParamters{
    _defaultParamters = [NSDictionary dictionaryWithDictionary:defaultParamters];
}


+ (NSUInteger)getCacheData
{
    return [[NSURLCache sharedURLCache] currentMemoryUsage];
}

+ (void)clearAllCacheData
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (NSMutableURLRequest *)setCacheMechanismWith:(NSMutableURLRequest *)request
{
    NSURLCache *cache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
    if(response){
        DLog(@"<= %@该请求有缓存 =>", request.URL.absoluteString);
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }else{
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    }
    
    return request;
}

+ (NSString *)getFileCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
}

- (void)saveCookies{
	NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
	self.sessionCookies = cookiesData;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: cookiesData forKey: @"sessionCookies"];
	[defaults synchronize];
	
}
- (void)loadCookies{
	self.sessionCookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionCookies"];
}


//GET
- (void)GETURLString:(NSString *)URLString
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    [self GETURLString:URLString
           withTimeOut:DefineTimeout
            parameters:parameters
               success:success
               failure:failure];
}

- (void)GETURLString:(NSString *)URLString
         withTimeOut:(CGFloat )timeout
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [NSString stringWithFormat:@"%@/%@", self.baseURL.absoluteString, URLString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:URLString
                                                                  parameters:dic
                                                                       error:nil];
    [request setTimeoutInterval:timeout];
    request = [self setCacheMechanismWith:request];

    [self sendRequest:request success:success failure:failure];

    DLog(@"GET:\n%@", request.URL.absoluteString);
}

- (void)GETURLString:(NSString *)URLString
           userCache:(BOOL)isCache
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:URLString
                                                                  parameters:dic
                                                                       error:nil];
    [request setTimeoutInterval:DefineTimeout];
    //使用缓存
    if(isCache){
        request = [self setCacheMechanismWith:request];
    }
    
    [self sendRequest:request success:success failure:failure];
    
    DLog(@"GET:\n%@", request.URL.absoluteString);
}

//POST
- (void)POSTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self POSTURLString:URLString
            withTimeout:DefineTimeout
             parameters:parameters
                success:success
                failure:failure];
}

- (void)POSTURLString:(NSString *)URLString
          withTimeout:(CGFloat )timeout
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:URLString
                                                                  parameters:dic
                                                                       error:nil];
    [request setTimeoutInterval:timeout];

    [self sendRequest:request success:success failure:failure];
    
    DLog(@"POST:\n%@ parameters:%@", request.URL.absoluteString, dic);
}

- (void)POSTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
            imageData:(NSData *)data
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                                URLString:URLString
                                                                               parameters:dic
                                                                constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"ebsIcon.png" mimeType:@"image/png"];
    }                                                                          error:nil];
    
    [request setTimeoutInterval:DefineTimeout];

    [self sendRequest:request success:success failure:failure];
    
    DLog(@"PUT:\n%@", request.URL.absoluteString);
}

//PUT
- (void )PUTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self PUTURLString:URLString
           withTimeout:DefineTimeout
            parameters:parameters
               success:success
               failure:failure];
}

- (void )PUTURLString:(NSString *)URLString
          withTimeout:(CGFloat )timeout
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"PUT"
                                                                   URLString:URLString
                                                                  parameters:dic
                                                                       error:nil];
    [request setTimeoutInterval:timeout];

    [self sendRequest:request success:success failure:failure];
    
    DLog(@"PUT:\n%@", request.URL.absoluteString);
}

//DELETE
- (void )DELETEURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self DELETEURLString:URLString
              withTimeout:DefineTimeout
               parameters:parameters
                  success:success
                  failure:failure];
}

- (void )DELETEURLString:(NSString *)URLString
             withTimeout:(CGFloat )timeout
              parameters:(NSDictionary *)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    dic = [self appendRoutineParameterTo:dic];
    
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"DELETE" URLString:URLString parameters:dic error:nil];
    [request setTimeoutInterval:timeout];

    [self sendRequest:request success:success failure:failure];
    
    DLog(@"DELETE:\n%@", request.URL.absoluteString);
}

- (NSMutableDictionary *)appendRoutineParameterTo:(NSMutableDictionary *)dic
{
    [dic addEntriesFromDictionary:_defaultParamters];
    return dic;
}

- (void)sendRequest:(NSMutableURLRequest *)request
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
	
	if (_sessionCookies != nil) {
		NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: _sessionCookies];
		NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
		
		for (NSHTTPCookie *cookie in cookies){
			[cookieStorage setCookie: cookie];
		}
	}
	
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"response:{\n %@ \n}", operation.responseString);
        
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        success(operation, dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
    
    //tag by harry 20150812
    // 修改AFN请求方式:由HTTPRequestOperationWithRequest调用AFN本身的方法改为 setCompletionBlockWithSuccess:failure:方法，用于实现项目对同一异常或者解析做统一捕获处理，比如404错误，session过期
    //[self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
}

@end
