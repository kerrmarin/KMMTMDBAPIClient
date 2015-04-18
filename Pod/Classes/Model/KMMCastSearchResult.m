//
//  KMMCastSearchResult.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCastSearchResult.h"

@implementation KMMCastSearchResult

-(instancetype)initWithName:(NSString*)name
                profilePath:(NSString*)profilePath
                 popularity:(CGFloat)popularity
                     castID:(NSInteger)castID
                   knownFor:(NSArray*)knownFor {
    
    if(self = [super init]) {
        _name = [name copy];
        _profilePath = [profilePath copy];
        _popularity = popularity;
        _castID = castID;
        _knownFor = [knownFor copy];
    }
    return self;
}

@end


#import "NSArray+Functional.h"
#import "KMMMovieSummary.h"

@implementation KMMCastSearchResultParser

-(KMMCastSearchResult *)castSearchResultFromDictionary:(NSDictionary *)json {
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    NSString *profilePath = json[@"profile_path"] == [NSNull null] ? nil : json[@"profile_path"];
    
    
    NSArray *knownForArray = json[@"known_for"] == [NSNull null] ? nil : json[@"known_for"];
    KMMMovieSummaryParser *parser = [KMMMovieSummaryParser new];
    NSArray *knownFor = [knownForArray kmm_map:^id(id obj) {
        KMMMovieSummary *movie = [parser movieSummaryFromDictionary:obj];
        return movie;
    }];
    
    NSInteger castID = [json[@"id"] integerValue];
    
    NSNumber *popularityNumber = json[@"popularity"] == [NSNull null] ? nil : json[@"popularity"];
    CGFloat popularity = [popularityNumber doubleValue];
    
    KMMCastSearchResult *cast = [[KMMCastSearchResult alloc] initWithName:name
                                                              profilePath:profilePath
                                                               popularity:popularity
                                                                   castID:castID
                                                                 knownFor:knownFor];
    return cast;
}


@end
