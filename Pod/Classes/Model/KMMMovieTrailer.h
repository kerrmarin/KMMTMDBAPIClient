//
//  KMMMovieTrailer.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMMovieTrailer : NSObject

@property(nonatomic, copy, readonly) NSString *trailerID;
@property(nonatomic, copy, readonly) NSString *languageCode;
@property(nonatomic, copy, readonly) NSString *key;
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *site;
@property(nonatomic, copy, readonly) NSString *type;

@property(nonatomic, assign, readonly) NSInteger size;

-(instancetype)initWithTrailerID:(NSString*)trailerID
                    languageCode:(NSString*)languageCode
                             key:(NSString*)key
                            name:(NSString*)name
                            site:(NSString*)site
                            type:(NSString*)type
                            size:(NSInteger)size;

@end


@interface KMMMovieTrailerParser : NSObject

-(KMMMovieTrailer*)movieTrailerFromDictionary:(NSDictionary*)json;

@end
