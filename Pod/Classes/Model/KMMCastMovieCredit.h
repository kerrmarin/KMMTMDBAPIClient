//
//  KMMCastMovieCredit.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMCastMovieCredit : NSObject

@property(nonatomic, copy, readonly) NSString *originalTitle;
@property(nonatomic, copy, readonly) NSString *character;
@property(nonatomic, copy, readonly) NSString *creditID;
@property(nonatomic, copy, readonly) NSString *posterPath;
@property(nonatomic, copy, readonly) NSString *title;

@property(nonatomic, strong, readonly) NSDate *releaseDate;

@property(nonatomic, assign, readonly) NSInteger movieCreditID;

-(instancetype)initWithOriginalTitle:(NSString*)originalTitle
                           character:(NSString*)character
                            creditID:(NSString*)creditID
                          posterPath:(NSString*)posterPath
                               title:(NSString*)title
                         releaseDate:(NSDate*)releaseDate
                       movieCreditID:(NSInteger)movieCreditID;

@end



@interface KMMCastMovieCreditParser : NSObject

-(KMMCastMovieCredit*)creditFromDictionary:(NSDictionary*)json;


@end
