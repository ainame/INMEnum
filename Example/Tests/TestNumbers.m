//
//  TestNumbers.m
//  AMEEnumeratedObject
//
//  Created by Satoshi Namai on 2014/07/14.
//  Copyright (c) 2014年 ainame. All rights reserved.
//

#import "TestNumbers.h"

@implementation TestNumber
@end

@implementation TestNumberOf1
@end

@implementation TestNumberOf2
@end

@implementation TestNumberOf3
@end

@implementation TestNumbers
+ (NSArray *)values
{
    return @[
        [TestNumberOf1 defineEnum:0 name:@"one" description:@"いち"],
        [TestNumberOf2 defineEnum:1 name:@"two" description:@"つー"],
        [TestNumberOf3 defineEnum:3 name:@"three" description:@"すりー"],
    ];
}
@end
