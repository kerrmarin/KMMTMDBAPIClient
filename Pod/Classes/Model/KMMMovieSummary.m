//
//  KMMMovieSummary.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovieSummary.h"

@implementation KMMMovieSummary

-(instancetype)initWithTitle:(NSString *)title
               originalTitle:(NSString *)originalTitle
                backdropPath:(NSString *)backdropPath
                 releaseDate:(NSDate *)releaseDate
                  posterPath:(NSString *)posterPath
              movieSummaryID:(NSInteger)movieSummaryID
                   voteCount:(NSInteger)voteCount
                  popularity:(CGFloat)popularity
                 voteAverage:(CGFloat)voteAverage {
    
    if(self = [super init]) {
        _title = [title copy];
        _originalTitle = [originalTitle copy];
        _backdropPath = [backdropPath copy];
        _posterPath = [posterPath copy];
        _releaseDate = releaseDate;
        _movieSummaryID = movieSummaryID;
        _voteCount = voteCount;
        _popularity = popularity;
        _voteAverage = voteAverage;
    }
    return self;
}

-(instancetype)copyWithZone:(NSZone *)zone {
    return self;
}


@end


@interface KMMMovieSummaryParser ()

@property(nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation KMMMovieSummaryParser

-(instancetype)init {
    if(self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

-(KMMMovieSummary *)movieSummaryFromDictionary:(NSDictionary *)json {
    
    NSString *title = json[@"title"];
    NSString *originalTitle = json[@"original_title"];
    NSString *backdropPath = json[@"backdrop_path"] == [NSNull null] ? nil : json[@"backdrop_path"];
    NSString *posterPath = json[@"poster_path"] == [NSNull null] ? nil : json[@"poster_path"];
    NSString *dateString = json[@"release_date"] == [NSNull null] ? nil : json[@"release_date"];
    NSDate *releaseDate = [self.dateFormatter dateFromString:dateString];
    
    NSNumber *movieSummaryNumber = json[@"id"] == [NSNull null] ? nil : json[@"id"];
    NSNumber *voteCountNumber = json[@"vote_count"] == [NSNull null] ? nil : json[@"vote_count"];
    NSNumber *popularityNumber = json[@"popularity"] == [NSNull null] ? nil : json[@"popularity"];
    NSNumber *voteAverageNumber = json[@"vote_average"] == [NSNull null] ? nil : json[@"vote_average"];
    
    NSInteger movieSummaryID = [movieSummaryNumber integerValue];
    NSInteger voteCount = [voteCountNumber integerValue];
    
    CGFloat popularity = [popularityNumber floatValue];
    CGFloat voteAverage = [voteAverageNumber floatValue];
    
    KMMMovieSummary *movieSummary = [[KMMMovieSummary alloc] initWithTitle:title
                                                             originalTitle:originalTitle
                                                              backdropPath:backdropPath
                                                               releaseDate:releaseDate
                                                                posterPath:posterPath
                                                            movieSummaryID:movieSummaryID
                                                                 voteCount:voteCount
                                                                popularity:popularity
                                                               voteAverage:voteAverage];
    return movieSummary;
}


@end
