//
//  KMMProductionCompany.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface KMMProductionCompany : NSObject

@property(nonatomic, copy, readonly) NSString* companyName;
@property(nonatomic, assign, readonly) NSInteger companyID;

-(instancetype)initWithCompanyID:(NSInteger)companyID andCompanyName:(NSString*)companyName;

@end


@interface KMMProductionCompanyParser : NSObject

-(KMMProductionCompany*)companyFromDictionary:(NSDictionary*)json;

@end
