//
//  KMMProductionCountry.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMProductionCountry.h"

@implementation KMMProductionCountry

-(instancetype)initWithCountryCode:(NSString *)countryCode andCountryName:(NSString *)countryName {
    
    if(self = [super init]) {
        _countryCode = [countryCode copy];
        _countryName = [countryName copy];
    }
    return self;
}

@end


@implementation KMMProductionCountryParser

-(KMMProductionCountry *)productionCountryFromDictionary:(NSDictionary *)json {
    
    NSString *countryCode = json[@"iso_3166_1"] == [NSNull null] ? nil : json[@"iso_3166_1"];
    NSString *countryName = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    
    KMMProductionCountry *productionCountry = [[KMMProductionCountry alloc] initWithCountryCode:countryCode
                                                                                 andCountryName:countryName];
    return productionCountry;
}

@end
