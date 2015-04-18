//
//  KMMProductionCountry.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import <Foundation/Foundation.h>

@interface KMMProductionCountry : NSObject

@property(nonatomic, copy, readonly) NSString *countryName;
@property(nonatomic, copy, readonly) NSString *countryCode; //iso_3166_1

-(instancetype)initWithCountryCode:(NSString*)countryCode andCountryName:(NSString*)countryName;

@end


@interface KMMProductionCountryParser : NSObject

-(KMMProductionCountry*)productionCountryFromDictionary:(NSDictionary*)json;

@end
