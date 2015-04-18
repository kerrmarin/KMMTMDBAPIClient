//
//  KMMCrewSummary.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCrewSummary.h"

@implementation KMMCrewSummary

-(instancetype)initWithCrewID:(NSInteger)crewID
                   department:(NSString *)department
                         name:(NSString *)name
                     creditID:(NSString *)creditID
                          job:(NSString *)job
                  profilePath:(NSString *)profilePath {
    
    if(self = [super init]) {
        _crewID = crewID;
        _department = [department copy];
        _name = [name copy];
        _creditID = [creditID copy];
        _job = [job copy];
        _profilePath = [profilePath copy];
    }
    return self;
}

@end



@implementation KMMCrewSummaryParser

-(KMMCrewSummary *)crewSummaryFromDictionary:(NSDictionary *)json {
    
    NSInteger crewID = [json[@"id"] integerValue];
    NSString *department = json[@"department"] == [NSNull null] ? nil : json[@"department"];
    NSString *creditID = json[@"credit_id"] == [NSNull null] ? nil : json[@"credit_id"];
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    NSString *job = json[@"job"] == [NSNull null] ? nil : json[@"job"];
    NSString *profilePath = json[@"profile_path"] == [NSNull null] ? nil : json[@"profile_path"];
    
    KMMCrewSummary *crewSummary = [[KMMCrewSummary alloc] initWithCrewID:crewID
                                                              department:department
                                                                    name:name
                                                                creditID:creditID
                                                                     job:job
                                                             profilePath:profilePath];
    return crewSummary;
}


@end
