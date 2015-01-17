//
//  KMMTVFilter.m
//  Pods
//
//  Created by Kerr Marin Miller on 12/01/2015.
//
//

#import "KMMTVCriteria.h"

NSString * NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortBy sortBy) {
    switch (sortBy) {
        case KMMTVSeriesDiscoverSortByPopularityAscending:
            return @"popularity.asc";
            break;
        case KMMTVSeriesDiscoverSortByPopularityDescending:
            return @"popularity.desc";
            break;
        case KMMTVSeriesDiscoverSortByFirstAirDateAscending:
            return @"first_air_date.asc";
            break;
        case KMMTVSeriesDiscoverSortByFirstAirDateDescending:
            return @"first_air_date.desc";
            break;
        case KMMTVSeriesDiscoverSortByVoteAverageAscending:
            return @"vote_average.asc";
            break;
        case KMMTVSeriesDiscoverSortByVoteAverageDescending:
            return @"vote_average.desc";
            break;
        default:
            return @"popularity.desc";
            break;
    }
}

@implementation KMMTVCriteria

-(instancetype)init {
    if(self = [super init]) {
        _sortBy = KMMTVSeriesDiscoverSortByPopularityDescending;
    }
    return self;
}

@end