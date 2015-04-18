//
//  KMMMovieSummaryParserTests.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMMovieSummary.h"

@interface KMMMovieSummaryParserTests : XCTestCase

@end

@implementation KMMMovieSummaryParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingIsSuccessfulWithValidJSON  {
    // This is an example of a functional test case.
    id validJSON = @{@"adult":@false,
                     @"backdrop_path":@"/5X0l0G0S95iTzJMptyIMZO80XNS.jpg",
                     @"id":@54833,
                     @"original_title":@"The Big Man",
                     @"release_date":@"1991-08-09",
                     @"poster_path":@"/v2RAbH8HJuLdMYnwC9RAFx08aeU.jpg",
                     @"popularity":@"0.209660090867616",
                     @"title":@"The Big Man",
                     @"vote_average":@10.0,
                     @"vote_count":@10};
    KMMMovieSummaryParser *parser = [KMMMovieSummaryParser new];
    KMMMovieSummary *movieSummary = [parser movieSummaryFromDictionary:validJSON];
    XCTAssertNotNil(movieSummary);
}



@end
