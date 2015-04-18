//
//  KMMMovieReleaseParserTests.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMMovieRelease.h"

@interface KMMMovieReleaseParserTests : XCTestCase

@end

@implementation KMMMovieReleaseParserTests

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
    id validJSON = @{@"iso_3166_1":@"US",
                     @"certification":@"R",
                     @"release_date":@"1999-10-14"};
    KMMMovieReleaseParser *parser = [KMMMovieReleaseParser new];
    KMMMovieRelease *release = [parser movieReleaseFromDictionary:validJSON];
    XCTAssertNotNil(release);
}


@end
