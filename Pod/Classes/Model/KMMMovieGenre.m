//
//  KMMMovieGenre.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovieGenre.h"

@implementation KMMMovieGenre

-(instancetype)initWithGenreID:(NSInteger)genreID
                       andName:(NSString *)name {
    if(self = [super init]) {
        _genreID = genreID;
        _name = [name copy];
    }
    return self;
}

@end


@implementation KMMMovieGenreParser

-(KMMMovieGenre *)genreFromDictionary:(NSDictionary*)json {
    if(![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSInteger genreID = [json[@"id"] integerValue];
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    
    if(![name isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    KMMMovieGenre *genre = [[KMMMovieGenre alloc] initWithGenreID:genreID andName:name];
    return genre;
}

@end
