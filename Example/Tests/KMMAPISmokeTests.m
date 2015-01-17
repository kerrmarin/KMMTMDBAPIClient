//
//  KMMAPISmokeTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMTMDBAPIClient.h>
#import <KMMTMDBAPIClient/KMMMovieCriteria.h>
#import <KMMTMDBAPIClient/KMMTVCriteria.h>

@interface KMMAPISmokeTests : XCTestCase

@end

@implementation KMMAPISmokeTests

- (void)setUp {
    [super setUp];
    [[KMMTMDBAPIClient client] setAPIKey:@"dad3be1c54d32a605ed8931859ed6f0f"];
}


#pragma mark -- Certifications tests

-(void)testCanGetMovieCertificationList {
    XCTestExpectation *supportedMovieCertificationExpectation = [self expectationWithDescription:@"Movie certifications expectation"];
    
    [[KMMTMDBAPIClient client] supportedMovieCertificationsWithBlock:^(id results, NSError *error) {
        if(!error) {
            [supportedMovieCertificationExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetTVCertificationList {
    XCTestExpectation *supportedTVCertificationExpectation = [self expectationWithDescription:@"TV certifications expectation"];
    
    [[KMMTMDBAPIClient client] supportedTVCertificationsWithBlock:^(id results, NSError *error) {
        if(!error) {
            [supportedTVCertificationExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Changes tests

-(void)testCanGetChangesForMovie {
    XCTestExpectation *changesForMovieExpectation = [self expectationWithDescription:@"changesForMovieExpectation"];
    
    [[KMMTMDBAPIClient client] latestMovieChangesFrom:[NSDate date] to:[NSDate date] inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [changesForMovieExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetChangesForPeople {
    XCTestExpectation *changesForPeopleExpectation = [self expectationWithDescription:@"changesForPeopleExpectation"];
    
    [[KMMTMDBAPIClient client] latestPersonChangesFrom:[NSDate date] to:[NSDate date] inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [changesForPeopleExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetChangesForTV {
    XCTestExpectation *changesForTVExpectation = [self expectationWithDescription:@"changesForTVExpectation"];
    
    [[KMMTMDBAPIClient client] latestTVChangesFrom:[NSDate date] to:[NSDate date] inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [changesForTVExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Collection tests

-(void)testCanGetCollection {
    XCTestExpectation *collectionExpectation = [self expectationWithDescription:@"collectionExpectation"];
    
    //10 is Star Wars Collection
    [[KMMTMDBAPIClient client] collectionWithId:10 complete:^(id results, NSError *error) {
     if(!error) {
            [collectionExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetCollectionImages {
    XCTestExpectation *imagesForCollectionExpectation = [self expectationWithDescription:@"imagesForCollectionExpectation"];
    
    //10 is Star Wars Collection
    [[KMMTMDBAPIClient client] imagesForCollection:10 complete:^(id results, NSError *error) {
        if(!error) {
            [imagesForCollectionExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Companies tests

-(void)testCanGetCompanyById {
    XCTestExpectation *companyByIdExpectation = [self expectationWithDescription:@"companyByIdExpectation"];
    
    [[KMMTMDBAPIClient client] companyWithID:1 complete:^(id results, NSError *error) {
        if(!error) {
            [companyByIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


-(void)testCanGetCompanyMovies {
    XCTestExpectation *companyMoviesExpectation = [self expectationWithDescription:@"companyMoviesExpectation"];
    
    [[KMMTMDBAPIClient client] moviesForCompany:1 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [companyMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Credits

-(void)testCanGetCreditsById {
    XCTestExpectation *creditsByIdExpectation = [self expectationWithDescription:@"creditsByIdExpectation"];
    
    [[KMMTMDBAPIClient client] creditWithId:@"52542282760ee313280017f9" complete:^(id results, NSError *error) {
        if(!error) {
            [creditsByIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Discover

-(void)testCanDiscoverMovies {
    XCTestExpectation *discoverMoviesExpectation = [self expectationWithDescription:@"discoverMoviesExpectation"];
    
    KMMMovieCriteria *criteria = [KMMMovieCriteria new];
    [[KMMTMDBAPIClient client] discoverMoviesWithCriteria:criteria inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [discoverMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanDiscoverTV {
    XCTestExpectation *discoverTVExpectation = [self expectationWithDescription:@"discoverTVExpectation"];
    
    KMMTVCriteria *criteria = [KMMTVCriteria new];
    [[KMMTMDBAPIClient client] discoverTVWithCriteria:criteria inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [discoverTVExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Find




@end