//
//  KMMTVFilter.h
//  Pods
//
//  Created by Kerr Marin Miller on 12/01/2015.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KMMTVSeriesDiscoverSortBy) {
    KMMTVSeriesDiscoverSortByPopularityAscending,
    KMMTVSeriesDiscoverSortByPopularityDescending,
    KMMTVSeriesDiscoverSortByFirstAirDateAscending,
    KMMTVSeriesDiscoverSortByFirstAirDateDescending,
    KMMTVSeriesDiscoverSortByVoteAverageAscending,
    KMMTVSeriesDiscoverSortByVoteAverageDescending
};

NSString * NSStringFromKMMTVDiscoverSortBy(KMMTVSeriesDiscoverSortBy sortBy);

@interface KMMTVCriteria : NSObject

@property(nonatomic, assign) KMMTVSeriesDiscoverSortBy sortBy;
@property(nonatomic, assign) NSUInteger firstAirYear;
@property(nonatomic, assign) NSUInteger voteCountGTE;
@property(nonatomic, assign) NSUInteger voteCountLTE;

@property(nonatomic, copy) NSSet *genres;
@property(nonatomic, copy) NSSet *networks;

@property(nonatomic, copy) NSDate *firstAirDateGTE;
@property(nonatomic, copy) NSDate *firstAirDateLTE;

@end