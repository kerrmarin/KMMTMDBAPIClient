//
//  KMMKeyword.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMKeyword : NSObject

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, assign, readonly) NSInteger keywordID;

-(instancetype)initWithKeywordID:(NSInteger)keywordID andName:(NSString*)name;

@end


@interface KMMKeywordParser : NSObject

-(KMMKeyword*)keywordFromDictionary:(NSDictionary*)json;

@end
