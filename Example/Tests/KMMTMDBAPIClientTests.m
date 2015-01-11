//
//  KMMTMDBAPIClientTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 11/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMTMDBAPIClient.h"

#import "KMMMovieFilter.h"

@interface KMMTMDBAPIClientTests : XCTestCase

@end

@implementation KMMTMDBAPIClientTests

- (void)setUp {
    [super setUp];
    [[KMMTMDBAPIClient client] setAPIKey:@"dad3be1c54d32a605ed8931859ed6f0f"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDefaultIncludeAdultIsFalse {
    XCTAssert([[KMMTMDBAPIClient client].includeAdult isEqualToString:@"false"]);
}

-(void)testDefaultLanguageIsEnglish {
    XCTAssert([[KMMTMDBAPIClient client].language isEqualToString:@"en"]);
}


#pragma mark -- Fetch methods tests

-(void)testCanGetPopularMovies {
    XCTestExpectation *fetchedPopularMoviesExpectation = [self expectationWithDescription:@"Popular movies fetched"];
    
    [[KMMTMDBAPIClient client] fetchPopularMoviesInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [fetchedPopularMoviesExpectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testFetchPopularMoviesWithCorrectPage {
    XCTestExpectation *fetchedPopularMoviesExpectation = [self expectationWithDescription:@"Popular movies fetched with correct page"];
    
    NSInteger pageNumber = 1;
    
    [[KMMTMDBAPIClient client] fetchPopularMoviesInPage:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            if([results[@"page"] integerValue] == pageNumber) {
                [fetchedPopularMoviesExpectation fulfill];
            }
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchMovieWithID {
    XCTestExpectation *fetchedMovieIdExpectation = [self expectationWithDescription:@"Movie with ID fetched"];
    
    NSInteger movieID = 550;
    
    [[KMMTMDBAPIClient client] fetchMovieWithID:movieID complete:^(id results, NSError *error) {
        if(!error) {
            [fetchedMovieIdExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchCompanyWithID {
    XCTestExpectation *fetchedCompanyWithIDExpectation = [self expectationWithDescription:@"Company with ID fetched"];
    
    NSInteger companyID = 25; //20th century fox
    
    [[KMMTMDBAPIClient client] fetchCompanyWithID:companyID complete:^(id results, NSError *error) {
        if(!error) {
            [fetchedCompanyWithIDExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchAllGenres {
    XCTestExpectation *fetchedAllGenresExpectation = [self expectationWithDescription:@"All genres fetched"];
    
    [[KMMTMDBAPIClient client] allGenres:^(id results, NSError *error) {
        if(!error) {
            [fetchedAllGenresExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchMoviesWithGenreInPage {
    XCTestExpectation *fetchedPopularMoviesExpectation = [self expectationWithDescription:@"Movies in genre fetched"];
    
    NSInteger pageNumber = 1;
    NSInteger genreId = 18; //Drama
    
    [[KMMTMDBAPIClient client] moviesWithGenre:genreId inPage:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            if([results[@"page"] integerValue] == pageNumber) {
                [fetchedPopularMoviesExpectation fulfill];
            }
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchPersonWithID {
    XCTestExpectation *fetchedPersonWithId = [self expectationWithDescription:@"Person with ID fetched"];
    
    NSInteger personId = 287; //Brad Pitt
    
    [[KMMTMDBAPIClient client] fetchPersonWithID:personId complete:^(id results, NSError *error) {
        if(!error) {
            [fetchedPersonWithId fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanFetchMovieCreditsForPerson {
    XCTestExpectation *fetchedCreditsWithId = [self expectationWithDescription:@"Credits for person with ID fetched"];
    
    NSInteger personId = 287; //Brad Pitt
    
    [[KMMTMDBAPIClient client] movieCreditsForPerson:personId complete:^(id results, NSError *error) {
        if(!error) {
            [fetchedCreditsWithId fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


-(void)testCanFilterMoviesWithPage {
    XCTestExpectation *fetchFilteredMoviesExpectation = [self expectationWithDescription:@"Filter movies"];
    
    KMMMovieFilter *filter = [KMMMovieFilter new];
    filter.yearRange = NSMakeRange(1999, 10); //1999-2009
    filter.genres = @[@18]; //Drama
    filter.sortBy = KMMFilterSortByPopular;
    
    NSInteger pageNumber = 2;
    
    [[KMMTMDBAPIClient client] filterMovies:filter inPage:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            [fetchFilteredMoviesExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanSearchCastForTerm {
    XCTestExpectation *searchCastExpectation = [self expectationWithDescription:@"Search cast success"];
    
    NSInteger pageNumber = 1;
    NSString *searchTerm = @"John";
    
    [[KMMTMDBAPIClient client] searchCastForTerm:searchTerm page:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            [searchCastExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanSearchMoviesForTerm {
    XCTestExpectation *searchMoviesExpectation = [self expectationWithDescription:@"Search movies success"];
    
    NSInteger pageNumber = 1;
    NSString *searchTerm = @"Hobbit";
    
    [[KMMTMDBAPIClient client] searchMoviesForTerm:searchTerm page:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            [searchMoviesExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanSearchAllForTerm {
    XCTestExpectation *searchMoviesExpectation = [self expectationWithDescription:@"Search movies success"];
    
    NSInteger pageNumber = 1;
    NSString *searchTerm = @"Hobbit";
    
    [[KMMTMDBAPIClient client] searchForTerm:searchTerm page:pageNumber complete:^(id results, NSError *error) {
        if(!error) {
            [searchMoviesExpectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

@end