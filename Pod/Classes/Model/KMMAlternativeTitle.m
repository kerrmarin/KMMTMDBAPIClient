//
//  KMMAlternativeTitle.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMAlternativeTitle.h"

@implementation KMMAlternativeTitle

-(instancetype)initWithLanguageCode:(NSString *)languageCode andTitle:(NSString *)title {
    
    if(self = [super init]) {
        _languageCode = [languageCode copy];
        _title = [title copy];
    }
    return self;
}

@end


@implementation KMMAlternativeTitleParser

-(KMMAlternativeTitle *)alternativeTitleFromDictionary:(NSDictionary*)json {
    
    NSString *languageCode = json[@"iso_3166_1"] == [NSNull null] ? nil : json[@"iso_639_1"];
    NSString *title = json[@"title"] == [NSNull null] ? nil : json[@"title"];
    
    KMMAlternativeTitle *alternativeTitle = [[KMMAlternativeTitle alloc] initWithLanguageCode:languageCode andTitle:title];
    return alternativeTitle;
}


@end
