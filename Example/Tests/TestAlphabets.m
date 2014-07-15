//
//  TestAlphabets.m
//  AMEEnumeratedObject
//
//  Created by Satoshi Namai on 2014/07/14.
//  Copyright (c) 2014年 ainame. All rights reserved.
//

#import "TestAlphabets.h"

@implementation TestAlphabet
@end

@implementation TestAlphabetOfA
@end

@implementation TestAlphabetOfB
@end

@implementation TestAlphabetOfC
@end

@implementation TestAlphabets

+ (NSArray *)values
{
    return @[
        [TestAlphabetOfA defineEnum:0 name:@"A" description:@"えー"],
        [TestAlphabetOfB defineEnum:1 name:@"B" description:@"びー"],
        [TestAlphabetOfC defineEnum:2 name:@"C" description:@"しー"]
    ];
}

@end
