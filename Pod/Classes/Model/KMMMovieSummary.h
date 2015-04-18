//
//  KMMMovieSummary.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

@interface KMMMovieSummary : NSObject <NSCopying>

@property(nonatomic, copy, readonly) NSString *backdropPath;
@property(nonatomic, copy, readonly) NSString *originalTitle;
@property(nonatomic, strong, readonly) NSDate *releaseDate;
@property(nonatomic, copy, readonly) NSString *posterPath;
@property(nonatomic, copy, readonly) NSString *title;

@property(nonatomic, assign, readonly) NSInteger movieSummaryID;
@property(nonatomic, assign, readonly) NSInteger voteCount;

@property(nonatomic, assign, readonly) CGFloat popularity;
@property(nonatomic, assign, readonly) CGFloat voteAverage;

-(instancetype) initWithTitle:(NSString*)title
                originalTitle:(NSString*)originalTitle
                 backdropPath:(NSString*)backdropPath
                  releaseDate:(NSDate*)releaseDate
                   posterPath:(NSString*)posterPath
               movieSummaryID:(NSInteger)movieSummaryID
                    voteCount:(NSInteger)voteCount
                   popularity:(CGFloat)popularity
                  voteAverage:(CGFloat)voteAverage;

@end

@interface KMMMovieSummaryParser : NSObject

-(KMMMovieSummary*)movieSummaryFromDictionary:(NSDictionary*)json;

@end
