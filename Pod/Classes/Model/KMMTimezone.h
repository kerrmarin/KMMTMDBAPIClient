//
//  KMMTimezone.h
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

@import Foundation;

@interface KMMTimezone : NSObject <NSCopying>

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSArray *zones;

-(instancetype)initWithCode:(NSString*)code zones:(NSArray*)zones;

@end
