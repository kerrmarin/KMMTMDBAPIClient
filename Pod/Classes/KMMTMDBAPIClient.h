//
//  KMMTMDBAPIClient.h
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@class AFHTTPRequestOperation;
@class KMMMovieFilter;

typedef void (^KMMNetworkingCompletionBlock)(id results, NSError *error);

@interface KMMTMDBAPIClient : AFHTTPSessionManager

/**
 *  Must be one of "false" or "true". Defaults to "false"
 */
@property(nonatomic, copy) NSString *includeAdult;

/**
 *  ISO 639-1 string for language. e.g. "en"
 */
@property(nonatomic, copy) NSString *language;

/**
 *  Returns an instance of the TMDB API client
 *
 *  @return a fully initialized KMMTMDBAPIClient
 */
+(instancetype)client;

/**
 *  Sets the API key to use with each requet to the TMDB API
 *
 *  @param apiKey the API key for your account
 */
-(void)setAPIKey:(NSString*)apiKey;

/**
 *  Fetches popular movies in the given page number.
 *
 *  @param pageNumber the page number to get
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)fetchPopularMoviesInPage:(NSInteger)pageNumber
                                         complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches a movie's details
 *
 *  @param movieID  the movie ID to get the details for
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)fetchMovieWithID:(NSInteger)movieID
                                 complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Fetches the details for a company
 *
 *  @param companyID the company ID to get the details for
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)fetchCompanyWithID:(NSInteger)companyID
                                   complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches all genres
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)allGenres:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches movies with the given genre
 *
 *  @param genreID  The genre to fetch movies for
 *  @param page     the page number to get
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)moviesWithGenre:(NSInteger)genreID
                                  inPage:(NSInteger)page
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches filtered movies
 *
 *  @param filter     the filter to use when fetching movies
 *  @param pageNumber the page number to get
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)filterMovies:(KMMMovieFilter *)filter
                               inPage:(NSInteger)pageNumber
                             complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Searches cast for the given term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchCastForTerm:(NSString*)searchTerm
                                      page:(NSInteger)pageNumber
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Searches movies for the given term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchMoviesForTerm:(NSString*)searchTerm
                                        page:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Searches at a minimum movies and cast for the given term
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchForTerm:(NSString*)searchTerm
                                  page:(NSInteger)pageNumber
                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Gets the credits for a specific person (i.e. the movie's they've been in)
 *
 *  @param personId the ID of the person to search for
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)movieCreditsForPerson:(NSInteger)personId
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches a person's details
 *
 *  @param personID the ID of the person to get the details for
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)fetchPersonWithID:(NSInteger)personID
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Fetches an image with the given path
 *
 *  @param path     the path to fetch the image from
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(AFHTTPRequestOperation *)getImageWithPath:(NSString*)path
                                   complete:(void (^)(UIImage *image, NSError *error))complete;



@end
