//
//  NSDictionary+MovieParameters.h
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

@import Foundation;

@class KMMMovieCriteria;

@interface NSDictionary (MovieParameters)

+(NSDictionary*)dictionaryWithMovieCriteria:(KMMMovieCriteria*)criteria
                                     inPage:(NSInteger)pageNumber
                              dateFormatter:(NSDateFormatter*)formatter;

@end
