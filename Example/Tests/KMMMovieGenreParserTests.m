//
//  KMMMovieGenreParser.m
//  Dejavu
//
//  Created by Kerr Marin Miller on 16/11/2014.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMMovieGenre.h"

@interface KMMMovieGenreParserTests : XCTestCase

@end

@implementation KMMMovieGenreParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingIsSuccessfulWithValidJSON {
    // This is an example of a functional test case.
    id validJSON = @{@"id":@18, @"name":@"Drama"};
    KMMMovieGenreParser *parser = [KMMMovieGenreParser new];
    KMMMovieGenre *genre = [parser genreFromDictionary:validJSON];
    XCTAssertNotNil(genre);
}



@end
