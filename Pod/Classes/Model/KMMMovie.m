//
//  KMMMovie.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovie.h"

@implementation KMMMovie

-(instancetype)initWithID:(NSInteger)tmdbID
                   genres:(NSArray *)genres
          spokenLanguages:(NSArray *)spokenLanguages
      productionCompanies:(NSArray *)productionCompanies
      productionCountries:(NSArray *)productionCountries
                 trailers:(NSArray *)trailers
                 releases:(NSArray *)releases
                  posters:(NSArray *)posters
              releaseDate:(NSDate *)releaseDate
             backdropPath:(NSString *)backdropPath
                   status:(NSString *)status
                  tagline:(NSString *)tagline
                    title:(NSString *)title
                 homepage:(NSString *)homepage
                   imdbID:(NSString *)imdbID
            originalTitle:(NSString *)originalTitle
                 overview:(NSString *)overview
               posterPath:(NSString *)posterPath
                     cast:(NSArray *)cast
                     crew:(NSArray *)crew
            similarMovies:(NSArray *)similarMovies
                   budget:(NSInteger)budget
                  revenue:(NSInteger)revenue
                  runtime:(NSInteger)runtime
                voteCount:(NSInteger)voteCount
              voteAverage:(CGFloat)voteAverage {
    
    if(self = [super init]) {
        _tmdbID = tmdbID;
        _genres = [genres copy];
        _spokenLanguages = [spokenLanguages copy];
        _productionCompanies = [productionCompanies copy];
        _productionCountries = [productionCountries copy];
        _trailers = [trailers copy];
        _releaseDate = releaseDate;
        _backdropPath = [backdropPath copy];
        _status = [status copy];
        _tagline = [tagline copy];
        _title = [title copy];
        _homepage = [homepage copy];
        _imdbID = [imdbID copy];
        _originalTitle = [originalTitle copy];
        _overview = [overview copy];
        _posterPath = [posterPath copy];
        _posters = [posters copy];
        _cast = [cast copy];
        _crew = [crew copy];
        _similarMovies = [similarMovies copy];
        _budget = budget;
        _revenue = revenue;
        _runtime = runtime;
        _voteCount = voteCount;
        _voteAverage = voteAverage;
        _releases = [releases copy];
    }
    return self;
}


-(BOOL)isEqual:(id)object {
    if(object == self) {
        return YES;
    }
    
    if (!object || ![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToMovie:object];
}

-(BOOL)isEqualToMovie:(KMMMovie*)movie {
    if (self == movie)
        return YES;
    if (self.tmdbID != movie.tmdbID)
        return NO;
    return YES;
}

-(NSUInteger)hash {
    return self.tmdbID;
}

@end


/*
 * Movie parsing
 */

#import "NSArray+Functional.h"
#import "KMMMovieGenre.h"
#import "KMMLanguage.h"
#import "KMMProductionCompany.h"
#import "KMMProductionCountry.h"
#import "KMMMovieTrailer.h"
#import "KMMMovieSummary.h"
#import "KMMMovieRelease.h"
#import "KMMCastSummary.h"
#import "KMMCrewSummary.h"

@interface KMMMovieParser ()

@property(nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation KMMMovieParser

-(instancetype)init {
    if(self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

-(KMMMovie*)movieFromDictionary:(NSDictionary *)json {
    NSInteger tmdbID = [json[@"id"] integerValue];
    
    NSArray *genresArray = json[@"genres"] == [NSNull null] ? nil : json[@"genres"];
    KMMMovieGenreParser *genreParser = [KMMMovieGenreParser new];
    NSArray *genres = [genresArray KMM_map:^id(id obj) {
        KMMMovieGenre *genre = [genreParser genreFromDictionary:obj];
        return genre;
    }];
    
    NSArray *spokenLanguagesArray = json[@"spoken_languages"] == [NSNull null] ? nil : json[@"spoken_languages"];
    KMMLanguageParser *languageParser = [KMMLanguageParser new];
    NSArray *spokenLanguages = [spokenLanguagesArray KMM_map:^id(id obj) {
        KMMLanguage *language = [languageParser parseMovieLanguageFromJSON:obj];
        return language;
    }];
    
    NSArray *productionCompaniesArray = json[@"production_companies"] == [NSNull null] ? nil : json[@"production_companies"];
    KMMProductionCompanyParser *productionCompaniesParser = [KMMProductionCompanyParser new];
    NSArray *productionCompanies = [productionCompaniesArray KMM_map:^id(id obj) {
        KMMProductionCompany *company = [productionCompaniesParser parseCompanyFromJSON:obj];
        return company;
    }];
    
    NSArray *productionCountriesArray = json[@"production_countries"] == [NSNull null] ? nil : json[@"production_countries"];
    KMMProductionCountryParser *productionCountriesParser = [KMMProductionCountryParser new];
    NSArray *productionCountries = [productionCountriesArray KMM_map:^id(id obj) {
        KMMProductionCountry *company = [productionCountriesParser parseProductionCountryFromJSON:obj];
        return company;
    }];
    
    NSArray *trailersArray = json[@"videos"][@"results"] == [NSNull null] ? nil : json[@"videos"][@"results"];
    KMMMovieTrailerParser *trailerParser = [KMMMovieTrailerParser new];
    NSArray *trailers = [trailersArray KMM_map:^id(id obj) {
        KMMMovieTrailer *trailer = [trailerParser parseMovieTrailerFromJSON:obj];
        return trailer;
    }];
    
    NSArray *similarMovieArray = json[@"similar"][@"results"] == [NSNull null] ? nil : json[@"similar"][@"results"];
    KMMMovieSummaryParser *summaryParser = [KMMMovieSummaryParser new];
    NSArray *similarMovies = [similarMovieArray KMM_map:^id(id obj) {
        KMMMovieSummary *summary = [summaryParser parseMovieSummaryFromJSON:obj];
        return summary;
    }];
    
    NSArray *movieReleasesArray = json[@"releases"][@"countries"] == [NSNull null] ? nil : json[@"releases"][@"countries"];
    KMMMovieReleaseParser *releaseParser = [KMMMovieReleaseParser new];
    NSArray *movieReleases = [movieReleasesArray KMM_map:^id(id obj) {
        KMMMovieRelease *movieRelease = [releaseParser parseMovieReleaseFromJSON:obj];
        return movieRelease;
    }];
    
    
    NSArray *posterPathsArray = json[@"images"][@"posters"] == [NSNull null] ? nil : json[@"images"][@"posters"];
    NSArray *posterPaths = [posterPathsArray KMM_map:^id(id obj) {
        return obj[@"file_path"];
    }];
    
    NSDate *releaseDate = [self.dateFormatter dateFromString:json[@"release_date"]];
    
    NSString *backdropPath = json[@"backdrop_path"] == [NSNull null] ? nil : json[@"backdrop_path"];
    NSString *status = json[@"status"] == [NSNull null] ? nil : json[@"status"];
    NSString *tagline = json[@"tagline"] == [NSNull null] ? nil : json[@"tagline"];
    NSString *title = json[@"title"] == [NSNull null] ? nil : json[@"title"];
    NSString *homepage = json[@"homepage"] == [NSNull null] ? nil : json[@"homepage"];
    NSString *imdbID = json[@"imdb_id"] == [NSNull null] ? nil : json[@"imdb_id"];
    NSString *originalTitle = json[@"original_title"] == [NSNull null] ? nil : json[@"original_title"];
    NSString *overview = json[@"overview"] == [NSNull null] ? nil : json[@"overview"];
    NSString *posterPath = json[@"poster_path"] == [NSNull null] ? nil : json[@"poster_path"];
    
    NSNumber *budgetNumber = json[@"budget"] == [NSNull null] ? nil : json[@"budget"];
    NSNumber *revenueNumber = json[@"revenue"] == [NSNull null] ? nil : json[@"revenue"];
    NSNumber *runtimeNumber = json[@"runtime"] == [NSNull null] ? nil : json[@"runtime"];
    NSNumber *voteCountNumber = json[@"vote_count"] == [NSNull null] ? nil : json[@"vote_count"];
    NSNumber *voteAverageNumber = json[@"vote_average"] == [NSNull null] ? nil : json[@"vote_average"];
    
    NSInteger budget = [budgetNumber integerValue];
    NSInteger revenue = [revenueNumber integerValue];
    NSInteger runtime = [runtimeNumber integerValue];
    NSInteger voteCount = [voteCountNumber integerValue];
    
    CGFloat voteAverage = [voteAverageNumber floatValue];
    
    NSArray *castArray = json[@"credits"][@"cast"] == [NSNull null] ? nil : json[@"credits"][@"cast"];
    KMMCastSummaryParser *castSummaryParser = [KMMCastSummaryParser new];
    NSArray *cast = [castArray KMM_map:^id(id obj) {
        KMMCastSummary *castSummary = [castSummaryParser parseCastSummaryFromJSON:obj];
        return castSummary;
    }];
    
    NSArray *crewArray = json[@"credits"][@"crew"] == [NSNull null] ? nil : json[@"credits"][@"crew"];
    KMMCrewSummaryParser *crewSummaryParser = [KMMCrewSummaryParser new];
    NSArray *crew = [crewArray KMM_map:^id(id obj) {
        KMMCrewSummary *crewSummary = [crewSummaryParser parseCrewSummaryFromJSON:obj];
        return crewSummary;
    }];
    
    KMMMovie *movie = [[KMMMovie alloc] initWithID:tmdbID
                                            genres:genres
                                   spokenLanguages:spokenLanguages
                               productionCompanies:productionCompanies
                               productionCountries:productionCountries
                                          trailers:trailers
                                          releases:movieReleases
                                           posters:posterPaths
                                       releaseDate:releaseDate
                                      backdropPath:backdropPath
                                            status:status
                                           tagline:tagline
                                             title:title
                                          homepage:homepage
                                            imdbID:imdbID
                                     originalTitle:originalTitle
                                          overview:overview
                                        posterPath:posterPath
                                              cast:cast
                                              crew:crew
                                     similarMovies:similarMovies
                                            budget:budget
                                           revenue:revenue
                                           runtime:runtime
                                         voteCount:voteCount
                                       voteAverage:voteAverage];
    
    
    return movie;
}

@end
