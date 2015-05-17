//
//  NSArray+Functional.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import Foundation;

@interface NSArray (Functional)

-(instancetype)kmm_map:(id(^)(id obj))block;

@end
