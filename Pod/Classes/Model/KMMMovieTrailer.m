//
//  KMMMovieTrailer.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovieTrailer.h"

@implementation KMMMovieTrailer

-(instancetype)initWithTrailerID:(NSString *)trailerID
                    languageCode:(NSString *)languageCode
                             key:(NSString *)key
                            name:(NSString *)name
                            site:(NSString *)site
                            type:(NSString *)type
                            size:(NSInteger)size {
    
    if(self = [super init]) {
        _trailerID = [trailerID copy];
        _languageCode = [languageCode copy];
        _key = [key copy];
        _name = [name copy];
        _site = [site copy];
        _type = [type copy];
        _size = size;
    }
    return self;
}

@end



@implementation KMMMovieTrailerParser

-(KMMMovieTrailer *)movieTrailerFromDictionary:(NSDictionary*)json {
    if(![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSString *trailerID = json[@"id"];
    NSString *languageCode = json[@"iso_639_1"] == [NSNull null] ? nil : json[@"iso_639_1"];
    NSString *key = json[@"key"] == [NSNull null] ? nil : json[@"key"];
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    NSString *site = json[@"site"] == [NSNull null] ? nil : json[@"site"];
    NSString *type = json[@"type"] == [NSNull null] ? nil : json[@"type"];
    
    NSNumber *sizeNumber = json[@"size"] == [NSNull null] ? nil : json[@"size"];
    NSInteger size = [sizeNumber integerValue];
    
    KMMMovieTrailer *movieTrailer = [[KMMMovieTrailer alloc] initWithTrailerID:trailerID
                                                                  languageCode:languageCode
                                                                           key:key
                                                                          name:name
                                                                          site:site
                                                                          type:type
                                                                          size:size];
    return movieTrailer;
}


@end
