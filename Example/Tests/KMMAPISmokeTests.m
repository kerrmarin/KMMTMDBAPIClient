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

#pragma mark -- Find tests

-(void)testCanFindByExternalId {
    XCTestExpectation *findByExternalIdExpectation = [self expectationWithDescription:@"findByExternalIdExpectation"];
    
    [[KMMTMDBAPIClient client] findResource:@"tt2179136" inExternalSource:TMDBExternalSourceIMDB complete:^(id results, NSError *error) {
        if(!error) {
            [findByExternalIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Genres tests

-(void)testCanGetListOfMovieGenres {
    XCTestExpectation *allMovieGenresExpectation = [self expectationWithDescription:@"allMovieGenresExpectation"];
    
    [[KMMTMDBAPIClient client] allMovieGenresWithBlock:^(id results, NSError *error) {
        if(!error) {
            [allMovieGenresExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetListOfTVGenres {
    XCTestExpectation *allTVGenresExpectation = [self expectationWithDescription:@"allTVGenresExpectation"];
    
    [[KMMTMDBAPIClient client] allTVGenresWithBlock:^(id results, NSError *error) {
        if(!error) {
            [allTVGenresExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetListOfMoviesInGenre {
    XCTestExpectation *moviesInGenreExpectation = [self expectationWithDescription:@"moviesInGenreExpectation"];
    
    [[KMMTMDBAPIClient client] moviesWithGenre:18 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [moviesInGenreExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Jobs tests

-(void)testCanGetListOfJobs {
    XCTestExpectation *listOfJobsExpectation = [self expectationWithDescription:@"listOfJobsExpectation"];
    
    [[KMMTMDBAPIClient client] allJobsWithBlock:^(id results, NSError *error) {
        if(!error) {
            [listOfJobsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Keywords tests

-(void)testCanGetKeywordWithId {
    XCTestExpectation *keywordWithIdExpectation = [self expectationWithDescription:@"keywordWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] keywordWithId:1721 complete:^(id results, NSError *error) {
        if(!error) {
            [keywordWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMoviesForKeywordWithId {
    XCTestExpectation *moviesForKeywordWithIdExpectation = [self expectationWithDescription:@"moviesForKeywordWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] moviesWithKeywordId:1721 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [moviesForKeywordWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetListWithId {
    XCTestExpectation *getListWithIdExpectation = [self expectationWithDescription:@"getListWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] listWithId:@"509ec17b19c2950a0600050d" complete:^(id results, NSError *error) {
        if(!error) {
            [getListWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetListItemStatus {
    XCTestExpectation *getListWithIdExpectation = [self expectationWithDescription:@"getListWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] checkMovie:550 isInList:@"509ec17b19c2950a0600050d" complete:^(id results, NSError *error) {
        if(!error) {
            [getListWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


#pragma mark -- Movies tests

-(void)testCanGetMovieWithId {
    XCTestExpectation *getMovieWithIdExpectation = [self expectationWithDescription:@"getMovieWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] movieWithId:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieAlternativeTitles {
    XCTestExpectation *testCanGetMovieAlternativeTitlesExpectation = [self expectationWithDescription:@"testCanGetMovieAlternativeTitlesExpectation"];
    
    [[KMMTMDBAPIClient client] alternativeTitlesForMovie:550 inCountry:@"GB" complete:^(id results, NSError *error) {
        if(!error) {
            [testCanGetMovieAlternativeTitlesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieCredits {
    XCTestExpectation *getMovieCreditsExpectation = [self expectationWithDescription:@"getMovieCreditsExpectation"];
    
    [[KMMTMDBAPIClient client] creditsForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieCreditsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieImages {
    XCTestExpectation *getMovieImagesExpectation = [self expectationWithDescription:@"getMovieImagesExpectation"];
    
    [[KMMTMDBAPIClient client] imagesForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieImagesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieKeywords {
    XCTestExpectation *getMovieKeywordsExpectation = [self expectationWithDescription:@"getMovieKeywordsExpectation"];
    
    [[KMMTMDBAPIClient client] keywordsForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieKeywordsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieReleases {
    XCTestExpectation *getMovieReleasesExpectation = [self expectationWithDescription:@"getMovieReleasesExpectation"];
    
    [[KMMTMDBAPIClient client] releasesForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieReleasesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieVideos {
    XCTestExpectation *getMovieVideosExpectation = [self expectationWithDescription:@"getMovieVideosExpectation"];
    
    [[KMMTMDBAPIClient client] videosForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieVideosExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieTranslations {
    XCTestExpectation *getMovieTranslationsExpectation = [self expectationWithDescription:@"getMovieTranslationsExpectation"];
    
    [[KMMTMDBAPIClient client] translationsForMovie:550 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieTranslationsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieSimilar {
    XCTestExpectation *getMovieSimilarExpectation = [self expectationWithDescription:@"getMovieSimilarExpectation"];
    
    [[KMMTMDBAPIClient client] similarMoviesForMovie:550 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieSimilarExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieReviews {
    XCTestExpectation *getMovieReviewsExpectation = [self expectationWithDescription:@"getMovieReviewsExpectation"];
    
    [[KMMTMDBAPIClient client] reviewsForMovie:550 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieReviewsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieLists {
    XCTestExpectation *getMovieListsExpectation = [self expectationWithDescription:@"getMovieListsExpectation"];
    
    [[KMMTMDBAPIClient client] listsForMovie:550 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieListsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetMovieChanges {
    XCTestExpectation *getMovieChangesExpectation = [self expectationWithDescription:@"getMovieChangesExpectation"];
    
    [[KMMTMDBAPIClient client] changesForMovie:550 from:[NSDate date] to:[NSDate date] complete:^(id results, NSError *error) {
        if(!error) {
            [getMovieChangesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetLatestMovie {
    XCTestExpectation *getLatestMovieExpectation = [self expectationWithDescription:@"getLatestMovieExpectation"];
    
    [[KMMTMDBAPIClient client] latestMovieWithBlock:^(id results, NSError *error) {
        if(!error) {
            [getLatestMovieExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetUpcomingMovies {
    XCTestExpectation *getUpcomingMoviesExpectation = [self expectationWithDescription:@"getUpcomingMoviesExpectation"];
    
    [[KMMTMDBAPIClient client] upcomingMoviesInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getUpcomingMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetNowPlayingMovies {
    XCTestExpectation *getNowPlayingMoviesExpectation = [self expectationWithDescription:@"getNowPlayingMoviesExpectation"];
    
    [[KMMTMDBAPIClient client] nowPlayingMoviesInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getNowPlayingMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPopularMovies {
    XCTestExpectation *getPopularMoviesExpectation = [self expectationWithDescription:@"getPopularMoviesExpectation"];
    
    [[KMMTMDBAPIClient client] nowPlayingMoviesInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getPopularMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetTopRatedMovies {
    XCTestExpectation *getTopRatedMoviesExpectation = [self expectationWithDescription:@"getTopRatedMoviesExpectation"];
    
    [[KMMTMDBAPIClient client] nowPlayingMoviesInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getTopRatedMoviesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Network tests

-(void)testCanGetNetworkWithId {
    XCTestExpectation *getNetworkExpectation = [self expectationWithDescription:@"getNetworkExpectation"];
    
    [[KMMTMDBAPIClient client] TVNetworkWithId:49 complete:^(id results, NSError *error) {
        if(!error) {
            [getNetworkExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- People tests

-(void)testCanGetPersonWithId {
    XCTestExpectation *getPersonExpectation = [self expectationWithDescription:@"getPersonExpectation"];
    
    [[KMMTMDBAPIClient client] personWithId:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonMovieCredits {
    XCTestExpectation *getPersonMovieCreditsExpectation = [self expectationWithDescription:@"getPersonMovieCreditsExpectation"];
    
    [[KMMTMDBAPIClient client] movieCreditsForPerson:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonMovieCreditsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonTVCredits {
    XCTestExpectation *getPersonTVCreditsExpectation = [self expectationWithDescription:@"getPersonTVCreditsExpectation"];
    
    [[KMMTMDBAPIClient client] TVCreditsForPerson:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonTVCreditsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonCombinedCredits {
    XCTestExpectation *getPersonCombinedCreditsExpectation = [self expectationWithDescription:@"getPersonCombinedCreditsExpectation"];
    
    [[KMMTMDBAPIClient client] TVCreditsForPerson:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonCombinedCreditsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonExternalIds {
    XCTestExpectation *getPersonExternalIdsExpectation = [self expectationWithDescription:@"getPersonExternalIdsExpectation"];
    
    [[KMMTMDBAPIClient client] externalIdsForPerson:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonExternalIdsExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetImagesForPerson {
    XCTestExpectation *getPersonImagesExpectation = [self expectationWithDescription:@"getPersonImagesExpectation"];
    
    [[KMMTMDBAPIClient client] imagesForPerson:287 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonImagesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonTaggedImages {
    XCTestExpectation *getPersonTaggedImagesExpectation = [self expectationWithDescription:@"getPersonTaggedImagesExpectation"];
    
    [[KMMTMDBAPIClient client] taggedImagesForPerson:287 inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonTaggedImagesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPersonChanges {
    XCTestExpectation *getPersonChangesExpectation = [self expectationWithDescription:@"getPersonChangesExpectation"];
    
    [[KMMTMDBAPIClient client] changesForPerson:287 from:[NSDate date] to:[NSDate date] complete:^(id results, NSError *error) {
        if(!error) {
            [getPersonChangesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetPopularPeople {
    XCTestExpectation *getPopularPeopleExpectation = [self expectationWithDescription:@"getPopularPeopleExpectation"];
    
    [[KMMTMDBAPIClient client] popularPeopleInPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [getPopularPeopleExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

-(void)testCanGetLatestPerson {
    XCTestExpectation *getLatestPersonExpectation = [self expectationWithDescription:@"getLatestPersonExpectation"];
    
    [[KMMTMDBAPIClient client] latestPersonWithBlock:^(id results, NSError *error) {
        if(!error) {
            [getLatestPersonExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Reviews tests

-(void)testCanGetReviewWithId {
    XCTestExpectation *getReviewWithIdExpectation = [self expectationWithDescription:@"getReviewWithIdExpectation"];
    
    [[KMMTMDBAPIClient client] reviewWithId:@"5013bc76760ee372cb00253e" complete:^(id results, NSError *error) {
        if(!error) {
            [getReviewWithIdExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

#pragma mark -- Search tests

-(void)testCanSearchForCompanies {
    XCTestExpectation *searchCompaniesExpectation = [self expectationWithDescription:@"searchCompaniesExpectation"];
    
    [[KMMTMDBAPIClient client] searchCompaniesForTerm:@"lucas" inPage:1 complete:^(id results, NSError *error) {
        if(!error) {
            [searchCompaniesExpectation fulfill];
        }
    }];
    [self waitForExpectationsWithTimeout:3 handler:nil];
}


@end