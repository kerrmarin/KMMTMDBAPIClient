//
//  KMMCastMovieCredit.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCastMovieCredit.h"

@implementation KMMCastMovieCredit

-(instancetype)initWithOriginalTitle:(NSString *)originalTitle
                           character:(NSString *)character
                            creditID:(NSString *)creditID
                          posterPath:(NSString *)posterPath
                               title:(NSString *)title
                         releaseDate:(NSDate *)releaseDate
                       movieCreditID:(NSInteger)movieCreditID {
    
    if(self = [super init]) {
        _originalTitle = [originalTitle copy];
        _character = [character copy];
        _creditID = [creditID copy];
        _posterPath = [posterPath copy];
        _title = [title copy];
        _releaseDate = releaseDate;
        _movieCreditID = movieCreditID;
    }
    return self;
}

@end


@interface KMMCastMovieCreditParser ()

@property(nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation KMMCastMovieCreditParser

-(instancetype)init {
    if(self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

-(KMMCastMovieCredit *)creditFromDictionary:(NSDictionary *)json {
    
    NSString *originalTitle = json[@"original_title"] == [NSNull null] ? nil : json[@"original_title"];
    NSString *character = json[@"character"] == [NSNull null] ? nil : json[@"character"];
    NSString *creditID = json[@"credit_id"] == [NSNull null] ? nil : json[@"credit_id"];
    NSString *posterPath = json[@"poster_path"] == [NSNull null] ? nil : json[@"poster_path"];
    NSString *title = json[@"title"] == [NSNull null] ? nil : json[@"title"];
    
    NSString *releaseDateString = json[@"release_date"] == [NSNull null] ? nil : json[@"release_date"];
    NSDate *releaseDate = [self.dateFormatter dateFromString:releaseDateString];
    
    NSInteger movieCreditID = [json[@"id"] integerValue];
    
    KMMCastMovieCredit *castMovieCredit = [[KMMCastMovieCredit alloc] initWithOriginalTitle:originalTitle
                                                                                  character:character
                                                                                   creditID:creditID
                                                                                 posterPath:posterPath
                                                                                      title:title
                                                                                releaseDate:releaseDate
                                                                              movieCreditID:movieCreditID];
    return castMovieCredit;
}


@end
