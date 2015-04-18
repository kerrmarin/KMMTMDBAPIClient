//
//  KMMCastDetails.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCastDetails.h"

@implementation KMMCastDetails

-(instancetype)initWithName:(NSString *)name
                alsoKnownAs:(NSArray *)alsoKnownAs
                  biography:(NSString *)biography
                   birthday:(NSDate *)birthday
                   deathday:(NSDate *)deathday
                   homepage:(NSString *)homepage
               placeOfBirth:(NSString *)placeOfBirth
                profilePath:(NSString *)profilePath
                     images:(NSArray *)images
                    credits:(NSArray *)credits
               taggedImages:(NSArray *)taggedImages
                  andCastID:(NSInteger)castID {
    
    if(self = [super init]) {
        _name = [name copy];
        _alsoKnownAs = [alsoKnownAs copy];
        _biography = [biography copy];
        _birthday = birthday;
        _deathday = deathday;
        _homepage = [homepage copy];
        _placeOfBirth = [placeOfBirth copy];
        _profilePath = [profilePath copy];
        _images = [images copy];
        _credits = [credits copy];
        _taggedImages = [taggedImages copy];
        _castID = castID;
    }
    return self;
}


-(BOOL)isEqual:(id)object {
    if(object == self) {
        return YES;
    }
    if (!object || ![object isKindOfClass:[self class]])
        return NO;
    return [self isEqualToCast:object];
}

-(BOOL)isEqualToCast:(KMMCastDetails*)cast {
    if (self == cast)
        return YES;
    if (self.castID != cast.castID)
        return NO;
    return YES;
}

-(NSUInteger)hash {
    return self.castID;
}


@end



#import "NSArray+Functional.h"
#import "KMMImageDescriptor.h"
#import "KMMCastMovieCredit.h"
#import "KMMCastTaggedImage.h"
//#import "NSString+HTML.h"

@interface KMMCastDetailsParser ()

@property(nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end

@implementation KMMCastDetailsParser

-(instancetype)init {
    if(self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}


-(KMMCastDetails *)castDetailsFromDictionary:(NSDictionary *)json {
    NSArray *alsoKnownAs = json[@"also_known_as"] == [NSNull null] ? nil : json[@"also_known_as"];
    NSString *biography = json[@"biography"] == [NSNull null] ? nil : json[@"biography"];
    
    NSString *dateString = json[@"birthday"] == [NSNull null] ? nil : json[@"birthday"];
    NSDate *birthday = [self.dateFormatter dateFromString:dateString];
    
    NSString *deathdayString = json[@"deathday"] == [NSNull null] ? nil : json[@"deathday"];
    NSDate *deathday = [self.dateFormatter dateFromString:deathdayString];
    
    NSString *homepage = json[@"homepage"] == [NSNull null] ? nil : json[@"homepage"];
    NSString *name = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    NSString *placeOfBirthString = json[@"place_of_birth"] == [NSNull null] ? nil : json[@"place_of_birth"];
    NSString *placeOfBirth = [placeOfBirthString stringByReplacingOccurrencesOfString:@" - " withString:@", "];
    NSString *profilePath = json[@"profile_path"] == [NSNull null] ? nil : json[@"profile_path"];
    
    
    NSArray *imagesArray = json[@"images"][@"profiles"] == [NSNull null] ? nil : json[@"images"][@"profiles"];
    KMMImageDescriptorParser *castImageDescriptorParser = [KMMImageDescriptorParser new];
    NSArray *images = [imagesArray kmm_map:^id(id obj) {
        KMMImageDescriptor *descriptor = [castImageDescriptorParser imageDescriptorFromDictionary:obj];
        return descriptor;
    }];
    
    NSArray *creditsArray = json[@"combined_credits"][@"cast"] == [NSNull null] ? nil : json[@"combined_credits"][@"cast"];
    KMMCastMovieCreditParser *castMovieCreditParser = [KMMCastMovieCreditParser new];
    
    NSPredicate *movieFilter = [NSPredicate predicateWithBlock:^BOOL(id castJson, NSDictionary *bindings) {
        return [castJson[@"media_type"] isEqualToString:@"movie"];
    }];
    
    NSArray *filteredCredits = [creditsArray filteredArrayUsingPredicate:movieFilter];
    
    NSArray *credits = [filteredCredits kmm_map:^id(id obj) {
        KMMCastMovieCredit *movieCredit = [castMovieCreditParser creditFromDictionary:obj];
        return movieCredit;
    }];
    
    
    NSArray *taggedImagesArray = json[@"tagged_images"][@"results"] == [NSNull null] ? nil : json[@"tagged_images"][@"results"];
    KMMCastTaggedImageParser *castTaggedImageParser = [KMMCastTaggedImageParser new];
    NSArray *taggedImages = [taggedImagesArray kmm_map:^id(id obj) {
        KMMCastTaggedImage *taggedImage = [castTaggedImageParser castTaggedImageFromDictionary:obj];
        return taggedImage;
    }];
    
    NSInteger castID = [json[@"id"] integerValue];
    
    KMMCastDetails *castDetails = [[KMMCastDetails alloc] initWithName:name
                                                           alsoKnownAs:alsoKnownAs
                                                             biography:biography
                                                              birthday:birthday
                                                              deathday:deathday
                                                              homepage:homepage
                                                          placeOfBirth:placeOfBirth
                                                           profilePath:profilePath
                                                                images:images
                                                               credits:credits
                                                          taggedImages:taggedImages
                                                             andCastID:castID];
    return castDetails;
}

@end
