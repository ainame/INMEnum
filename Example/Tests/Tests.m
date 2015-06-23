//
//  AMEEnumeratedObjectTests.m
//  AMEEnumeratedObjectTests
//
//  Created by ainame on 07/04/2014.
//  Copyright (c) 2014 ainame. All rights reserved.
//

#import "INMEnum.h"
#import "TestAlphabets.h"
#import "TestNumbers.h"

SpecBegin(InitialSpecs);
beforeAll(^{
  [INMEnumInitializer initializeAllEnumerateObjects];
});

describe(@"define values", ^{

  it(@"equal", ^{
    expect([TestAlphabetOfA enumObject].ordinal).to.equal(0);
  });

  it(@"equal", ^{
    NSLog(@"%@", [TestAlphabetOfA enumObject]);
    expect([TestAlphabetOfA enumObject].name).to.equal(@"A");
  });

  it(@"equal", ^{
    expect([[TestAlphabetOfA enumObject] description]).to.equal(@"えー");
  });
});

describe(@"equality", ^{
  it(@"equal", ^{
    expect([TestAlphabetOfA enumObject]).to.equal([TestAlphabetOfA enumObject]);
  });

  it(@"true", ^{
    expect([TestAlphabetOfA enumObject] == [TestAlphabetOfA enumObject]).to.beTruthy;
  });

  it(@"is member", ^{
    expect([[TestAlphabetOfA enumObject] isMemberOfClass:TestAlphabetOfA.class]).to.beTruthy;
  });

  it(@"is kind of class", ^{
    expect(TestAlphabetOfA.class).to.beSubclassOf([TestAlphabet class]);
  });

  it(@"not equal", ^{
    expect([TestAlphabetOfA enumObject]).notTo.equal([TestAlphabetOfB enumObject]);
  });

  it(@"false", ^{
    expect([[TestAlphabetOfA enumObject] isEqual:[TestAlphabetOfB enumObject]]).to.beFalsy;
  });
});

describe(@"other enumerate objects", ^{
  it(@"equal", ^{
    expect([TestNumberOf1 enumObject].ordinal).to.equal(0);
  });

  it(@"equal", ^{
    expect([TestNumberOf1 enumObject].name).to.equal(@"one");
  });

  it(@"equal", ^{
    expect([[TestNumberOf1 enumObject] description]).to.equal(@"いち");
  });
});

describe(@"swtich enumerate objects", ^{
  it(@"call matched case block", ^{
    __block BOOL isNumberOf1 = NO;
    __block BOOL isNumberOf2 = NO;
    __block BOOL isDefault = NO;
    [TestAlphabets switch:[TestNumberOf1 enumObject]
                    cases:[TestNumberOf1 then:^{
                            isNumberOf1 = YES;
                          }],
                          [TestNumberOf2 then:^{
                            isNumberOf2 = YES;
                          }],
                          [TestNumberOf3 then:^{
                          }],
                          [INMEnumCaseDefault then:^{
                            isDefault = YES;
                          }]];

    expect(isNumberOf1).to.equal(YES);
    expect(isNumberOf2).to.equal(NO);
    expect(isDefault).to.equal(NO);
  });

  it(@"call matched case block", ^{
    __block BOOL isNumberOf1 = NO;
    __block BOOL isNumberOf2 = NO;
    __block BOOL isDefault = NO;
    [TestAlphabets switch:[TestNumberOf2 enumObject]
                    cases:[TestNumberOf1 then:^{
                            isNumberOf1 = YES;
                          }],
                          [TestNumberOf2 then:^{
                            isNumberOf2 = YES;
                          }],
                          [TestNumberOf3 then:^{
                          }],
                          [INMEnumCaseDefault then:^{
                            isDefault = YES;
                          }]];
    expect(isNumberOf1).to.equal(NO);
    expect(isNumberOf2).to.equal(YES);
    expect(isDefault).to.equal(NO);
  });

  it(@"call default case block", ^{
    __block BOOL isNumberOf1 = NO;
    __block BOOL isNumberOf2 = NO;
    __block BOOL isDefault = NO;
    [TestAlphabets switch:nil
                    cases:[TestNumberOf1 then:^{
                            isNumberOf1 = YES;
                          }],
                          [TestNumberOf2 then:^{
                            isNumberOf2 = YES;
                          }],
                          [TestNumberOf3 then:^{
                          }],
                          [INMEnumCaseDefault then:^{
                            isDefault = YES;
                          }]];
    expect(isNumberOf1).to.equal(NO);
    expect(isNumberOf2).to.equal(NO);
    expect(isDefault).to.equal(YES);
  });

  it(@"call default case block where is not last, but after cases don't be called.", ^{
    __block BOOL isNumberOf1 = NO;
    __block BOOL isNumberOf2 = NO;
    __block BOOL isDefault = NO;
    [TestAlphabets switch:[TestNumberOf2 enumObject]
                    cases:[TestNumberOf1 then:^{
                            isNumberOf1 = YES;
                          }],
                          [INMEnumCaseDefault then:^{
                            isDefault = YES;
                          }],
                          [TestNumberOf2 then:^{
                            isNumberOf2 = YES;
                          }],
                          [TestNumberOf3 then:^{
                          }]];
    expect(isNumberOf1).to.equal(NO);
    expect(isNumberOf2).to.equal(NO);
    expect(isDefault).to.equal(YES);
  });

  it(@"call default case block where is not last", ^{
    __block BOOL isNumberOf1 = NO;
    __block BOOL isNumberOf2 = NO;
    __block BOOL isDefault = NO;
    [TestAlphabets switch:[TestNumberOf2 enumObject]
                    cases:[INMEnumCaseDefault then:^{
                      isDefault = YES;
                    }]];
    expect(isNumberOf1).to.equal(NO);
    expect(isNumberOf2).to.equal(NO);
    expect(isDefault).to.equal(YES);
  });
});

SpecEnd
