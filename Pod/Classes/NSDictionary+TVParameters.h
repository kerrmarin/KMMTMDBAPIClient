//
//  NSDictionary+TVParameters.h
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

@import Foundation;

@class KMMTVCriteria;

@interface NSDictionary (TVParameters)

+(NSDictionary*)dictionaryWithTVCriteria:(KMMTVCriteria*)criteria
                                  inPage:(NSInteger)pageNumber
                           dateFormatter:(NSDateFormatter*)formatter;

@end
