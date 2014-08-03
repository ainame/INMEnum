# INMEnum

[![CI Status](http://img.shields.io/travis/ainame/INMEnum.svg?style=flat)](https://travis-ci.org/ainame/INMEnum)
[![Version](https://img.shields.io/cocoapods/v/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)
[![License](https://img.shields.io/cocoapods/l/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)
[![Platform](https://img.shields.io/cocoapods/p/INMEnum.svg?style=flat)](http://cocoadocs.org/docsets/INMEnum)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objc
@interface SushiGoRound : INMEnumCollection; @end
@interface Sushi : INMEnum; @end;
@implementation Sushi;  @end
@interface Tuna : Sushi; @end; @implementation Tuna; @end
@interface Egg : Sushi; @end; @implementation Egg; @end
@interface Shrimp : Sushi; @end; @implementation Shrimp; @end

@implementation SushiGoRound
+ (NSArray *) values
{
    return @[
        [Tuna defineEnum:0 name:@"tuna" description:@":sushi:"],
        [Egg defineEnum:1 name:@"egg" description:@":egg:"],
        [Shrimp defineEnum:2 name:@"shrimp" description:@":fried_shrimp:"],
    ];
}
@end

// ....

[INMEnumInitializer initializeAllEnumerateObjects]; // must call at first
Sushi *sushi = [tuna enumObject];
sushi.ordinal; //=> 0
sushi.name; //=> @"tuna"
sushi.description; //=> @":sushi:"

sushi = [sushi valueForName:@"egg"] // => Egg object;
[SushiGoRound values]               // => Tuna, Egg and Shrimp instances as NSArray;

// INMEnum's swtich case syntax
[SushiGoRound switch:sushi
               cases:[Tuna then:^{ NSLog(@"awesome!"); }],
                     [Egg then:^{ NSLog(@"yummy!!"); }],
                     [Shrimp then:^{ NSLog(@"delicious!!!"); }],
                     [INMEnumCaseDefault then:^{ NSLog(@"WTF!"); }]]; // must set at last
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
