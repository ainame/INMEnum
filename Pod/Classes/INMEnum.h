//
//  INMEnum.h
//  INMEnum
//
//  Created by Satoshi Namai on 2014/07/16.
//  Copyright (c) 2014年 ainame. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INMEnumCaseThen;

/**
 * can create enum object like Java lang's enum by INMEnum.
 * should use this class as super class of your enum object.
 *
 * @warning INMEnum have a constraint that you can't use its sub classes before initializing of Enumerate Collection class.
 * @see You can use INMEnumInitializer to initialize enum objetcs.
 */
@interface INMEnum : NSObject

/**
 * retrive enum object as a singleton instance.
 */
+ (instancetype)enumObject;

/**
 * define enum object in `[INMEnumCollection values]`
 * must not use other places.
 *
 * give only ordinal value to enum object.
 *
 * @param ordinal ordinal value to set property
 * @return self instance
 */
+ (instancetype)defineEnum:(NSUInteger)ordinal;

/**
 * define enum object in `[INMEnumCollection values]`
 * must not use other places.
 *
 * give ordinal and name value to enum object.
 * name value can be used in `[INMEnumCollection valueForName]`.
 *
 * @param ordinal ordinal value to set property
 * @param name name value to set property
 * @return self instance
 */
+ (instancetype)defineEnum:(NSUInteger)ordinal name:(NSString *)name;

/**
 * define enum object in `[INMEnumCollection values]`
 * must not use other places.
 *
 * give ordinal and name value to enum object.
 * `name` value can be used in `[INMEnumCollection valueForName]`.
 * can give `description` as a human readable or underlying value this.
 *
 * @param ordinal ordinal value to set property
 * @param name name value to set property
 * @param description underlying string value to get description method
 * @return self instance
 */
+ (instancetype)defineEnum:(NSUInteger)ordinal name:(NSString *)name description:(NSString *)description;

+ (void) switch:(INMEnum *)testEnumObject cases:(INMEnumCaseThen *)caseThen, ...;

+ (INMEnumCaseThen *)then:(void (^)(void))thenBlock;

/**
 * ordinal value of enum object
 */
@property (nonatomic, assign, readonly) NSUInteger ordinal;

/**
 * ordinal value of enum object.
 * if you don't given this initializer, will return the string of class name.
 */
@property (nonatomic, strong, readonly) NSString *name;

@end

/**
 * define case then object
 */
@interface INMEnumCaseThen : NSObject

@property (nonatomic, weak) INMEnum *caseCondition;

@property (nonatomic, copy) void (^thenBlock)(void);

- (instancetype)initWithCaseCondition:(INMEnum *)caseCondition thenBlock:(void (^)(void))thenBlock;

- (BOOL)testWithTestObject:(INMEnum *)testObject;

- (BOOL)isDefaultCase;

@end

@interface INMEnumCaseDefault : INMEnumCaseThen

+ (instancetype)then:(void (^)(void))thenBlock;

@end

/**
 * should use INMEnumCollection as a super class for your enumeration values.
 * all that you write is the implementation class which overrided `values` method.
 */
@interface INMEnumCollection : NSObject

/**
 * You must orverride to define your enumeration values.
 */
+ (NSArray *)values;

/**
 * retrive a enumerated object for name
 * @param name key for enumerate object which included this collection.
 * @return instance for name
 */
+ (id)valueForName:(NSString *)name;

@end

/**
 * INMEnumInitializer do initialize all your defined enumerate classes.
 * INMEnum have constraint that you can't use its sub classes before initializing of Enumerate Collection class.
 * So,this will help to initialize all enumerate object at once.
 */
@interface INMEnumInitializer : NSObject

/**
 * initialize all enumearate objects via sub classes of INMEnumCollection
 */
+ (void)initializeAllEnumerateObjects;

@end
