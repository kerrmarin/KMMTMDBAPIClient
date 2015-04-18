//
//  KMMCastSearchResult.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

@interface KMMCastSearchResult : NSObject

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *profilePath;
@property(nonatomic, copy, readonly) NSArray *knownFor;

@property(nonatomic, assign, readonly) NSInteger castID;
@property(nonatomic, assign, readonly) CGFloat popularity;

@end



@interface KMMCastSearchResultParser : NSObject

-(KMMCastSearchResult*)castSearchResultFromDictionary:(NSDictionary*)json;

@end
