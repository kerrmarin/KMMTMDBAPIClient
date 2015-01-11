//
//  KMMMovieFilter.m
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import "KMMMovieFilter.h"

@implementation KMMMovieFilter

NSString* NSStringFromKMMFilterSortBy(KMMFilterSortBy sortBy) {
    switch (sortBy) {
        case KMMFilterSortByPopular:
            return @"popularity.desc";
            break;
        case KMMFilterSortByTopRated:
            return @"vote_average.desc";
            break;
        case KMMFilterSortByReleaseDate:
            return @"release_date.desc";
            break;
        default:
            break;
    }
}

-(id)init {
    if (self = [super init])  {
        _yearRange = NSMakeRange(NSNotFound, NSNotFound);
        _genreId = NSNotFound;
        _sortBy = KMMFilterSortByPopular;
    }
    return self;
}


@end
