//
//  KMMCertification.h
//  Pods
//
//  Created by Kerr Marin Miller on 13/01/2015.
//
//

@import Foundation;

@interface KMMCertification : NSObject <NSCopying>

@property(nonatomic, copy, readonly) NSString *code;
@property(nonatomic, copy, readonly) NSString *meaning;
@property(nonatomic, assign, readonly) NSUInteger order;

-(instancetype)initWithCode:(NSString*)code
                   meanging:(NSString*)meaning
                      order:(NSUInteger)order;

@end
