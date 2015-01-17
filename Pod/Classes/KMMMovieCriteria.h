//
//  KMMMovieFilter.h
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

@import UIKit;

typedef NS_ENUM(NSInteger, KMMMovieDiscoverSortBy) {
    KMMMovieDiscoverSortByPopularityAscending,
    KMMMovieDiscoverSortByPopularityDescending,
    KMMMovieDiscoverSortByReleaseDateAscending,
    KMMMovieDiscoverSortByReleaseDateDescending,
    KMMMovieDiscoverSortByRevenueAscending,
    KMMMovieDiscoverSortByRevenueDescending,
    KMMMovieDiscoverSortByPrimaryReleaseDateAscending,
    KMMMovieDiscoverSortByPrimaryReleaseDateDescending,
    KMMMovieDiscoverSortByOriginalTitleAscending,
    KMMMovieDiscoverSortByOriginalTitleDescending,
    KMMMovieDiscoverSortByVoteAverageAscending,
    KMMMovieDiscoverSortByVoteAverageDescending,
    KMMMovieDiscoverSortByVoteCountAscending,
    KMMMovieDiscoverSortByVoteCountDescending
};

NSString * NSStringFromKMMMovieDiscoverSortBy(KMMMovieDiscoverSortBy sortBy);

@class KMMCountry;
@class KMMCertification;

@interface KMMMovieCriteria : NSObject

@property(nonatomic, copy) KMMCountry *certificationCountry;
@property(nonatomic, copy) KMMCertification *maximumCertification;
@property(nonatomic, copy) KMMCertification *requiredCertification;

@property(nonatomic, assign) NSUInteger primaryReleaseYear;
@property(nonatomic, copy) NSDate *primaryReleaseDateGTE;
@property(nonatomic, copy) NSDate *primaryReleaseDateLTE;

@property(nonatomic, assign) NSUInteger releaseYear;
@property(nonatomic, copy) NSDate *releaseDateGTE;
@property(nonatomic, copy) NSDate *releaseDateLTE;

@property(nonatomic, assign) NSUInteger voteCountGTE;
@property(nonatomic, assign) NSUInteger voteCountLTE;

@property(nonatomic, assign) CGFloat voteAverageGTE;
@property(nonatomic, assign) CGFloat voteAverageLTE;

@property(nonatomic, copy) NSSet *cast;
@property(nonatomic, copy) NSSet *crew;
@property(nonatomic, copy) NSSet *companies;
@property(nonatomic, copy) NSSet *genres;
@property(nonatomic, copy) NSSet *keywords;
@property(nonatomic, copy) NSSet *people;

@property(nonatomic, assign) KMMMovieDiscoverSortBy sortBy;

@end
