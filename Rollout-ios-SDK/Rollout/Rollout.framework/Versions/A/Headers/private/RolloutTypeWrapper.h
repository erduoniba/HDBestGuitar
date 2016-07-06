//
//  RolloutPrimitiveTypeWrapper.h
//  Rollout
//
//  Created by Sergey Ilyevsky on 9/3/14.
//  Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RolloutEnum.h"
#import <JavaScriptCore/JavaScriptCore.h>

typedef enum {
    RolloutTypeVoid,
    RolloutTypePointer,
    RolloutTypeRecordPointer,
    RolloutTypeObjCObjectPointer,
    RolloutTypeNumber,
    RolloutTypeBool,
    RolloutTypesCount
} RolloutType;

@class RolloutInvocationDynamicData;

@interface RolloutTypeWrapper : NSObject

-(id)initWithInt:(int)value;
-(id)initWithUShort:(unsigned short)value;
-(id)initWithInt128:(int)value;
-(id)initWithUInt128:(unsigned int)value;
-(id)initWithShort:(short)value;
-(id)initWithLong:(long)value;
-(id)initWithULong:(unsigned long)value;
-(id)initWithLongLong:(long long)value;
-(id)initWithULongLong:(unsigned long long)value;
-(id)initWithUInt:(unsigned int)value;
-(id)initWithLongDouble:(long double)value;
-(id)initWithFloat:(float)value;
-(id)initWithDouble:(double)value;
-(id)initWithBool:(bool)value;
-(id)initWithChar16:(char)value;
-(id)initWithChar32:(char)value;
-(id)initWithChar_U:(char)value;
-(id)initWithWChar:(wchar_t)value;
-(id)initWithUChar:(unsigned char)value;
-(id)initWithSChar:(signed char)value;
-(id)initWithChar_S:(char)value;
-(id)initWithEnum:(__rollout_enum)value;
-(id)initWithObjCObjectPointer:(id)value;
-(id)initWithPointer:(void *)value;
-(id)initWithRecordPointer:(void *)pointer ofSize:(size_t)size shouldBeFreedInDealloc:(BOOL)shouldBeFreedOnDealloc;
-(id)initWithNumber:(NSNumber*)number;
-(id)initWithVoid;

@property (nonatomic, readonly) RolloutType type;

-(NSNumber *)numberValue;
-(int)intValue;
-(unsigned short)uShortValue;
-(int)int128Value;
-(unsigned int)uInt128Value;
-(short)shortValue;
-(long)longValue;
-(unsigned long)uLongValue;
-(long long)longLongValue;
-(unsigned long long)uLongLongValue;
-(unsigned int)uIntValue;
-(long double)longDoubleValue;
-(float)floatValue;
-(double)doubleValue;
-(bool)boolValue;
-(char)char16Value;
-(char)char32Value;
-(char)char_UValue;
-(wchar_t)wCharValue;
-(unsigned char)uCharValue;
-(signed char)sCharValue;
-(char)char_SValue;
-(__rollout_enum)enumValue;

-(NSString*) valueDescription;


@property (nonatomic, readonly) id objCObjectPointerValue;
@property (nonatomic, readonly) void* pointerValue;
@property (nonatomic, readonly) void* recordPointer;
@property (nonatomic, readonly) size_t recordSize;

@end

