# INMEnum

[![CI Status](http://img.shields.io/travis/ainame/INMEnum.svg?style=flat)](https://travis-ci.org/ainame/INMEnum)
[![Version](https://img.shields.io/cocoapods/v/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)
[![License](https://img.shields.io/cocoapods/l/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)
[![Platform](https://img.shields.io/cocoapods/p/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objc
@interface Alphabets : INMEnumCollection; @end
@interface Alphabet : INMEnum
+ (Alphabet *)enumObject;
@end;
@implementation Alphabet;  @end
@interface A : Alphabet; @end; @implementation A; @end
@interface B : Alphabet; @end; @implementation B; @end
@interface C : Alphabet; @end; @implementation C; @end

@implementation Alphabets
+ (NSArray *) values
{
    return @[
        [A defineEnum:0 name:@"a" description:@"えー"],
        [B defineEnum:1 name:@"b" description:@"びー"],
        [C defineEnum:2 name:@"c" description:@"しー"],
    ];
}
@end

// ....

[INMEnumInitializer initializeAllEnumerateObjects];
Alphabet *alphabet = [A enumObject];
alphabet.ordinal; //=> 0
alphabet.name; //=> @"a"
alphabet.description; //=> @"えー"

alphabet = [Alphabets valueForName:@"b"] // => B object;
[Alphabets values]                       // => A, B and c instances as NSArray;

// INMEnum's swtich case syntax
[INMEnum switch:alphabet
          cases:[A then:^{ NSLog(@"A"); }],
                [B then:^{ NSLog(@"B"); }],
                [C then:^{ NSLog(@"C"); }],
                [INMEnumCaseDefault then:^{ NSLog(@"B"); }]]; // must to set at last
```

### Constraints

* You MUST initialize before touch one enum object by `[INMEnumInitializer initializeAllEnumerateObjects]`.
* You MUST given INMEnumCaseDefault section in swtich:cases: selector's arguments.

## Requirements

## Installation

INMEnum is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "INMEnum"

## Author

[ainame](https://twitter.com/ainame)

## License

INMEnum is available under the MIT license. See the LICENSE file for more info.
