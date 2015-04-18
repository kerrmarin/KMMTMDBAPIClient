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
        KMMTVCriteria *criteria = [KMMTVCriteria new];
        XCTAssertNotNil(criteria);
    }];
}

-(void)testSortBy {
    KMMTVSeriesDiscoverSortBy sortBy = KMMTVSeriesDiscoverSortByPopularityAscending;
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.sortBy = sortBy;
    
    XCTAssertEqual(sortBy, criteria.sortBy);
}

-(void)testFirstAirYear {
    NSUInteger year = 1990;
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.firstAirYear = year;
    
    XCTAssertEqual(year, criteria.firstAirYear);
}

-(void)testVoteCountGTE {
    NSUInteger votes = 100;
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.voteCountGTE = votes;
    
    XCTAssertEqual(votes, criteria.voteCountGTE);
}

-(void)testVoteCountLTE {
    NSUInteger votes = 100;
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.voteCountLTE = votes;
    
    XCTAssertEqual(votes, criteria.voteCountLTE);
}

-(void)testGenres {
    NSSet *genres = [NSSet setWithArray:@[@"Genre", @"Genre2"]];
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.genres = genres;
    
    XCTAssertEqual(genres, criteria.genres);
}

-(void)testNetworks {
    NSSet *networks = [NSSet setWithArray:@[@"NET1", @"NET2"]];
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.networks = networks;
    
    XCTAssertEqual(networks, criteria.networks);
}

-(void)testFirstAirDateGTE {
    NSDate *date = [NSDate date];
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.firstAirDateGTE = date;
    
    XCTAssertEqual(date, criteria.firstAirDateGTE);
}

-(void)testFirstAirDateLTE {
    NSDate *date = [NSDate date];
    KMMTVCriteria *criteria = [[KMMTVCriteria alloc] init];
    criteria.firstAirDateLTE = date;
    
    XCTAssertEqual(date, criteria.firstAirDateLTE);
}



@end
