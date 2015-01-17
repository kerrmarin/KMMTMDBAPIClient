//
//  KMMTVParametersBuilderTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMTVCriteria.h>
#import <KMMTMDBAPIClient/NSDictionary+TVParameters.h>

@interface KMMTVParametersBuilderTests : XCTestCase

@property(nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation KMMTVParametersBuilderTests

-(void)setUp {
    [super setUp];
    self.formatter = [NSDateFormatter new];
    self.formatter.dateFormat = @"yyyy-MM-dd";
}

- (void)testCanBuildWithCriteria {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.sortBy = KMMTVSeriesDiscoverSortByVoteAverageAscending;
    criteria.firstAirYear = 1999;
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:1 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"first_air_date_year"] integerValue] == 1999);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByVoteAverageAscending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithFirstYearAir {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.firstAirYear = 1999;
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:1 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"first_air_date_year"] integerValue] == 1999);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithVoteCountGTE {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.voteCountGTE = 20;
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"vote_count.gte"] integerValue] == 20);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithVoteCountLTE {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.voteCountLTE = 20;
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"vote_count.lte"] integerValue] == 20);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithGenres {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    NSSet *cities = [NSSet setWithArray:@[@"London", @"Madrid", @"Paris", @"Istanbul"]];
    criteria.genres = [NSSet setWithSet:cities];
    
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *genres = [params[@"with_genres"] componentsSeparatedByString:@","];
    XCTAssertTrue(genres.count == 4);
    XCTAssertTrue([genres containsObject:@"London"]);
    XCTAssertTrue([genres containsObject:@"Madrid"]);
    XCTAssertTrue([genres containsObject:@"Paris"]);
    XCTAssertTrue([genres containsObject:@"Istanbul"]);

    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithNetworks {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    NSSet *networkSet = [NSSet setWithArray:@[@"London", @"Madrid", @"Paris", @"Istanbul"]];
    criteria.networks = [NSSet setWithSet:networkSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *networks = [params[@"with_networks"] componentsSeparatedByString:@","];
    XCTAssertTrue(networks.count == 4);
    XCTAssertTrue([networks containsObject:@"London"]);
    XCTAssertTrue([networks containsObject:@"Madrid"]);
    XCTAssertTrue([networks containsObject:@"Paris"]);
    XCTAssertTrue([networks containsObject:@"Istanbul"]);
    
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithFirstAirDateGTE {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.firstAirDateGTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:2 dateFormatter:self.formatter];
    NSString *GTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"first_air_date.gte"] isEqualToString:GTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"first_air_date.gte"]]);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithFirstAirDateLTE {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.firstAirDateLTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:2 dateFormatter:self.formatter];
    NSString *LTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"first_air_date.lte"] isEqualToString:LTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"first_air_date.lte"]]);
    NSString *sort = NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

- (void)testParameterBuilderPerformance {
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    criteria.sortBy = KMMTVSeriesDiscoverSortByVoteAverageAscending;
    criteria.firstAirYear = 1999;
    criteria.firstAirDateLTE = [NSDate date];
    criteria.voteCountGTE = 20;
    criteria.voteCountLTE = 1000;
    criteria.genres = [NSSet setWithArray:@[@"asd"]];
    criteria.networks = [NSSet setWithArray:@[@"pqw"]];
    criteria.firstAirDateGTE = [NSDate date];
    criteria.firstAirDateLTE = [NSDate date];
    
    [self measureBlock:^{
        for(int i = 0; i < 5000; i++) {
            NSDictionary *dict = [NSDictionary dictionaryWithTVCriteria:criteria inPage:1 dateFormatter:self.formatter];
            XCTAssertNotNil(dict);
        }
    }];
}


@end
