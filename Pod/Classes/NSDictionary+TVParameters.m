//
//  NSDictionary+TVParameters.m
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

#import "NSDictionary+TVParameters.h"
#import "KMMTVCriteria.h"

@implementation NSDictionary (TVParameters)

+(NSDictionary *)dictionaryWithTVCriteria:(KMMTVCriteria *)criteria
                                 inPage:(NSInteger)pageNumber
                          dateFormatter:(NSDateFormatter *)formatter {
    NSMutableDictionary *params = [@{@"page" : @(pageNumber)} mutableCopy];
    
    if(criteria.firstAirYear) {
        params[@"first_air_date_year"] = @(criteria.firstAirYear);
    }
    
    if(criteria.voteCountGTE) {
        params[@"vote_count.gte"] = @(criteria.voteCountGTE);
    }
    
    if(criteria.voteCountLTE) {
        params[@"vote_count.lte"] = @(criteria.voteCountLTE);
    }
    
    if(criteria.genres.count > 0) {
        params[@"with_genres"] = [[criteria.genres allObjects] componentsJoinedByString:@","];
    }
    
    if(criteria.networks.count > 0) {
        params[@"with_networks"] = [[criteria.networks allObjects] componentsJoinedByString:@","];
    }
    
    if(criteria.firstAirDateGTE) {
        params[@"first_air_date.gte"] = [formatter stringFromDate:criteria.firstAirDateGTE];
    }
    
    if(criteria.firstAirDateLTE) {
        params[@"first_air_date.lte"] = [formatter stringFromDate:criteria.firstAirDateLTE];
    }
    
    params[@"sort_by"] = NSStringFromKMMTVDiscoverSortBy(criteria.sortBy);
    
    return [params copy];
}

@end
