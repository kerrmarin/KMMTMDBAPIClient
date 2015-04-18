//
//  KMMMovie.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

@interface KMMMovie : NSObject

@property (nonatomic, assign, readonly) NSInteger tmdbID;

@property (nonatomic, copy, readonly) NSArray *genres;
@property (nonatomic, copy, readonly) NSArray *spokenLanguages;
@property (nonatomic, copy, readonly) NSArray *productionCompanies;
@property (nonatomic, copy, readonly) NSArray *productionCountries;
@property (nonatomic, copy, readonly) NSArray *trailers;
@property (nonatomic, copy, readonly) NSArray *similarMovies;
@property (nonatomic, copy, readonly) NSArray *releases;
@property (nonatomic, copy, readonly) NSArray *posters;

@property (nonatomic, strong, readonly) NSDate *releaseDate;

@property (nonatomic, copy, readonly) NSString *backdropPath;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, copy, readonly) NSString *tagline;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *homepage;
@property (nonatomic, copy, readonly) NSString *imdbID;
@property (nonatomic, copy, readonly) NSString *originalTitle;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, copy, readonly) NSString *posterPath;

@property (strong, nonatomic, readonly) NSArray *cast;
@property (strong, nonatomic, readonly) NSArray *crew;

@property (nonatomic, assign, readonly) NSInteger budget;
@property (nonatomic, assign, readonly) NSInteger revenue;
@property (nonatomic, assign, readonly) NSInteger runtime;
@property (nonatomic, assign, readonly) NSInteger voteCount;

@property (nonatomic, assign, readonly) CGFloat voteAverage;

-(instancetype)initWithID:(NSInteger)tmdbID
                   genres:(NSArray*)genres
          spokenLanguages:(NSArray*)spokenLanguages
      productionCompanies:(NSArray*)productionCompanies
      productionCountries:(NSArray*)productionCountries
                 trailers:(NSArray*)trailers
                 releases:(NSArray*)releases
                  posters:(NSArray*)posters
              releaseDate:(NSDate*)releaseDate
             backdropPath:(NSString*)backdropPath
                   status:(NSString*)status
                  tagline:(NSString*)tagline
                    title:(NSString*)title
                 homepage:(NSString*)homepage
                   imdbID:(NSString*)imdbID
            originalTitle:(NSString*)originalTitle
                 overview:(NSString*)overview
               posterPath:(NSString*)posterPath
                     cast:(NSArray*)cast
                     crew:(NSArray*)crew
            similarMovies:(NSArray*)similarMovies
                   budget:(NSInteger)budget
                  revenue:(NSInteger)revenue
                  runtime:(NSInteger)runtime
                voteCount:(NSInteger)voteCount
              voteAverage:(CGFloat)voteAverage;

@end

@interface KMMMovieParser : NSObject

-(KMMMovie*)movieFromDictionary:(NSDictionary*)json;


@end
