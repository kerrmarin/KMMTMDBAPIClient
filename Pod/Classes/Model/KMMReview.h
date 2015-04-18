//
//  KMMReview.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMReview : NSObject

@property(nonatomic, copy, readonly) NSString *reviewID;
@property(nonatomic, copy, readonly) NSString *author;
@property(nonatomic, copy, readonly) NSString *content;

-(instancetype)initWithReviewID:(NSString*)reviewID author:(NSString*)author andContent:(NSString*)content;

@end



@interface KMMReviewParser : NSObject

-(KMMReview*)reviewFromDictionary:(NSDictionary*)json;

@end
