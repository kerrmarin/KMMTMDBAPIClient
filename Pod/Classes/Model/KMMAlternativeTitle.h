//
//  KMMAlternativeTitle.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMAlternativeTitle : NSObject

@property(nonatomic, copy, readonly) NSString *languageCode; //iso_3166_1
@property(nonatomic, copy, readonly) NSString *title;

-(instancetype)initWithLanguageCode:(NSString*)languageCode andTitle:(NSString*)title;

@end



@interface KMMAlternativeTitleParser : NSObject

-(KMMAlternativeTitle*)alternativeTitleFromDictionary:(NSDictionary*)json;


@end
