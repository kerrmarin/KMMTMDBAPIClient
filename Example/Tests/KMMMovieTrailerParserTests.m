//
//  KMMMovieTrailerParserTests.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMMovieTrailer.h"

@interface KMMMovieTrailerParserTests : XCTestCase

@end

@implementation KMMMovieTrailerParserTests

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
    id validJSON = @{@"id":@"533ec654c3a36854480003eb",
                     @"iso_639_1":@"en",
                     @"key":@"SUXWAEX2jlg",
                     @"name":@"Trailer 1",
                     @"site":@"YouTube",
                     @"size":@720,
                     @"type":@"Trailer"};
    KMMMovieTrailerParser *parser = [KMMMovieTrailerParser new];
    KMMMovieTrailer *trailer = [parser movieTrailerFromDictionary:validJSON];
    XCTAssertNotNil(trailer);
}


@end
