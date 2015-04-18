//
//  KMMLanguage.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMLanguage.h"

@implementation KMMLanguage

-(instancetype)initWithLanguageCode:(NSString *)languageCode languageName:(NSString *)languageName {
    
    //    NSParameterAssert(languageCode);
    //    NSParameterAssert(languageName);
    
    if(self = [super init]) {
        _languageCode = [languageCode copy];
        _languageName = [languageName copy];
    }
    return self;
}

@end


@implementation KMMLanguageParser

-(KMMLanguage *)movieLanguageFromDictionary:(NSDictionary *)json {
    
    NSString *languageName = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    NSString *languageCode = json[@"iso_639_1"] == [NSNull null] ? nil : json[@"iso_639_1"];
    
    KMMLanguage *language = [[KMMLanguage alloc] initWithLanguageCode:languageCode languageName:languageName];
    return language;
}

@end
