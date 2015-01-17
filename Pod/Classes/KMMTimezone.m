//
//  KMMTimezone.m
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

#import "KMMTimezone.h"

@implementation KMMTimezone

-(instancetype)initWithCode:(NSString *)code zones:(NSArray *)zones {
    NSParameterAssert(code);
    NSParameterAssert(zones);
    if(self = [super init]) {
        _code = [code copy];
        _zones = [zones copy];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
