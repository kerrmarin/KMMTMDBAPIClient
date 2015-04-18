//
//  KMMCrewSummary.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMCrewSummary : NSObject

@property(nonatomic, assign, readonly) NSInteger crewID;

@property(nonatomic, copy, readonly) NSString *department;
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *creditID;
@property(nonatomic, copy, readonly) NSString *job;
@property(nonatomic, copy, readonly) NSString *profilePath;

-(instancetype)initWithCrewID:(NSInteger)crewID
                   department:(NSString*)department
                         name:(NSString*)department
                     creditID:(NSString*)creditID
                          job:(NSString*)job
                  profilePath:(NSString*)profilePath;


@end



@interface KMMCrewSummaryParser : NSObject

-(KMMCrewSummary*)crewSummaryFromDictionary:(NSDictionary*)json;


@end
