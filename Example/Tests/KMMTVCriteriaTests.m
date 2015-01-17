//
//  KMMTVCriteriaTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMTVCriteria.h>

@interface KMMTVCriteriaTests : XCTestCase

@end

@implementation KMMTVCriteriaTests

- (void)testNSStringFromKMMMovieDiscoverSortBy {
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityAscending) isEqualToString:@"popularity.asc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending) isEqualToString:@"popularity.desc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByVoteAverageAscending) isEqualToString:@"vote_average.asc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByVoteAverageDescending) isEqualToString:@"vote_average.desc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByFirstAirDateAscending) isEqualToString:@"first_air_date.asc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByFirstAirDateDescending) isEqualToString:@"first_air_date.desc"]);
    XCTAssert([NSStringFromKMMTVDiscoverSortBy(1000) isEqualToString:@"popularity.desc"]);

}

-(void)testDefailtSortByIsPopularityDescending {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    XCTAssertNotNil(criteria);
    XCTAssert(criteria.sortBy == KMMTVSeriesDiscoverSortByPopularityDescending);
}

- (void)testCreatingKMMMovieCriteriaPerformance {
    [self measureBlock:^{
        for(int i = 0; i < 10000; i++) {
            KMMTVCriteria *criteria = [KMMTVCriteria new];
            XCTAssertNotNil(criteria);
        }
    }];
}

@end
