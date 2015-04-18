//
//  KMMCastSummary.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCastSummary.h"

@implementation KMMCastSummary

-(instancetype)initWithMovieCastID:(NSInteger)movieCastID
                            castID:(NSInteger)castID
                             order:(NSInteger)order
                         character:(NSString *)character
                          creditID:(NSString *)creditID
                       profilePath:(NSString *)profilePath
                              name:(NSString *)name {

    if(self = [super init]) {
        _movieCastID = movieCastID;
        _castID = castID;
        _order = order;
        _character = [character copy];
        _creditID = [creditID copy];
        _profilePath = [profilePath copy];
        _name = [name copy];
    }
    return self;
}

@end


@implementation KMMCastSummaryParser

-(KMMCastSummary *)castSummaryFromDictionary:(NSDictionary *)json {
    //Make sure all values are there
    
    NSInteger castID = [json[@"id"] integerValue];
    NSString *character = json[@"character"] == [NSNull null] ? nil : json[@"character"];
    NSString *creditID = json[@"credit_id"] == [NSNull null] ? nil : json[@"credit_id"];
    
    NSNumber *movieCastIDNumber = json[@"cast_id"] == [NSNull null] ? nil : json[@"cast_id"];
    NSInteger movieCastID = [movieCastIDNumber integerValue];
    
    NSString *name = json[@"name"] == [ NSNull null] ? nil: json[@"name"];
    
    NSNumber *orderNumber = json[@"order"] == [NSNull null] ? nil : json[@"order"];
    NSInteger order = [orderNumber integerValue];
    
    NSString *profilePath = json[@"profile_path"] == [NSNull null] ? nil : json[@"profile_path"];
    
    KMMCastSummary *castSummary = [[KMMCastSummary alloc] initWithMovieCastID:movieCastID
                                                                       castID:castID
                                                                        order:order
                                                                    character:character
                                                                     creditID:creditID
                                                                  profilePath:profilePath
                                                                         name:name];
    return castSummary;
    
}



@end
