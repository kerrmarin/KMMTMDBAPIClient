//
//  KMMProductionCompany.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMProductionCompany.h"

@implementation KMMProductionCompany

-(instancetype)initWithCompanyID:(NSInteger)companyID andCompanyName:(NSString *)companyName {
    
    //    NSParameterAssert(companyID);
    //    NSParameterAssert(companyName);
    
    if(self = [super init]) {
        _companyID = companyID;
        _companyName = [companyName copy];
    }
    return self;
}

@end


@implementation KMMProductionCompanyParser

-(KMMProductionCompany *)companyFromDictionary:(NSDictionary *)json {
    
    NSInteger companyID = [json[@"id"] integerValue];
    NSString *companyName = json[@"name"] == [NSNull null] ? nil : json[@"name"];
    
    KMMProductionCompany *productionCompany = [[KMMProductionCompany alloc] initWithCompanyID:companyID
                                                                               andCompanyName:companyName];
    return productionCompany;
    
}


@end
