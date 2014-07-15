//
//  INMEnum.m
//  INMEnum
//
//  Created by Satoshi Namai on 2014/07/16.
//  Copyright (c) 2014年 ainame. All rights reserved.
//

#import "INMEnum.h"

#import <objc/runtime.h>

static NSMutableDictionary *globalEnumerateObjectStore;

@interface INMEnum ()
@property (nonatomic, strong) NSString *descriptionString;
@end

@implementation INMEnum

+ (instancetype)enumObject
{
    return [self defineEnum:NSNotFound name:nil description:nil];
}

+ (instancetype)defineEnum:(NSUInteger)ordinal
{
    return [self defineEnum:ordinal name:nil description:nil];
}

+ (instancetype)defineEnum:(NSUInteger)ordinal name:(NSString *)name
{
    return [self defineEnum:ordinal name:name description:nil];
}

+ (instancetype)defineEnum:(NSUInteger)ordinal name:(NSString *)name description:(NSString *)description
{
    NSString *key = NSStringFromClass(self);
    if (!globalEnumerateObjectStore[key] && ordinal == NSNotFound) {
        NSLog(@"undefined enumerate object error %@", self);
        return nil;
    }
    if (globalEnumerateObjectStore[key]) {
        return globalEnumerateObjectStore[key];
    }

    return globalEnumerateObjectStore[key] = [[self alloc] initWithOrdinal:ordinal name:name description:description];
}

+ (INMEnumCaseThen *)then:(void (^)(void))thenBlock
{
    return [[INMEnumCaseThen alloc] initWithCaseCondition:[self enumObject] thenBlock:thenBlock];
}

+ (void) switch:(INMEnum *)testEnumObject cases:(INMEnumCaseThen *)firstCaseThen, ...
{
    va_list args;
    va_start(args, firstCaseThen);
    NSMutableArray *cases = [@[] mutableCopy];
    INMEnumCaseThen *caseThen = firstCaseThen;
    while (caseThen) {
        [cases addObject:caseThen];
        if ([caseThen isDefaultCase]) {
            break;
        }
        caseThen = va_arg(args, typeof(INMEnumCaseThen *));
    }
    va_end(args);

    INMEnumCaseThen *lastCase = [cases lastObject];
    [cases removeLastObject];

    [self _switch:testEnumObject cases:cases lastCase:lastCase];
}

+ (void)_switch:(INMEnum *)testObject cases:(NSMutableArray *)cases lastCase:(INMEnumCaseThen *)lastCase
{
    for (INMEnumCaseThen *eachCase in cases) {
        if ([eachCase testWithTestObject:testObject] && ![eachCase isDefaultCase]) {
            eachCase.thenBlock();
            return;
        }
        eachCase.thenBlock = nil;
    }

    if ([lastCase isDefaultCase]) {
        lastCase.thenBlock();
    } else if ([lastCase testWithTestObject:testObject]) {
        lastCase.thenBlock();
    }
    lastCase.thenBlock = nil;
}

- (instancetype)initWithOrdinal:(NSUInteger)ordinal name:(NSString *)name description:(NSString *)description
{
    self = [super init];
    if (self) {
        _ordinal = ordinal;
        _name = name ? name : NSStringFromClass(self.class);
        _descriptionString = description;
    }
    return self;
}

- (NSString *)description
{
    return _descriptionString ? _descriptionString : [super description];
}

@end

@implementation INMEnumCaseThen

- (instancetype)initWithCaseCondition:(INMEnum *)caseCondition thenBlock:(void (^)(void))thenBlock
{
    self = [super init];
    if (self) {
        _caseCondition = caseCondition;
        _thenBlock = thenBlock;
    }
    return self;
}

- (BOOL)testWithTestObject:(INMEnum *)testObject
{
    if (![testObject isKindOfClass:INMEnum.class]) {
        return NO;
    }

    return testObject == _caseCondition;
}

- (BOOL)isDefaultCase
{
    return NO;
}

@end

@implementation INMEnumCaseDefault

+ (instancetype)then:(void (^)(void))thenBlock
{
    return [[self alloc] initWithCaseCondition:nil thenBlock:thenBlock];
}

- (BOOL)testWithTestObject:(INMEnum *)testObject
{
    return YES;
}

- (BOOL)isDefaultCase
{
    return YES;
}

@end

@implementation INMEnumCollection

+ (void)initialize
{
    if (self == [self class]) {
        [self values];
    }
}

+ (NSArray *)values
{
    return nil;
}

+ (INMEnum *)valueForName:(NSString *)name
{
    NSArray *values = [self values];
    for (INMEnum *value in values) {
        if ([value.name isEqualToString:name]) {
            return value;
        }
    }
    return nil;
}

@end

@implementation INMEnumInitializer

+ (void)initializeAllEnumerateObjects
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalEnumerateObjectStore = [NSMutableDictionary dictionary];
        int count = objc_getClassList(NULL, 0);
        Class classes[count];

        if (count <= 0) {
            return;
        }
        objc_getClassList(classes, count);
        for (int i = 0; i < count; i++) {
            Class clazz = classes[i];
            if (class_getSuperclass(clazz) == INMEnumCollection.class) {
                [clazz initialize];
            }
        }
    });
}

@end
