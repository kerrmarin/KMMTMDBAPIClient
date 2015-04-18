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
#import <KMMTMDBAPIClient/KMMCountry.h>
#import <KMMTMDBAPIClient/KMMCertification.h>

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

-(void)testDefaultSortByIsPopularityDescending {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    XCTAssertNotNil(criteria);
    XCTAssert(criteria.sortBy == KMMMovieDiscoverSortByPopularityDescending);
}

- (void)testCreatingKMMMovieCriteriaPerformance {
    [self measureBlock:^{
        KMMMovieCriteria *criteria = [KMMMovieCriteria new];
        XCTAssertNotNil(criteria);
    }];
}

-(void)testCriteriaCountry {
    KMMCountry *country = [[KMMCountry alloc] initWithCountryCode:@"GB"];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.certificationCountry = country;
    
    XCTAssertEqual(country, criteria.certificationCountry);
}

-(void)testMaximumCertification {
    KMMCertification *certification = [[KMMCertification alloc] initWithCode:@"GB" meanging:@"Test" order:3];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.maximumCertification = certification;
    
    XCTAssertEqual(certification, criteria.maximumCertification);
}

-(void)testRequiredCertification {
    KMMCertification *certification = [[KMMCertification alloc] initWithCode:@"GB" meanging:@"Test" order:3];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.requiredCertification = certification;
    
    XCTAssertEqual(certification, criteria.requiredCertification);
}

-(void)testReleaseYear {
    NSUInteger year = 1990;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.releaseYear = year;
    
    XCTAssertEqual(year, criteria.releaseYear);
}

-(void)testReleaseDateGTE {
    NSDate *date = [NSDate date];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.releaseDateGTE = date;
    
    XCTAssertEqual(date, criteria.releaseDateGTE);
}

-(void)testReleseDateLTE {
    NSDate *date = [NSDate date];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.releaseDateLTE = date;
    
    XCTAssertEqual(date, criteria.releaseDateLTE);
}

-(void)testPrimaryReleaseYear {
    NSUInteger year = 1990;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.primaryReleaseYear = year;
}

-(void)testPrimaryReleaseDateGTE {
    NSDate *date = [NSDate date];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.primaryReleaseDateGTE = date;
    
    XCTAssertEqual(date, criteria.primaryReleaseDateGTE);
}

-(void)testPrimaryReleaseDateLTE {
    NSDate *date = [NSDate date];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.primaryReleaseDateLTE = date;
    
    XCTAssertEqual(date, criteria.primaryReleaseDateLTE);
}

-(void)testVoteCountGTE {
    NSUInteger votes = 100;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.voteCountGTE = votes;
    
    XCTAssertEqual(votes, criteria.voteCountGTE);
}

-(void)testVoteCountLTE {
    NSUInteger votes = 100;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.voteCountLTE = votes;
    
    XCTAssertEqual(votes, criteria.voteCountLTE);
}

-(void)testVoteAverageGTE {
    CGFloat average = 4.3;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.voteAverageGTE = average;
    
    XCTAssertEqual(average, criteria.voteAverageGTE);
}

-(void)testVoteAverageLTE {
    CGFloat average = 4.3;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.voteAverageLTE = average;
    
    XCTAssertEqual(average, criteria.voteAverageLTE);
}

-(void)testCast {
    NSSet *cast = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.cast = cast;
    
    XCTAssertEqual(cast, criteria.cast);
}

-(void)testCrew {
    NSSet *crew = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.crew = crew;
    
    XCTAssertEqual(crew, criteria.crew);
}

-(void)testCompanies {
    NSSet *companies = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.companies = companies;
    
    XCTAssertEqual(companies, criteria.companies);
}

-(void)testGenres {
    NSSet *genres = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.genres = genres;
    
    XCTAssertEqual(genres, criteria.genres);
}

-(void)testKeywords {
    NSSet *keywords = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.keywords = keywords;
    
    XCTAssertEqual(keywords, criteria.keywords);
}

-(void)testPeople {
    NSSet *people = [NSSet setWithArray:@[@"John", @"Bob"]];
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.people = people;
    
    XCTAssertEqual(people, criteria.people);
}

-(void)testSortBy {
    KMMMovieDiscoverSortBy sortBy = KMMMovieDiscoverSortByRevenueAscending;
    KMMMovieCriteria *criteria = [[KMMMovieCriteria alloc] init];
    criteria.sortBy = sortBy;
    
    XCTAssertEqual(sortBy, criteria.sortBy);
}

@end
