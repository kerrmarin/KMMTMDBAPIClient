//
//  KMMTMDBAPIClient.m
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import "KMMTMDBAPIClient.h"

#import "AFHTTPRequestOperation.h"

#import "NSDictionary+MovieParameters.h"
#import "NSDictionary+TVParameters.h"

#import "KMMTimezone.h"

@interface KMMTMDBAPIClient ()

@property(nonatomic, copy) NSString *apiKey;
@property(nonatomic, copy, readonly) NSString *configurationURL;
@property(nonatomic, strong) NSDateFormatter *formatter;

@end

//const NSInteger KMMReleaseYearAny = INT_MAX;

NSString* NSStringFromTMDBExternalSource(TMDBExternalSource source) {
    switch (source) {
        case TMDBExternalSourceIMDB:
            return @"imdb_id";
            break;
        case TMDBExternalSourceFreebaseMid:
            return @"freebase_mid";
            break;
        case TMDBExternalSourceFreebaseId:
            return @"freebase_id";
            break;
        case TMDBExternalSourceTVRageId:
            return @"tvrage_id";
            break;
        case TMDBExternalSourceTVDBId:
            return @"tvdb_id";
            break;
        case TMDBExternalSourceUnknown:
        default:
            return @"";
            break;
    }
}

NSString* NSStringFromTMDBSearchType(TMDBSearchType type) {
    switch (type) {
        case TMDBSearchTypePhrase:
            return @"phrase";
            break;
        case TMDBSearchTypeNgram:
            return @"ngram";
            break;
        case TMDBSearchTypeUnknown:
        default:
            return @"phrase";
            break;
    }
}

@implementation KMMTMDBAPIClient

+(instancetype)client {
    static KMMTMDBAPIClient *_client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [KMMTMDBAPIClient new];
    });
    return _client;
}

/**
 *  Initializes the TMDBAPIClient
 *
 *  @return a fully initialized API client
 */
-(instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.themoviedb.org/3/"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json"}];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024
                                                      diskCapacity:200 * 1024 * 1024
                                                          diskPath:nil];
    [config setURLCache:cache];
    //10 seconds timeout for whole resource
    [config setTimeoutIntervalForResource:10];
    //5 second timeout for any communication to occur
    [config setTimeoutIntervalForRequest:5];
    
    if(self = [super initWithBaseURL:baseURL sessionConfiguration:config]) {
        _includeAdult = @"false";
        _language = @"en";
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return self;
}

#pragma mark -- Data fetching

#pragma mark -- Certifications


-(NSURLSessionDataTask *)supportedMovieCertificationsWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath: @"certification/movie/list"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)supportedTVCertificationsWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath: @"certification/tv/list"
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- Changes


-(NSURLSessionDataTask *)latestMovieChangesFrom:(NSDate*)from
                                             to:(NSDate*)to
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSURLSessionDataTask *task = [self getWithPath: @"movie/changes"
                                            params:@{@"page" : @(pageNumber),
                                                     @"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
    
}


-(NSURLSessionDataTask *)latestPersonChangesFrom:(NSDate*)from
                                              to:(NSDate*)to
                                          inPage:(NSInteger)pageNumber
                                        complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSURLSessionDataTask *task = [self getWithPath: @"person/changes"
                                            params:@{@"page" : @(pageNumber),
                                                     @"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
    
}


-(NSURLSessionDataTask *)latestTVChangesFrom:(NSDate*)from
                                          to:(NSDate*)to
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSURLSessionDataTask *task = [self getWithPath: @"tv/changes"
                                            params:@{@"page" : @(pageNumber),
                                                     @"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
    
}

#pragma mark -- Collections

-(NSURLSessionDataTask *)collectionWithId:(NSInteger)collectionId
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"collection/%ld", (long)collectionId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"append_to_response" : @"images"}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForCollection:(NSInteger)collectionId
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"collection/%ld/images", (long)collectionId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


#pragma mark -- Companies

-(NSURLSessionDataTask *)companyWithID:(NSInteger)companyID
                              complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"company/%ld", (long)companyID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"append_to_response" : @"movies"}
                                          complete:complete];
    return task;
}

-(NSURLSessionDataTask *)moviesForCompany:(NSInteger)companyID
                                   inPage:(NSInteger)page
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"company/%ld/movies", (long)companyID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(page)}
                                          complete:complete];
    return task;
}


#pragma mark -- Credits

-(NSURLSessionDataTask *)creditWithId:(NSString*)creditID
                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"credit/%@", creditID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- Discover


-(NSURLSessionDataTask *)discoverMoviesWithCriteria:(KMMMovieCriteria *)criteria
                                             inPage:(NSInteger)pageNumber
                                           complete:(KMMNetworkingCompletionBlock)complete {
    NSDictionary *params = [NSDictionary dictionaryWithMovieCriteria:criteria inPage:pageNumber dateFormatter:self.formatter];
    NSURLSessionDataTask *task = [self getWithPath:@"discover/movie"
                                            params:params
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)discoverTVWithCriteria:(KMMTVCriteria *)criteria
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSDictionary *params = [NSDictionary dictionaryWithTVCriteria:criteria inPage:pageNumber dateFormatter:self.formatter];
    NSURLSessionDataTask *task = [self getWithPath:@"discover/tv"
                                            params:params
                                          complete:complete];
    return task;
}


#pragma mark -- Find


-(NSURLSessionDataTask *)findResource:(NSString*)resourceId
                     inExternalSource:(TMDBExternalSource)source
                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *sourceString = NSStringFromTMDBExternalSource(source);
    NSString *path = [NSString stringWithFormat:@"find/%@", resourceId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{ @"external_source" : sourceString }
                                          complete:complete];
    return task;
}


#pragma mark -- Genres


-(NSURLSessionDataTask *)allMovieGenresWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"genre/movie/list"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)allTVGenresWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"genre/tv/list"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)moviesWithGenre:(NSInteger)genreID
                                  inPage:(NSInteger)page
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"genre/%ld/movies", (long)genreID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(page)}
                                          complete:complete];
    return task;
}

#pragma mark -- Jobs


-(NSURLSessionDataTask *)allJobsWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"job/list"
                                            params:@{}
                                          complete:complete];
    return task;
}


#pragma mark -- Keywords


-(NSURLSessionDataTask *)keywordWithId:(NSInteger)keywordId
                              complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"keyword/%ld" , (long)keywordId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)moviesWithKeywordId:(NSInteger)keywordId
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"keyword/%ld/movies", (long)keywordId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


#pragma mark -- Lists

-(NSURLSessionDataTask *)listWithId:(NSString*)listId
                           complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"list/%@", listId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}



-(NSURLSessionDataTask *)checkMovie:(NSInteger)movieId
                           isInList:(NSString*)listId
                           complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"list/%@/item_status", listId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"movie_id" : @(movieId)}
                                          complete:complete];
    return task;
}

#pragma mark -- Movies


-(NSURLSessionDataTask *)movieWithId:(NSInteger)movieID
                            complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:[@"movie/" stringByAppendingFormat:@"%ld", (long)movieID]
                                            params:@{@"append_to_response" : @"alternative_titles,videos,credits,images,keywords,releases,similar,reviews"}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)alternativeTitlesForMovie:(NSInteger)movieId
                                         inCountry:(NSString*)countryCode
                                          complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/alternative_titles", (long)movieId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"country" : countryCode}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)creditsForMovie:(NSInteger)movieID
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/credits", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForMovie:(NSInteger)movieID
                               complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/images", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)keywordsForMovie:(NSInteger)movieID
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/keywords", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)releasesForMovie:(NSInteger)movieID
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/releases", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)videosForMovie:(NSInteger)movieID
                               complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/videos", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)translationsForMovie:(NSInteger)movieID
                                     complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/translations", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)similarMoviesForMovie:(NSInteger)movieID
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/similar", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)reviewsForMovie:(NSInteger)movieID
                                  inPage:(NSInteger)pageNumber
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/reviews", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)listsForMovie:(NSInteger)movieID
                                inPage:(NSInteger)pageNumber
                              complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/lists", (long)movieID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)changesForMovie:(NSInteger)movieID
                                    from:(NSDate*)from
                                      to:(NSDate*)to
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"movie/%ld/changes", (long)movieID];
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)latestMovieWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/latest"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)upcomingMoviesInPage:(NSInteger)pageNumber
                                     complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/upcoming"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)nowPlayingMoviesInPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/now_playing"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)popularMoviesInPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/popular"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)topRatedMoviesInPage:(NSInteger)pageNumber
                                     complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/top_rated"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}



#pragma mark -- Networks


-(NSURLSessionDataTask *)TVNetworkWithId:(NSInteger)networkId
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"network/%ld", (long)networkId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- People


-(NSURLSessionDataTask *)personWithId:(NSInteger)personID
                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"append_to_response" : @"combined_credits,external_ids,images,tagged_images"}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)movieCreditsForPerson:(NSInteger)personId
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/movie_credits", (long)personId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)TVCreditsForPerson:(NSInteger)personID
                                   complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/tv_credits", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)combinedCreditsForPerson:(NSInteger)personID
                                         complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/combined_credits", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)externalIdsForPerson:(NSInteger)personID
                                     complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/external_ids", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForPerson:(NSInteger)personID
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/images", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)taggedImagesForPerson:(NSInteger)personID
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld/tagged_images", (long)personID];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)changesForPerson:(NSInteger)personID
                                     from:(NSDate*)from
                                       to:(NSDate*)to
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"person/%ld", (long)personID];
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)popularPeopleInPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"person/popular"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)latestPersonWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"person/latest"
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- Reviews


-(NSURLSessionDataTask *)reviewWithId:(NSString*)reviewId
                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"review/%@", reviewId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- Search


-(NSURLSessionDataTask *)searchPeopleForTerm:(NSString*)searchTerm
                                      inPage:(NSInteger)pageNumber
                                    withType:(TMDBSearchType)type
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/person"
                                            params:@{@"page" : @(pageNumber),
                                                     @"search_type" : NSStringFromTMDBSearchType(type),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchMoviesForTerm:(NSString*)searchTerm
                                 releaseYear:(NSInteger)releaseYear
                                    withType:(TMDBSearchType)type
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(pageNumber);
    parameters[@"search_type"] = NSStringFromTMDBSearchType(type);
    parameters[@"query"] = searchTerm;
    if(releaseYear) {
        parameters[@"year"] = @(releaseYear);
    }
    NSURLSessionDataTask *task = [self getWithPath:@"search/movie"
                                            params:[parameters copy]
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchForTerm:(NSString*)searchTerm
                                inPage:(NSInteger)pageNumber
                              complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/multi"
                                            params:@{@"page" : @(pageNumber),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchCompaniesForTerm:(NSString*)searchTerm
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/company"
                                            params:@{@"page" : @(pageNumber),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchCollectionForTerm:(NSString*)searchTerm
                                          inPage:(NSInteger)pageNumber
                                        complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/collection"
                                            params:@{@"page" : @(pageNumber),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchKeywordsForTerm:(NSString*)searchTerm
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/keyword"
                                            params:@{@"page" : @(pageNumber),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchListsForTerm:(NSString*)searchTerm
                                     inPage:(NSInteger)pageNumber
                                   complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"search/list"
                                            params:@{@"page" : @(pageNumber),
                                                     @"query" : searchTerm}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)searchTVForTerm:(NSString*)searchTerm
                                  inPage:(NSInteger)pageNumber
                          firstAiredYear:(NSInteger)firstAiredYear
                              searchType:(TMDBSearchType)searchType
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(pageNumber);
    parameters[@"search_type"] = NSStringFromTMDBSearchType(searchType);
    parameters[@"query"] = searchTerm;
    if(firstAiredYear) {
        parameters[@"first_air_date_year"] = @(firstAiredYear);
    }
    NSURLSessionDataTask *task = [self getWithPath:@"search/tv"
                                            params:[parameters copy]
                                          complete:complete];
    return task;
}

#pragma mark -- Timezones


-(NSURLSessionDataTask *)timezonesWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"timezones/list"
                                            params:@{}
                                          complete:complete];
    return task;
}

#pragma mark -- TV


-(NSURLSessionDataTask *)TVSeriesWithId:(NSInteger)seriesId
                               complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"append_to_response" : @"alternative_titles,content_ratings,credits,external_ids,images,keywords,similar,translations,videos"}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)alternativeTitlesForTVSeries:(NSInteger)seriesId
                                            inCountry:(NSString *)countryCode
                                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/alternative_titles", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
    
}


-(NSURLSessionDataTask *)changesForTVSeries:(NSInteger)seriesId
                                       from:(NSDate*)from
                                         to:(NSDate*)to
                                   complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSString *path = [NSString stringWithFormat:@"tv/%ld/changes", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)contentRatingsForTVSeries:(NSInteger)seriesId
                                          complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/content_ratings", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)creditsForTVSeries:(NSInteger)seriesId
                                   complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/credits",(long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)externalIdsForTVSeries:(NSInteger)seriesId
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/external_ids", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/alternative_titles", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)keywordsForTVSeries:(NSInteger)seriesId
                                    complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/keywords", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)similarSeriesForTVSeries:(NSInteger)seriesId
                                           inPage:(NSInteger)pageNumber
                                         complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/similar", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)translationsForTVSeries:(NSInteger)seriesId
                                        complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/translations", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)videosForTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/videos", (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)latestTVSeriesWithBlock:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"tv/latest"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)currentlyAiringTVSeriesInPage:(NSInteger)pageNumber
                                              complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"tv/on_the_air"
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)TVSeriesAiringTodayInTimezone:(KMMTimezone*)timezone
                                                inPage:(NSInteger)pageNumber
                                              complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"tv/airing_today"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)topRatedTVSeriesInPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"tv/top_rated"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)popularTVSeriesInPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSURLSessionDataTask *task = [self getWithPath:@"tv/popular"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}



#pragma mark -- TV Seasons


-(NSURLSessionDataTask *)seasonNumber:(NSInteger)seasonNumber
                          forTVSeries:(NSInteger)seriesId
                             complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld",(long)seriesId, (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)changesForSeason:(NSInteger)seasonId
                                     from:(NSDate*)from
                                       to:(NSDate*)to
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSString *path = [NSString stringWithFormat:@"tv/season/%ld/changes", (long)seasonId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"start_date" : startDate,
                                                     @"end_date" : endDate}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)creditsForSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/credits",(long)seriesId, (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)externalIdsForSeason:(NSInteger)seasonNumber
                                  forTVSeries:(NSInteger)seriesId
                                     complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/external_ids",(long)seriesId, (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForSeason:(NSInteger)seasonNumber
                             forTVSeries:(NSInteger)seriesId
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/images",(long)seriesId, (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)videosForSeason:(NSInteger)seasonNumber
                             forTVSeries:(NSInteger)seriesId
                                complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/videos",(long)seriesId, (long)seriesId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


#pragma mark -- Episodes


-(NSURLSessionDataTask *)episode:(NSInteger)episodeNumber
                        inSeason:(NSInteger)seasonNumber
                     forTVSeries:(NSInteger)seriesId
                        complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/episode/%ld",(long)seriesId, (long)seriesId, (long)episodeNumber];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"append_to_response" : @"credits,external_ids,images,videos"}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)changesForEpisode:(NSInteger)episodeId
                                      from:(NSDate*)from
                                        to:(NSDate*)to
                                  complete:(KMMNetworkingCompletionBlock)complete {
    NSString *startDate = [self.formatter stringFromDate:from];
    NSString *endDate = [self.formatter stringFromDate:to];
    NSString *path = [NSString stringWithFormat:@"tv/episode/%ld/changes", (long)episodeId];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{@"start_date" : startDate,
                                                     @"end_date" :endDate}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)creditsForEpisode:(NSInteger)episodeNumber
                                  inSeason:(NSInteger)seasonNumber
                               forTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/episode/%ld/credits",(long)seriesId, (long)seriesId, (long)episodeNumber];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)externalIdsForEpisode:(NSInteger)episodeNumber
                                      inSeason:(NSInteger)seasonNumber
                                   forTVSeries:(NSInteger)seriesId
                                      complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/episode/%ld/external_ids",(long)seriesId, (long)seriesId, (long)episodeNumber];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)imagesForEpisode:(NSInteger)episodeNumber
                                 inSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/episode/%ld/images",(long)seriesId, (long)seriesId, (long)episodeNumber];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


-(NSURLSessionDataTask *)videosForEpisode:(NSInteger)episodeNumber
                                 inSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete {
    NSString *path = [NSString stringWithFormat:@"tv/%ld/season/%ld/episode/%ld/videos",(long)seriesId, (long)seriesId, (long)episodeNumber];
    NSURLSessionDataTask *task = [self getWithPath:path
                                            params:@{}
                                          complete:complete];
    return task;
}


#pragma mark -- Images

/**
 *  Fetches a picture from a given path
 *
 *  @param path     the path to get the images for
 *  @param complete the block to execute once the request has finished
 *
 *  @return an AFHTTPRequestOperation with the current request
 */
-(void)getImageWithPath:(NSString*)path
               complete:(void (^)(UIImage *image, NSError *error))complete {

    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString: [self.configurationURL stringByAppendingString:path]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        postOperation.responseSerializer = [AFImageResponseSerializer serializer];
        
        [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(responseObject, nil);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil, error);
            });
        }];
        [postOperation start];
    }];
    
    //Images can only be loaded if the config URL has been retrieved, so lets add them to the
    // operation queue if the config url hasn't finished yet
    if(!self.configurationURL) {
        [self.operationQueue addOperation:operation];
    } else {
        [operation start];
    }
}


#pragma mark -- Helpers

/**
 *  Sets the API key
 *
 *  @param apiKey a valid TMDB API key, available for request at themoviedb.org
 */
-(void)setAPIKey:(NSString *)apiKey {
    if(apiKey == _apiKey) return;
    _apiKey = [apiKey copy];
    [self updateConfigURL];
}


/**
 *  Performs a GET request with the given path
 *
 *  @param path       the path to perform the request
 *  @param params     a set of extra parameters to add to the defaults
 *  @param completion the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *) getWithPath:(NSString*)path
                               params:(NSDictionary*)params
                             complete:(KMMNetworkingCompletionBlock)completion {
    NSDictionary *parameters = [self buildParams:params];
    NSURLSessionDataTask *task = [self GET:path
                                parameters:parameters
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject, nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
}

/**
 *  Builds the parameters dictionary by adding the API key to the passed in parameters.
 *
 *  @param params the parameters to add to the defaults
 *
 *  @return a copy of the merge of the given parameters and the default parameters
 */
-(NSDictionary*)buildParams:(NSDictionary*)params {
    NSDictionary *defaultParameters = @{@"api_key": self.apiKey,
                                        @"include_adult" :self.includeAdult,
                                        @"language" : self.language};;
    NSMutableDictionary *dict = [params mutableCopy];
    [dict addEntriesFromDictionary:defaultParameters];
    return [dict copy];
}


/*
 * Gets and updates the configuration URL for images
 */
-(void) updateConfigURL {
    NSString *pathAndParameters = [@"configuration?" stringByAppendingString:[@"api_key=" stringByAppendingString:self.apiKey]];
    NSURL *url = [NSURL URLWithString:[self.baseURL.absoluteString stringByAppendingString:pathAndParameters]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *getConfigOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    getConfigOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [getConfigOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _configurationURL = responseObject[@"images"][@"base_url"];
        });
    } failure:nil];
    
    [self.operationQueue addOperation:getConfigOperation];
}



@end
