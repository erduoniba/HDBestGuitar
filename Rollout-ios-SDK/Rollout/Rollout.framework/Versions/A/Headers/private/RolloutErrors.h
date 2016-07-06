//
//  RolloutErrors.h
//  Rollout
//
//  Created by Sergey Ilyevsky on 9/8/14.
//  Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef RolloutErrors_importingFromDotM
#define _RE(value) NSString *const RolloutErrors_##value = @#value;
#else
#define _RE(value) FOUNDATION_EXPORT NSString *const RolloutErrors_##value;
#endif


_RE(RolloutInvocation_wrongConfiguration)

_RE(RolloutTypeWrapper_wrongConfiguration)

_RE(RolloutTypeFromConfigurationObjectFactory_wrongObjCObjectPointerConfiguration)
_RE(RolloutTypeFromConfigurationObjectFactory_unexpectedObjectType)

_RE(RolloutInvocation_defaultReturnValueCaughtException)
_RE(RolloutInvocation_conditionalReturnValueCaughtException)
_RE(RolloutInvocation_runActionCaughtException)
_RE(RolloutInvocation_tweakedArgumentsCaughtException)

_RE(RolloutInvocationsList_initWithConfigurationCaughtException)
_RE(RolloutInvocationsList_invocationForArgumentsCaughtException)

_RE(RolloutClient_appKeyMismatch)
_RE(RolloutClient_caughtExceptionInPostRecognition)

_RE(RolloutSharedInstances_instanceRecreated)

_RE(Rollout_caughtExceptionDuringInitialization)
_RE(RolloutSharedInstances_caughtExceptionDuringInitialization)
_RE(RolloutActions_caughtExceptionDuringInitialization)
_RE(RolloutConditionOperatorsFactory_caughtExceptionDuringInitialization)
_RE(RolloutInvocation_caughtExceptionDuringInitialization)

_RE(RolloutClientDataParser_caughtUIPasteboardException)

_RE(RolloutDynamic_alreadyInitialized)
_RE(RolloutDynamic_invocationsListFactoryNotInitialized)

_RE(RolloutNetwork_404)
_RE(RolloutNetwork_unknownError)
_RE(RolloutNetwork_timeout)
_RE(RolloutNetwork_jsonParsing)
_RE(RolloutNetwork_emptyResult)
_RE(RolloutNetwork_exceptionInsideAsyncNetworkRequest)
_RE(RolloutNetwork_signatureWasNotVerified)

_RE(RolloutMethodSwizzler_swizzlingFailed)

_RE(RolloutDynamicMethodCaller_unsupported)
_RE(RolloutDynamicMethodCaller_interfaceCreationFailed)
_RE(RolloutDynamicMethodCaller_unexpectedEncoding)

_RE(RolloutJSBoxFactory_couldNotCreateJSBoxFromEncodedValue)

_RE(RolloutSwiftDevModeDataProvider_couldNotInitialize)

@protocol RolloutDeviceProperties;

#ifdef DEBUG
FOUNDATION_EXPORT BOOL RolloutErrors_doNotThrowException;
#endif

@protocol RolloutErrors
-(void)reportError:(NSString*)error details:(NSDictionary*)details;
-(void)generateError:(NSString*)error details:(NSDictionary*)details;
-(void)reportException:(id)exception asError:(NSString*)error;
-(BOOL)assert:(BOOL)condition error:(NSString*)error details:(NSDictionary*)details;
@end

@interface RolloutErrors : NSObject<RolloutErrors>

- (instancetype)initWithDeviceProperties:(id <RolloutDeviceProperties>)deviceProperties;

@property (nonatomic, readonly) NSString *errorsURL;

@end

#undef _RE

