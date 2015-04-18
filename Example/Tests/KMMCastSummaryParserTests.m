//
//  KMMCastSummaryParserTests.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMCastSummary.h"

@interface KMMCastSummaryParserTests : XCTestCase

@end

@implementation KMMCastSummaryParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingIsSuccessfulWithValidJSON {

    id validJSON = @{@"cast_id":@5,
                     @"character":@"Tyler Durden",
                     @"credit_id":@"52fe4250c3a36847f80149f7",
                     @"id":@287,
                     @"name":@"Brad Pitt",
                     @"order":@1,
                     @"profile_path":@"/2xrLcP4YRakx8aAc2jdwRbctr0Y.jpg"};
    KMMCastSummaryParser *parser = [KMMCastSummaryParser new];
    KMMCastSummary *cast = [parser castSummaryFromDictionary:validJSON];
    XCTAssertNotNil(cast);
}



@end
