//
//  KMMMovieRelease.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import <Foundation/Foundation.h>

@interface KMMMovieRelease : NSObject

@property(nonatomic, strong, readonly) NSDate *releaseDate;
@property(nonatomic, copy, readonly) NSString *certification;
@property(nonatomic, copy, readonly) NSString *country;

-(instancetype)initWithReleaseDate:(NSDate*)releaseDate certification:(NSString*)certification country:(NSString*)country;

@end


@interface KMMMovieReleaseParser : NSObject

-(KMMMovieRelease*)movieReleaseFromDictionary:(NSDictionary*)json;

@end
