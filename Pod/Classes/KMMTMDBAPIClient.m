//
//  KMMTMDBAPIClient.m
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import "KMMTMDBAPIClient.h"

#import "AFHTTPRequestOperation.h"

#import "KMMMovieFilter.h"

@interface KMMTMDBAPIClient ()

@property(nonatomic, copy) NSString *apiKey;
@property(nonatomic, copy, readonly) NSString *configurationURL;

@end

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
    }
    
    return self;
}

#pragma mark -- Data fetching

/**
 *  Fetches the popular movies in a given page
 *
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)fetchPopularMoviesInPage:(NSInteger)pageNumber complete:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:@"movie/popular"
                                            params:@{@"page" : @(pageNumber)}
                                          complete:complete];
    return task;
}

/**
 *  Fetches the details for a particular movie
 *
 *  @param movieID  the movie ID to fetch the details for
 *  @param complete the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)fetchMovieWithID:(NSInteger)movieID complete:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:[@"movie/" stringByAppendingFormat:@"%lu", (unsigned long)movieID]
                                            params:@{@"append_to_response" : @"alternative_titles,videos,credits,images,keywords,releases,similar,reviews"}
                                          complete:complete];
    return task;
}

/**
 *  Fetches the details of a company given a particular ID
 *
 *  @param companyID the company ID
 *  @param complete  the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)fetchCompanyWithID:(NSInteger)companyID complete:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:[@"company/" stringByAppendingFormat:@"%ld", (long)companyID]
                                            params:@{}
                                          complete:complete];
    return task;
}


#pragma mark -- Genres

/**
 *  Fetches al genres available
 *
 *  @param complete the block to execute once the request has finished
 *
 *  @return  an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)allGenres:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:@"genre/list"
                                            params:@{}
                                          complete:complete];
    return task;
}

/**
 *  Fetches the movies with a particular genre
 *
 *  @param genreID  the ID of the genre to fetch
 *  @param page     the page number to fetch movies for
 *  @param complete the block to execute once the request has finished
 *
 *  @return  an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)moviesWithGenre:(NSInteger)genreID inPage:(NSInteger)page complete:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:[NSString stringWithFormat: @"genre/%ld/movies", (long)genreID]
                                            params:@{@"page" : @(page)}
                                          complete:complete];
    return task;
}


#pragma mark -- Filtering

/**
 *  Fetches movies with a particular filter
 *
 *  @param filter     the filter to apply to the movie query
 *  @param pageNumber the page number to fetch with that query
 *  @param complete   the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)filterMovies:(KMMMovieFilter *)filter
                               inPage:(NSInteger)pageNumber
                             complete:(KMMNetworkingCompletionBlock)complete {

    NSMutableDictionary *params = [@{@"page" : @(pageNumber)} mutableCopy];

    if(filter.yearRange.location != NSNotFound && filter.yearRange.length != NSNotFound) {
        NSString *releaseDateGTE = [[NSString alloc] initWithFormat:@"%lu-01-01", (unsigned long)filter.yearRange.location];
        NSString *releaseDateLTE = [[NSString alloc] initWithFormat:@"%lu-12-31", (unsigned long)(filter.yearRange.location+filter.yearRange.length)];
        params[@"release_date.gte"] = releaseDateGTE;
        params[@"release_date.lte"] = releaseDateLTE;
    }

    if(filter.genreId != NSNotFound) {
        params[@"with_genres"] = @(filter.genreId);
    }

    params[@"sort_by"] = NSStringFromKMMFilterSortBy(filter.sortBy);

    //For top rated, include also a vote count to avoid all the crap with 1-2 votes
    if (filter.sortBy == KMMFilterSortByTopRated) {
        params[@"vote_count.gte"] = @"10";
    }

    NSURLSessionDataTask *task = [self getWithPath:@"discover/movie"
                                            params:params
                                          complete:complete];

    return task;
}


#pragma mark -- Searching

/**
 *  Searches the cast for a particular term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to retrieve based on the search
 *  @param complete   the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)searchCastForTerm:(NSString*)searchTerm page:(NSInteger)pageNumber complete:(KMMNetworkingCompletionBlock) complete {
    NSDictionary *params = @{@"query": searchTerm, @"page" : @(pageNumber), @"search_type" : @"ngram"};
    NSURLSessionDataTask *task = [self getWithPath:@"search/person"
                                            params:params
                                          complete:complete];
    return task;
}

/**
 *  Searches the movies for a particular term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to retrieve
 *  @param complete   the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)searchMoviesForTerm:(NSString*)searchTerm page:(NSInteger)pageNumber complete:(KMMNetworkingCompletionBlock) complete {
    NSDictionary *params = @{@"query": searchTerm, @"page" : @(pageNumber), @"search_type" : @"ngram"};
    NSURLSessionDataTask *task = [self getWithPath:@"search/movie"
                                            params:params
                                          complete:complete];
    return task;
}

/**
 *  Searches multiple sources for a given term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to retrieve
 *  @param complete   the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)searchForTerm:(NSString *)searchTerm page:(NSInteger)pageNumber complete:(KMMNetworkingCompletionBlock)complete {
    NSDictionary *params = @{@"query": searchTerm, @"page" : @(pageNumber), @"search_type" : @"ngram"};
    NSURLSessionDataTask *task = [self getWithPath:@"search/multi"
                                            params:params
                                          complete:complete];
    return task;
}


#pragma mark -- People

/**
 *  Retrieves the credits for a particular person (i.e. the movie's they've been in)
 *
 *  @param personId the ID of the person to fetch the credits for
 *  @param complete the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)movieCreditsForPerson:(NSInteger)personId complete:(KMMNetworkingCompletionBlock) complete {
    NSString *string =[NSString stringWithFormat:@"person/%ld/movie_credits", (long)personId];
    NSURLSessionDataTask *task = [self getWithPath: string
                                            params:@{}
                                          complete:complete];
    return task;
}

/**
 *  Retrieves the details for a particular person
 *
 *  @param personID the ID of the person to fetch the details for
 *  @param complete the block to execute once the request has finished
 *
 *  @return an NSURLSessionDataTask with the current request
 */
-(NSURLSessionDataTask *)fetchPersonWithID:(NSInteger)personID complete:(KMMNetworkingCompletionBlock) complete {
    NSURLSessionDataTask *task = [self getWithPath:[@"person/" stringByAppendingFormat:@"%ld", (long)personID]
                                            params:@{@"append_to_response" : @"movie_credits,images,tagged_images"}
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
-(AFHTTPRequestOperation *)getImageWithPath:(NSString*)path
                                   complete:(void (^)(UIImage *image, NSError *error))complete {
    
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
    return postOperation;
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
    [self getWithPath:@"configuration"
               params:@{}
             complete:^(id results, NSError *error) {
                 if(!error) {
                     _configurationURL = results[@"images"][@"base_url"];
                 }
             }];
}

@end
