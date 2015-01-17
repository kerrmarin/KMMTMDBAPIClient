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
@class KMMMovieCriteria;
@class KMMTVCriteria;
@class KMMTimezone;

typedef NS_ENUM(NSInteger, TMDBExternalSource) {
    TMDBExternalSourceUnknown = 0,
    TMDBExternalSourceIMDB,
    TMDBExternalSourceFreebaseMid,
    TMDBExternalSourceFreebaseId,
    TMDBExternalSourceTVRageId,
    TMDBExternalSourceTVDBId
};

typedef NS_ENUM(NSInteger, TMDBSearchType) {
    TMDBSearchTypeUnknown = 0,
    TMDBSearchTypePhrase,
    TMDBSearchTypeNgram
};

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


#pragma mark -- Certifications

/**
 *  Get the list of supported certifications for movies. These can be used
 *  in conjunction with the certification_country and certification.lte
 *  parameters when using discover.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)supportedMovieCertificationsWithBlock:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of supported certifications for tv shows. These can be used 
 *  in conjunction with the certification_country and certification.lte 
 *  parameters when using discover.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)supportedTVCertificationsWithBlock:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Changes

/**
 *  Get a list of movie ids that have been edited.
 *  By default we show the last 24 hours and only 100 items per page. 
 *  The maximum number of days that can be returned in a single request is 14. 
 *  You can then use the movie changes API to get the actual data that has been changed.
 *
 *  Please note: the change log system to support this was changed on October 5, 
 *  2012 and will only show movies that have been edited since.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestMovieChangesFrom:(NSDate*)from
                                             to:(NSDate*)to
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get a list of people ids that have been edited.
 *  By default we show the last 24 hours and only 100 items per page.
 *  The maximum number of days that can be returned in a single request is 14. 
 *  You can then use the person changes API to get the actual data that has been changed.
 *  Please note: the change log system to support this was changed on October 5, 
 *  2012 and will only show people that have been edited since.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestPersonChangesFrom:(NSDate*)from
                                              to:(NSDate*)to
                                          inPage:(NSInteger)pageNumber
                                        complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get a list of TV show ids that have been edited.
 *  By default we show the last 24 hours and only 100 items per page.
 *  The maximum number of days that can be returned in a single request is 14.
 *  You can then use the TV changes API to get the actual data that has been changed.
 *  Please note: the change log system to properly support TV was updated on May 13,
 *  2014. You'll likely only find the edits made since then to be useful in the change log system.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestTVChangesFrom:(NSDate*)from
                                          to:(NSDate*)to
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Collections

/**
 *  Get the basic collection information for a specific collection id.
 *  You can get the ID needed for this method by making a /movie/{id} request
 *  and paying attention to the belongs_to_collection hash.Movie parts are not
 *  sorted in any particular order. If you would like to sort them yourself you
 *  can use the provided release_date.
 *
 *  @param collectionId the collection ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)collectionWithId:(NSInteger)collectionId
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get all of the images for a particular collection by collection id.
 *
 *  @param collectionId the collection ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForCollection:(NSInteger)collectionId
                                    complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Companies

/**
 *  This method is used to retrieve all of the basic information about a company.
 *
 *  @param companyID the company ID to get the details for
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)companyWithID:(NSInteger)companyID
                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of movies associated with a particular company.
 *
 *  @param companyID the company ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)moviesForCompany:(NSInteger)companyID
                                   inPage:(NSInteger)page
                                 complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Credits

/**
 *  Get the detailed information about a particular credit record.
 *  This is currently only supported with the new credit model found in TV.
 *  These ids can be found from any TV credit response as well as the tv_credits
 *  and combined_credits methods for people.The episodes object returns a
 *  list of episodes and are generally going to be guest stars. The season 
 *  array will return a list of season numbers. Season credits are credits
 *  that were marked with the "add to every season" option in the editing
 *  interface and are assumed to be "season regulars".
 *
 *  @param personId the ID of the person to search for
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */

-(NSURLSessionDataTask *)creditWithId:(NSString*)creditID
                             complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Discover

/**
 *  Discover movies by different types of data like average rating,
 *  number of votes, genres and certifications. You can get a valid
 *  list of certifications from the /certifications method.
 *
 *  @param filter     the filter to use when fetching movies
 *  @param pageNumber the page number to get
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)discoverMoviesWithCriteria:(KMMMovieCriteria *)criteria
                                            inPage:(NSInteger)pageNumber
                                          complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Discover TV shows by different types of data like average rating, 
 *  number of votes, genres, the network they aired on and air dates.
 *
 *  @param filter     the filter to use when fetching movies
 *  @param pageNumber the page number to get
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)discoverTVWithCriteria:(KMMTVCriteria *)criteria
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Find

/**
 *  The find method makes it easy to search for objects in our database by an
 *  external id. For instance, an IMDB ID. This will search all objects
 *  (movies, TV shows and people) and return the results in a single response.
 *  TV season and TV episode searches will be supported shortly.
 
 *  The supported external sources for each object are as follows:
 *    - Movies: imdb_id
 *    - People: imdb_id, freebase_mid, freebase_id, tvrage_id
 *    - TV Series: imdb_id, freebase_mid, freebase_id, tvdb_id, tvrage_id
 *    - TV Seasons: freebase_mid, freebase_id, tvdb_id, tvrage_id
 *    - TV Episodes: imdb_id, freebase_mid, freebase_id, tvdb_id, tvrage_id
 *
 *  @param source   the external source to query
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)findResource:(NSString*)resourceId
                     inExternalSource:(TMDBExternalSource)source
                             complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Genres


/**
 *  Get the list of movie genres.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)allMovieGenresWithBlock:(KMMNetworkingCompletionBlock)complete;


/**
 *  Get the list of TV genres
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)allTVGenresWithBlock:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of movies for a particular genre by id. 
 *  By default, only movies with 10 or more votes are included.
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

#pragma mark -- Jobs

/**
 *  Get a list of valid jobs.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)allJobsWithBlock:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Keywords

/**
 *  Get the basic information for a specific keyword id.
 *
 *  @param keywordId the keyword ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)keywordWithId:(NSInteger)keywordId
                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of movies for a particular keyword by id.
 *
 *  @param keywordId  the keyword ID
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)moviesWithKeywordId:(NSInteger)keywordId
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- Lists


/**
 *  Get a list by id.
 *
 *  @param listId   the list ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)listWithId:(NSString*)listId
                           complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Check to see if a movie ID is already added to a list.
 *
 *  @param movieId  the movie ID
 *  @param listId   the list ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)checkMovie:(NSInteger)movieId
                           isInList:(NSInteger)listId
                           complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Movies


/**
 *  Get the basic movie information for a specific movie id.
 *
 *  @param movieID  the movie ID to get the details for
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)movieWithId:(NSInteger)movieID
                            complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Get the alternative titles for a specific movie id.
 *
 *  @param movieId   the movie ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)alternativeTitlesForMovie:(NSInteger)movieId
                                         inCountry:(NSString*)countryCode
                                          complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the cast and crew information for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)creditsForMovie:(NSInteger)movieID
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images (posters and backdrops) for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForMovie:(NSInteger)movieID
                               complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the plot keywords for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)keywordsForMovie:(NSInteger)movieID
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the release date and certification information by country for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)releasesForMovie:(NSInteger)movieID
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the videos (trailers, teasers, clips, etc...) for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)videosForMovie:(NSInteger)movieID
                               complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the translations for a specific movie id.
 *
 *  @param movieID  the movie ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)translationsForMovie:(NSInteger)movieID
                                     complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the similar movies for a specific movie id.
 *
 *  @param movieID    the movie ID
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)similarMoviesForMovie:(NSInteger)movieID
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the reviews for a particular movie id.
 *
 *  @param movieID    the movie ID
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)reviewsForMovie:(NSInteger)movieID
                                  inPage:(NSInteger)pageNumber
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the lists that the movie belongs to.
 *
 *  @param movieID    the movie ID
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)listsForMovie:(NSInteger)movieID
                                inPage:(NSInteger)pageNumber
                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the changes for a specific movie id.
 *  Changes are grouped by key, and ordered by date in descending order. 
 *  By default, only the last 24 hours of changes are returned. 
 *  The maximum number of days that can be returned in a single request is 14. 
 *  The language is present on fields that are translatable.
 *
 *  @param movieID  the movie ID
 *  @param from     the start date to start getting changes
 *  @param to       the end date to start getting changes
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)changesForMovie:(NSInteger)movieID
                                    from:(NSDate*)from
                                      to:(NSDate*)to
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the latest movie id.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestMovieWithBlock:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of upcoming movies by release date. This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)upcomingMoviesInPage:(NSInteger)pageNumber
                                     complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of movies playing that have been, or are being released this week.
 * This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)nowPlayingMoviesInPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of popular movies on The Movie Database. This list refreshes every day.
 *
 *  @param pageNumber the page number to get
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)popularMoviesInPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;



/**
 *  Get the list of top rated movies. 
 *  By default, this list will only include movies that have 10 or more votes. 
 *  This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)topRatedMoviesInPage:(NSInteger)pageNumber
                                     complete:(KMMNetworkingCompletionBlock)complete;



#pragma mark -- Networks

/**
 *  This method is used to retrieve the basic information about a TV network.
 *  You can use this ID to search for TV shows with the discover. 
 *  At this time we don't have much but this will be fleshed out over time.
 *
 *  @param networkId the network ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)TVNetworkWithId:(NSInteger)networkId
                                complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- People


/**
 *  Get the general person information for a specific id.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)personWithId:(NSInteger)personID
                             complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the movie credits for a specific person id.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */

-(NSURLSessionDataTask *)movieCreditsForPerson:(NSInteger)personId
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the TV credits for a specific person id.To get the expanded details
 *  for each record, call the /credit method with the provided credit_id.
 *  This will provide details about which episode and/or season the credit is for.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)TVCreditsForPerson:(NSInteger)personID
                                   complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the combined (movie and TV) credits for a specific person id.
 *  To get the expanded details for each TV record, call the /credit
 *  method with the provided credit_id. This will provide details about 
 *  which episode and/or season the credit is for.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)combinedCreditsForPerson:(NSInteger)personID
                                         complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the external ids for a specific person id.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)externalIdsForPerson:(NSInteger)personID
                                     complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images for a specific person id.
 *
 *  @param personID the person ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForPerson:(NSInteger)personID
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images that have been tagged with a specific person id.
 *  We return all of the image results with a media object mapped for each image.
 *
 *  @param personID   the person ID
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)taggedImagesForPerson:(NSInteger)personID
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the changes for a specific person id.
 *  Changes are grouped by key, and ordered by date in descending order.
 *  By default, only the last 24 hours of changes are returned. 
 *  The maximum number of days that can be returned in a single request is 14.
 *  The language is present on fields that are translatable.
 *
 *  @param personID the person ID
 *  @param from     the start date to start getting changes
 *  @param to       the end date to finish getting changes
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)changesForPerson:(NSInteger)personID
                                     from:(NSDate*)from
                                       to:(NSDate*)to
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of popular people on The Movie Database. This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)popularPeopleInPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the latest person id.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestPersonWithBlock:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Reviews

/**
 *  Get the full details of a review by ID.
 *
 *  @param reviewId the review ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)reviewWithId:(NSInteger)reviewId
                             complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Search

/**
 *  Search for people by name.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchPeopleForTerm:(NSString*)searchTerm
                                      inPage:(NSInteger)pageNumber
                                    withType:(TMDBSearchType)type
                                    complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Search for movies by title.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchMoviesForTerm:(NSString*)searchTerm
                                 releaseYear:(NSInteger)releaseYear
                                    withType:(TMDBSearchType)type
                                      inPage:(NSInteger)pageNumber
                                    complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Search the movie, tv show and person collections with a single query.
 *  Each item returned in the result array has a media_type field that maps to either movie,
 *  tv or person.Each mapped result is the same response you would get from each independent search.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchForTerm:(NSString*)searchTerm
                                inPage:(NSInteger)pageNumber
                              complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Search for companies by name.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchCompaniesForTerm:(NSString*)searchTerm
                                         inPage:(NSInteger)pageNumber
                                       complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Search for collections by name.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchCollectionForTerm:(NSString*)searchTerm
                                          inPage:(NSInteger)pageNumber
                                        complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Search for keywords by name.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchKeywordsForTerm:(NSString*)searchTerm
                                        inPage:(NSInteger)pageNumber
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Search for lists by name and description.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchListsForTerm:(NSString*)searchTerm
                                     inPage:(NSInteger)pageNumber
                                   complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Search for TV shows by title.
 *
 *  @param searchTerm the term to search for
 *  @param pageNumber the page number to fetch
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)searchTVForTerm:(NSString*)searchTerm
                                  inPage:(NSInteger)pageNumber
                          firstAiredYear:(NSInteger)firstAiredYear
                              searchType:(TMDBSearchType)searchType
                                complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Timezones


/**
 *  Get the list of supported timezones for the API methods that support them.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)timezonesWithBlock:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- TV

/**
 *  Get the primary information about a TV series by id.
 *
 *  @param seriesId the series ID
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)TVSeriesWithId:(NSInteger)seriesId
                               complete:(KMMNetworkingCompletionBlock)complete;


/**
 *  Get the alternative titles for a specific show ID.
 *
 *  @param seriesId  the series ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)alternativeTitlesForTVSeries:(NSInteger)seriesId
                                            inCountry:(NSString*)countryCode
                                             complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the changes for a specific TV show id.Changes are grouped by key, and ordered
 *  by date in descending order. By default, only the last 24 hours of changes are returned.
 *  The maximum number of days that can be returned in a single request is 14. 
 *  The language is present on fields that are translatable.TV changes are different 
 *  than movie changes in that there are some edits on seasons and episodes that will 
 *  create a change entry at the show level. They can be found under the season and 
 *  episode keys. These keys will contain a series_id and episode_id. You can use 
 *  the /tv/season/{id}/changes and /tv/episode/{id}/changes methods to look up these specific changes.
 *
 *  @param seriesId the series ID
 *  @param from     the start date to start getting changes
 *  @param to       the end date to finish getting changes
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)changesForTVSeries:(NSInteger)seriesId
                                          from:(NSDate*)from
                                            to:(NSDate*)to
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the content ratings for a specific TV show id.
 *
 *  @param seriesId  the series ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)contentRatingsForTVSeries:(NSInteger)seriesId
                                          complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the cast & crew information about a TV series.
 *  Just like the website, we pull this information from the last season of the series.
 *
 *  @param seriesId  the series ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)creditsForTVSeries:(NSInteger)seriesId
                                   complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the external ids that we have stored for a TV series.
 *
 *  @param seriesId  the series ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)externalIdsForTVSeries:(NSInteger)seriesId
                                       complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images (posters and backdrops) for a TV series.
 *
 *  @param seriesId  the series ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the plot keywords for a specific TV show id.
 *
 *  @param seriesId  the series ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)keywordsForTVSeries:(NSInteger)seriesId
                                    complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the similar TV shows for a specific tv id.
 *
 *  @param seriesId  the series ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)similarSeriesForTVSeries:(NSInteger)seriesId
                                           inPage:(NSInteger)pageNumber
                                         complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of translations that exist for a TV series.
 *  These translations cascade down to the episode level.
 *
 *  @param seriesId  the series ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)translationsForTVSeries:(NSInteger)seriesId
                                        complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the videos that have been added to a TV series (trailers, opening credits, etc...)
 *
 *  @param seriesId  the series ID
 *  @param countryId the country ID
 *  @param complete  the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)videosForTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the latest TV show id.
 *
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)latestTVSeriesWithBlock:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of TV shows that are currently on the air. 
 *  This query looks for any TV show that has an episode with an air date in the next 7 days.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)currentlyAiringTVSeriesInPage:(NSInteger)pageNumber
                                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of TV shows that air today. Without a specified timezone,
 *  this query defaults to EST (Eastern Time UTC-05:00).
 *
 *  @param timezone   the timezone
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)TVSeriesAiringTodayInTimezone:(KMMTimezone*)timezone
                                                inPage:(NSInteger)pageNumber
                                              complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of top rated TV shows. By default, 
 *  this list will only include TV shows that have 2 or more votes.
 *  This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)topRatedTVSeriesInPage:(NSInteger)pageNumber
                                          complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the list of popular TV shows. This list refreshes every day.
 *
 *  @param pageNumber the page number to fetch -- first page is 1
 *  @param complete   the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)popularTVSeriesInPage:(NSInteger)pageNumber
                                         complete:(KMMNetworkingCompletionBlock)complete;


#pragma mark -- TV Seasons

/**
 *  Get the primary information about a TV season by its season number.
 *
 *  @param seasonNumber the season number
 *  @param seriesId     the series ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)seasonNumber:(NSInteger)seasonNumber
                          forTVSeries:(NSInteger)seriesId
                             complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Look up a TV season's changes by season ID.
 *  This method is used in conjunction with the /tv/{id}/changes method. 
 *  This method uses the season_id value found in the change entries.
 *
 *  @param seasonId the season ID
 *  @param from     the start date to get changes from
 *  @param to       the end date to get changes until
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)changesForSeason:(NSInteger)seasonId
                                     from:(NSDate*)from
                                       to:(NSDate*)to
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the cast & crew credits for a TV season by season number.
 *
 *  @param seasonNumber the season number
 *  @param seriesId     the series ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)creditsForSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the external ids that we have stored for a TV season by season number.
 *
 *  @param seasonNumber the season number
 *  @param seriesId     the series ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)externalIdsForSeason:(NSInteger)seasonNumber
                                  forTVSeries:(NSInteger)seriesId
                                     complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images (posters) that we have stored for a TV season by season number.
 *
 *  @param seasonNumber the season number
 *  @param seriesId     the series ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForSeason:(NSInteger)seasonNumber
                             forTVSeries:(NSInteger)seriesId
                                complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the videos that have been added to a TV season (trailers, teasers, etc...)
 *
 *  @param seasonNumber the season number
 *  @param seriesId     the series ID
 *  @param complete     the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)videosForSeason:(NSInteger)seasonNumber
                             forTVSeries:(NSInteger)seriesId
                                complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Episodes

/**
 *  Get the primary information about a TV episode by combination of a season and episode number
 *
 *  @param episodeNumber the episode number
 *  @param seasonNumber  the season number
 *  @param seriesId      the series ID
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)episode:(NSInteger)episodeNumber
                        inSeason:(NSInteger)seasonNumber
                     forTVSeries:(NSInteger)seriesId
                        complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Look up a TV episode's changes by episode ID. 
 *  This method is used in conjunction with the /tv/{id}/changes method. This method uses the episode_id value found in the change entries.
 *
 *  @param episodeNumber the episode number
 *  @param from          the start date to get changes from
 *  @param to            the end date to get changes until
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)changesForEpisode:(NSInteger)episodeNumber
                                      from:(NSDate*)from
                                        to:(NSDate*)to
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the TV episode credits by combination of season and episode number.
 *
 *  @param episodeNumber the episode number
 *  @param seasonNumber  the season number
 *  @param seriesId      the series ID
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)creditsForEpisode:(NSInteger)episodeNumber
                                  inSeason:(NSInteger)seasonNumber
                               forTVSeries:(NSInteger)seriesId
                                  complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the external ids for a TV episode by comabination of a season and episode number.
 *
 *  @param episodeNumber the episode number
 *  @param seasonNumber  the season number
 *  @param seriesId      the series ID
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)externalIdsForEpisode:(NSInteger)episodeNumber
                                      inSeason:(NSInteger)seasonNumber
                                   forTVSeries:(NSInteger)seriesId
                                      complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the images (episode stills) for a TV episode by combination of a season and episode number.
 *  Since episode stills don't have a language, this call will always return all images.
 *
 *  @param episodeNumber the episode number
 *  @param seasonNumber  the season number
 *  @param seriesId      the series ID
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)imagesForEpisode:(NSInteger)episodeNumber
                                 inSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete;

/**
 *  Get the videos that have been added to a TV episode (teasers, clips, etc...)
 *
 *  @param episodeNumber the episode number
 *  @param seasonNumber  the season number
 *  @param seriesId      the series ID
 *  @param complete      the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(NSURLSessionDataTask *)videosForEpisode:(NSInteger)episodeNumber
                                 inSeason:(NSInteger)seasonNumber
                              forTVSeries:(NSInteger)seriesId
                                 complete:(KMMNetworkingCompletionBlock)complete;

#pragma mark -- Getting images

/**
 *  Fetches an image with the given path
 *
 *  @param path     the path to fetch the image from
 *  @param complete the block to execute when the call finishes
 *
 *  @return an NSURLSessionDataTask with the current task
 */
-(void)getImageWithPath:(NSString*)path
               complete:(void (^)(UIImage *image, NSError *error))complete;



@end
