//
//  KMMMovieFilterTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 11/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMMovieFilter.h"

@interface KMMMovieFilterTests : XCTestCase

@property(nonatomic, strong) KMMMovieFilter *filter;

@end

@implementation KMMMovieFilterTests

- (void)setUp {
    [super setUp];
    self.filter = [KMMMovieFilter new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialRangeLocationIsNotFound {
    XCTAssert(self.filter.yearRange.location == NSNotFound);
}

- (void)testInitialRangeLengthIsNotFound {
    XCTAssert(self.filter.yearRange.length == NSNotFound);
}

- (void)testInitialGenresIsEmptyArray {
    XCTAssert(self.filter.genres.count == 0);
}

- (void)testInitialSortByIsKMMFilterSortByPopular {
    XCTAssert(self.filter.sortBy == KMMFilterSortByPopular);
}

- (void)testStringForSortByReleaseDate {
    XCTAssert([NSStringFromKMMFilterSortBy(KMMFilterSortByReleaseDate) isEqualToString:@"release_date.desc"]);
}

- (void)testStringForSortByPopularity {
    XCTAssert([NSStringFromKMMFilterSortBy(KMMFilterSortByPopular) isEqualToString:@"popularity.desc"]);
}

- (void)testStringForSortByVoteAverage {
    XCTAssert([NSStringFromKMMFilterSortBy(KMMFilterSortByTopRated) isEqualToString:@"vote_average.desc"]);
}


@end
