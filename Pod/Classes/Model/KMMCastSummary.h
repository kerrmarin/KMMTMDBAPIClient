//
//  KMMCastSummary.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMCastSummary : NSObject


@property(nonatomic, assign, readonly) NSInteger movieCastID;
@property(nonatomic, assign, readonly) NSInteger castID;
@property(nonatomic, assign, readonly) NSInteger order;

@property(nonatomic, copy, readonly) NSString *character;
@property(nonatomic, copy, readonly) NSString *creditID;
@property(nonatomic, copy, readonly) NSString *profilePath;
@property(nonatomic, copy, readonly) NSString *name;

-(instancetype)initWithMovieCastID:(NSInteger)movieCastID
                            castID:(NSInteger)castID
                             order:(NSInteger)order
                         character:(NSString*)character
                          creditID:(NSString*)creditID
                       profilePath:(NSString*)profilePath
                              name:(NSString*)name;

@end


@interface KMMCastSummaryParser : NSObject

-(KMMCastSummary*)castSummaryFromDictionary:(NSDictionary*)json;


@end
