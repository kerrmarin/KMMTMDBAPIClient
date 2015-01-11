//
//  KMMMovieFilter.h
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KMMFilterSortBy) {
    KMMFilterSortByPopular,
    KMMFilterSortByTopRated,
    KMMFilterSortByReleaseDate
};

NSString* NSStringFromKMMFilterSortBy(KMMFilterSortBy sortBy);

@interface KMMMovieFilter : NSObject

@property(nonatomic, assign) NSRange yearRange;
@property(nonatomic, assign) KMMFilterSortBy sortBy;
@property(nonatomic, copy) NSArray *genres;

@end
