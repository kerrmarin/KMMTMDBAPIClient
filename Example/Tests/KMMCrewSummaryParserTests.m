//
//  KMMCrewSummaryParserTests.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMCrewSummary.h"

@interface KMMCrewSummaryParserTests : XCTestCase

@end

@implementation KMMCrewSummaryParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingIsSuccessfulWithValidJSON {

    id validJSON = @{@"credit_id":@"52fe4250c3a36847f8014a11",
        @"department":@"Production",
        @"id":@1254,
        @"job":@"Producer",
        @"name":@"Art Linson",
        @"profile_path":@"/dEtVivCXxQBtIzmJcUNupT1AB4H.jpg"};
    KMMCrewSummaryParser *parser = [KMMCrewSummaryParser new];
    KMMCrewSummary *crew = [parser crewSummaryFromDictionary:validJSON];
    XCTAssertNotNil(crew);
}


@end
