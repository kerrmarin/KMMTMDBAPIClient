//
//  KMMCountry.m
//  Pods
//
//  Created by Kerr Marin Miller on 13/01/2015.
//
//

#import "KMMCountry.h"

@implementation KMMCountry

-(instancetype)initWithCountryCode:(NSString *)countryCode {
    NSParameterAssert(countryCode);
    if(self = [super init]) {
        _countryCode = [countryCode copy];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
