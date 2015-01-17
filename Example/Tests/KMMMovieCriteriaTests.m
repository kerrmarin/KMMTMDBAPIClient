//
//  KMMMovieCriteriaTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMMovieCriteria.h>

@interface KMMMovieCriteriaTests : XCTestCase

@end

@implementation KMMMovieCriteriaTests

- (void)testNSStringFromKMMMovieDiscoverSortBy {
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending) isEqualToString:@"popularity.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityAscending) isEqualToString:@"popularity.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByRevenueAscending) isEqualToString:@"revenue.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByRevenueDescending) isEqualToString:@"revenue.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByVoteCountAscending) isEqualToString:@"vote_count.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByVoteCountDescending) isEqualToString:@"vote_count.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByVoteAverageAscending) isEqualToString:@"vote_average.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByVoteAverageDescending) isEqualToString:@"vote_average.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByReleaseDateAscending) isEqualToString:@"release_date.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByReleaseDateDescending) isEqualToString:@"release_date.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPrimaryReleaseDateAscending) isEqualToString:@"primary_release_date.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPrimaryReleaseDateDescending) isEqualToString:@"primary_release_date.desc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByOriginalTitleAscending) isEqualToString:@"original_title.asc"]);
    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByOriginalTitleDescending) isEqualToString:@"original_title.desc"]);

    XCTAssert([NSStringFromKMMMovieDiscoverSortBy(1000) isEqualToString:@"popularity.desc"]);
}

-(void)testDefailtSortByIsPopularityDescending {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    XCTAssertNotNil(criteria);
    XCTAssert(criteria.sortBy == KMMMovieDiscoverSortByPopularityDescending);
}

- (void)testCreatingKMMMovieCriteriaPerformance {
    [self measureBlock:^{
        for(int i = 0; i < 10000; i++) {
            KMMMovieCriteria *criteria = [KMMMovieCriteria new];
            XCTAssertNotNil(criteria);
        }
    }];
}

@end
