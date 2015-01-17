//
//  KMMMovieParametersBuilderTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMMovieCriteria.h>
#import <KMMTMDBAPIClient/KMMCertification.h>
#import <KMMTMDBAPIClient/KMMCountry.h>
#import <KMMTMDBAPIClient/NSDictionary+MovieParameters.h>

@interface KMMMovieParametersBuilderTests : XCTestCase

@property(nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation KMMMovieParametersBuilderTests

-(void)setUp {
    [super setUp];
    self.formatter = [NSDateFormatter new];
    self.formatter.dateFormat = @"yyyy-MM-dd";
}


- (void)testNoCertificationLTEOrCertificationCodeMeansNoCountry {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.certificationCountry = [[KMMCountry alloc] initWithCountryCode:@"GB"];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertNil(params[@"certification_country"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 2);
}

- (void)testCertificationWithMaximumCertification{
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.certificationCountry = [[KMMCountry alloc] initWithCountryCode:@"GB"];
    criteria.maximumCertification = [[KMMCertification alloc] initWithCode:@"GB" meanging:@"asd" order:3];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"certification_country"] isEqualToString:@"GB"]);
    XCTAssertTrue([params[@"certification.lte"] isEqualToString:@"GB"]);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 4);
}

- (void)testCertificationWithRequiredCertification{
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.certificationCountry = [[KMMCountry alloc] initWithCountryCode:@"GB"];
    criteria.requiredCertification = [[KMMCertification alloc] initWithCode:@"PG" meanging:@"asd" order:3];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"certification_country"] isEqualToString:@"GB"]);
    XCTAssertTrue([params[@"certification"] isEqualToString:@"PG"]);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 4);
}

- (void)testCertificationWithRequiredCertificationRemovesMaximumCertification {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.certificationCountry = [[KMMCountry alloc] initWithCountryCode:@"GB"];
    criteria.maximumCertification = [[KMMCertification alloc] initWithCode:@"AU" meanging:@"MAX" order:3];
    criteria.requiredCertification = [[KMMCertification alloc] initWithCode:@"PG" meanging:@"asd" order:3];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"certification_country"] isEqualToString:@"GB"]);
    XCTAssertTrue([params[@"certification"] isEqualToString:@"PG"]);
    XCTAssertNil(params[@"certification.lte"]);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 4);
}


- (void)testCanBuildWithCriteria {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.sortBy = KMMMovieDiscoverSortByPopularityDescending;
    criteria.releaseYear = 1999;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"year"] integerValue] == 1999);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


- (void)testCanBuildWithReleaseYear {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.releaseYear = 1999;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"year"] integerValue] == 1999);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


- (void)testCanBuildWithReleaseYearGTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.sortBy = KMMMovieDiscoverSortByPopularityDescending;
    criteria.releaseDateGTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSString *GTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"release_date.gte"] isEqualToString:GTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"release_date.gte"]]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


- (void)testCanBuildWithReleaseYearLTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.sortBy = KMMMovieDiscoverSortByPopularityDescending;
    criteria.releaseDateLTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSString *GTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"release_date.lte"] isEqualToString:GTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"release_date.lte"]]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


- (void)testCanBuildWithPrimaryReleaseYear {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.primaryReleaseYear = 1999;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"primary_release_year"] integerValue] == 1999);
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


- (void)testCanBuildWithPrimaryReleaseYearGTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.sortBy = KMMMovieDiscoverSortByPopularityDescending;
    criteria.primaryReleaseDateGTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSString *GTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"primary_release_date.gte"] isEqualToString:GTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"primary_release_date.gte"]]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

- (void)testCanBuildWithPrimaryReleaseYearLTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.sortBy = KMMMovieDiscoverSortByPopularityDescending;
    criteria.primaryReleaseDateLTE = [NSDate date];
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSString *GTEString = [self.formatter stringFromDate:[NSDate date]];
    XCTAssertTrue([params[@"primary_release_date.lte"] isEqualToString:GTEString]);
    XCTAssertNotNil([self.formatter dateFromString:params[@"primary_release_date.lte"]]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


-(void)testCanBuildWithVoteCountGTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.voteCountGTE = 20;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"vote_count.gte"] integerValue] == 20);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

- (void)testCanBuildWithVoteCountLTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.voteCountLTE = 20;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"vote_count.lte"] integerValue] == 20);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}

- (void)testCanBuildWithVoteAverageGTE {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    criteria.voteAverageGTE = 20;
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:2 dateFormatter:self.formatter];
    XCTAssertTrue([params[@"vote_average.gte"] integerValue] == 20);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 2);
    XCTAssertTrue([params allKeys].count == 3);
}


-(void)testCanBuildWithGenres {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *genreSet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.genres = [NSSet setWithSet:genreSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *genres = [params[@"with_genres"] componentsSeparatedByString:@","];
    XCTAssertTrue(genres.count == 4);
    XCTAssertTrue([genres containsObject:@"Asd"]);
    XCTAssertTrue([genres containsObject:@"qwe"]);
    XCTAssertTrue([genres containsObject:@"zxc"]);
    XCTAssertTrue([genres containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithCast {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *castSet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.cast = [NSSet setWithSet:castSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *cast = [params[@"with_cast"] componentsSeparatedByString:@","];
    XCTAssertTrue(cast.count == 4);
    XCTAssertTrue([cast containsObject:@"Asd"]);
    XCTAssertTrue([cast containsObject:@"qwe"]);
    XCTAssertTrue([cast containsObject:@"zxc"]);
    XCTAssertTrue([cast containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithCrew {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *crewSet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.crew = [NSSet setWithSet:crewSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *crew = [params[@"with_crew"] componentsSeparatedByString:@","];
    XCTAssertTrue(crew.count == 4);
    XCTAssertTrue([crew containsObject:@"Asd"]);
    XCTAssertTrue([crew containsObject:@"qwe"]);
    XCTAssertTrue([crew containsObject:@"zxc"]);
    XCTAssertTrue([crew containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


-(void)testCanBuildWithCompanies{
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *companySet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.companies = [NSSet setWithSet:companySet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *companies = [params[@"with_companies"] componentsSeparatedByString:@","];
    XCTAssertTrue(companies.count == 4);
    XCTAssertTrue([companies containsObject:@"Asd"]);
    XCTAssertTrue([companies containsObject:@"qwe"]);
    XCTAssertTrue([companies containsObject:@"zxc"]);
    XCTAssertTrue([companies containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}

-(void)testCanBuildWithKeywords {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *keywordSet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.keywords = [NSSet setWithSet:keywordSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *keywords = [params[@"with_keywords"] componentsSeparatedByString:@","];
    XCTAssertTrue(keywords.count == 4);
    XCTAssertTrue([keywords containsObject:@"Asd"]);
    XCTAssertTrue([keywords containsObject:@"qwe"]);
    XCTAssertTrue([keywords containsObject:@"zxc"]);
    XCTAssertTrue([keywords containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}


-(void)testCanBuildWithPeople {
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    NSSet *peopleSet = [NSSet setWithArray:@[@"Asd", @"qwe", @"zxc", @"ert"]];
    criteria.people = [NSSet setWithSet:peopleSet];
    
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:1 dateFormatter:self.formatter];
    
    NSArray *people = [params[@"with_people"] componentsSeparatedByString:@","];
    XCTAssertTrue(people.count == 4);
    XCTAssertTrue([people containsObject:@"Asd"]);
    XCTAssertTrue([people containsObject:@"qwe"]);
    XCTAssertTrue([people containsObject:@"zxc"]);
    XCTAssertTrue([people containsObject:@"ert"]);
    
    NSString *sort = NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortByPopularityDescending);
    XCTAssertTrue([params[@"sort_by"] isEqualToString:sort]);
    XCTAssertTrue([params[@"page"] integerValue] == 1);
    XCTAssertTrue([params allKeys].count == 3);
}



@end
