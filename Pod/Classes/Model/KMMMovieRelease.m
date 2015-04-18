//
//  KMMMovieRelease.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovieRelease.h"

@implementation KMMMovieRelease

-(instancetype)initWithReleaseDate:(NSDate *)releaseDate
                     certification:(NSString *)certification
                           country:(NSString *)country {
    
    if(self = [super init]) {
        _releaseDate = releaseDate;
        _certification = [certification copy];
        _country = [country copy];
    }
    return self;
}

@end




@interface KMMMovieReleaseParser ()

@property(nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation KMMMovieReleaseParser

-(instancetype)init {
    if(self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

-(KMMMovieRelease *)movieReleaseFromDictionary:(NSDictionary*)json {
    
    NSString *dateString = json[@"release_date"] == [NSNull null] ? nil : json[@"release_date"];
    NSDate *releaseDate = [self.dateFormatter dateFromString:dateString];
    NSString *certification = json[@"certification"] == [NSNull null] ? nil : json[@"certification"];
    NSString *country = json[@"iso_3166_1"] == [NSNull null] ? nil : json[@"iso_3166_1"];
    
    KMMMovieRelease *movieRelease = [[KMMMovieRelease alloc] initWithReleaseDate:releaseDate
                                                                   certification:certification
                                                                         country:country];
    
    return movieRelease;
}


@end
