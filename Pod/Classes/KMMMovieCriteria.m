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


@implementation KMMMovieCriteria

-(instancetype)init {
    if (self = [super init]) {
        _sortBy = KMMMovieDiscoverSortByPopularityDescending;
        _releaseYear = NSNotFound;
    }
    return self;
}

@end
