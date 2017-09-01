#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AFNetworkActivityLogger.h"
#import "HDError.h"
#import "HDNetworking.h"
#import "HDRequestConvertManager.h"
#import "HDRequestManagerConfig.h"

FOUNDATION_EXPORT double HDDNetworkingVersionNumber;
FOUNDATION_EXPORT const unsigned char HDDNetworkingVersionString[];

