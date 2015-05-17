//
//  KMMLanguage.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMLanguage : NSObject

@property(nonatomic, copy, readonly) NSString *languageName;
@property(nonatomic, copy, readonly) NSString *languageCode; //iso_639_1

-(instancetype)initWithLanguageCode:(NSString*)languageCode languageName:(NSString*)languageName;

@end



@interface KMMLanguageParser : NSObject

-(KMMLanguage*)movieLanguageFromDictionary:(NSDictionary*)json;


@end
