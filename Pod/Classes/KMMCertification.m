//
//  KMMCertification.m
//  Pods
//
//  Created by Kerr Marin Miller on 13/01/2015.
//
//

#import "KMMCertification.h"

@implementation KMMCertification

-(instancetype)initWithCode:(NSString *)code meanging:(NSString *)meaning order:(NSUInteger)order {
    NSParameterAssert(code);
    NSParameterAssert(meaning);
    if(self = [super init]) {
        _code = [code copy];
        _meaning = [meaning copy];
        _order = order;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
