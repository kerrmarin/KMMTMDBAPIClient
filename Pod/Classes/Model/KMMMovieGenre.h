//
//  KMMMovieGenre.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMMovieGenre : NSObject

@property(nonatomic, assign, readonly) NSInteger genreID;
@property(nonatomic, copy, readonly) NSString *name;

-(instancetype)initWithGenreID:(NSInteger)genreID andName:(NSString*)name;

@end


@interface KMMMovieGenreParser : NSObject

-(KMMMovieGenre*)genreFromDictionary:(NSDictionary*)json;

@end
