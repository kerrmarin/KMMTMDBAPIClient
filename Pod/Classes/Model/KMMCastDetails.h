//
//  KMMCastDetails.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMCastDetails : NSObject

@property (nonatomic, copy, readonly) NSArray *alsoKnownAs;

@property (nonatomic, copy, readonly) NSString *biography;

@property (nonatomic, strong, readonly) NSDate *birthday;
@property (nonatomic, strong, readonly) NSDate *deathday;

@property (nonatomic, copy, readonly) NSString *homepage;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *placeOfBirth;
@property (nonatomic, copy, readonly) NSString *profilePath;

@property(nonatomic, copy, readonly) NSArray *images;
@property(nonatomic, copy, readonly) NSArray *credits;
@property(nonatomic, copy, readonly) NSArray *taggedImages;

@property (nonatomic, assign, readonly) NSInteger castID;


-(instancetype)initWithName:(NSString*)name
                alsoKnownAs:(NSArray*)alsoKnownAs
                  biography:(NSString*)biography
                   birthday:(NSDate*)birthday
                   deathday:(NSDate*)deathday
                   homepage:(NSString*)homepage
               placeOfBirth:(NSString*)placeOfBirth
                profilePath:(NSString*)profilePath
                     images:(NSArray*)images
                    credits:(NSArray*)credits
               taggedImages:(NSArray*)taggedImages
                  andCastID:(NSInteger)castID;

@end



@interface KMMCastDetailsParser : NSObject

-(KMMCastDetails*)castDetailsFromDictionary:(NSDictionary*)json;

@end
