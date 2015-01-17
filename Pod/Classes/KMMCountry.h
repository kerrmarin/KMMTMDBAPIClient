//
//  KMMCountry.h
//  Pods
//
//  Created by Kerr Marin Miller on 13/01/2015.
//
//

#import <Foundation/Foundation.h>

@interface KMMCountry : NSObject <NSCopying>

@property(nonatomic, copy, readonly) NSString *countryCode;

-(instancetype)initWithCountryCode:(NSString*)countryCode;

@end
