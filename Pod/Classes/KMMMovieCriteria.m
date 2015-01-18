//
//  KMMMovieFilter.m
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import "KMMMovieCriteria.h"

NSString * NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortBy sortBy) {
    switch (sortBy) {
        case KMMMovieDiscoverSortByPopularityAscending:
            return @"popularity.asc";
            break;
        case KMMMovieDiscoverSortByPopularityDescending:
            return @"popularity.desc";
            break;
        case KMMMovieDiscoverSortByReleaseDateAscending:
            return @"release_date.asc";
            break;
        case KMMMovieDiscoverSortByReleaseDateDescending:
            return @"release_date.desc";
            break;
        case KMMMovieDiscoverSortByRevenueAscending:
            return @"revenue.asc";
            break;
        case KMMMovieDiscoverSortByRevenueDescending:
            return @"revenue.desc";
            break;
        case KMMMovieDiscoverSortByPrimaryReleaseDateAscending:
            return @"primary_release_date.asc";
            break;
        case KMMMovieDiscoverSortByPrimaryReleaseDateDescending:
            return @"primary_release_date.desc";
            break;
        case KMMMovieDiscoverSortByOriginalTitleAscending:
            return @"original_title.asc";
            break;
        case KMMMovieDiscoverSortByOriginalTitleDescending:
            return @"original_title.desc";
            break;
        case KMMMovieDiscoverSortByVoteAverageAscending:
            return @"vote_average.asc";
            break;
        case KMMMovieDiscoverSortByVoteAverageDescending:
            return @"vote_average.desc";
            break;
        case KMMMovieDiscoverSortByVoteCountAscending:
            return @"vote_count.asc";
            break;
        case KMMMovieDiscoverSortByVoteCountDescending:
            return @"vote_count.desc";
            break;
        default:
            return @"popularity.desc";
            break;
    }
}

KMMMovieDiscoverSortBy KMMMovieDiscoverSortByFromNString(NSString* string) {
    if([string isEqualToString:@"popularity.asc"]) return KMMMovieDiscoverSortByPopularityAscending;
    if([string isEqualToString:@"popularity.desc"]) return KMMMovieDiscoverSortByPopularityDescending;
    if([string isEqualToString:@"release_date.asc"]) return KMMMovieDiscoverSortByReleaseDateAscending;
    if([string isEqualToString:@"release_date.desc"]) return KMMMovieDiscoverSortByReleaseDateDescending;
    if([string isEqualToString:@"revenue.asc"]) return KMMMovieDiscoverSortByRevenueAscending;
    if([string isEqualToString:@"revenue.desc"]) return KMMMovieDiscoverSortByRevenueDescending;
    if([string isEqualToString:@"primary_release_date.asc"]) return KMMMovieDiscoverSortByPrimaryReleaseDateAscending;
    if([string isEqualToString:@"primary_release_date.desc"]) return KMMMovieDiscoverSortByPrimaryReleaseDateDescending;
    if([string isEqualToString:@"original_title.asc"]) return KMMMovieDiscoverSortByOriginalTitleAscending;
    if([string isEqualToString:@"original_title.desc"]) return KMMMovieDiscoverSortByOriginalTitleDescending;
    if([string isEqualToString:@"vote_average.asc"]) return KMMMovieDiscoverSortByVoteAverageAscending;
    if([string isEqualToString:@"vote_average.desc"]) return KMMMovieDiscoverSortByVoteAverageDescending;
    if([string isEqualToString:@"vote_count.asc"]) return KMMMovieDiscoverSortByVoteCountAscending;
    if([string isEqualToString:@"vote_count.desc"]) return KMMMovieDiscoverSortByVoteCountDescending;

    return KMMMovieDiscoverSortByPopularityDescending;
}



@implementation KMMMovieCriteria

-(instancetype)init {
    if (self = [super init]) {
        _sortBy = KMMMovieDiscoverSortByPopularityDescending;
        _releaseYear = NSNotFound;
    }
    return self;
}

@end