//
//  NSDictionary+MovieParameters.m
//  Pods
//
//  Created by Kerr Marin Miller on 17/01/2015.
//
//

#import "NSDictionary+MovieParameters.h"

#import "KMMMovieCriteria.h"

#import "KMMCertification.h"
#import "KMMCountry.h"

@implementation NSDictionary (MovieParameters)

+(NSDictionary*)dictionaryWithMovieCriteria:(KMMMovieCriteria*)criteria
                                inPage:(NSInteger)pageNumber
                         dateFormatter:(NSDateFormatter*)formatter {
    NSMutableDictionary *params = [@{@"page" : @(pageNumber)} mutableCopy];
    
    //Set the certification limits
    if(criteria.certificationCountry) {
        params[@"certification_country"] = criteria.certificationCountry.countryCode;
        if(criteria.maximumCertification) {
            params[@"certification.lte"] = criteria.maximumCertification.code;
        }
        if(criteria.requiredCertification.code) {
            [params removeObjectForKey:@"certification.lte"];
            params[@"certification"] = criteria.requiredCertification.code;
        }
        if(!criteria.requiredCertification.code && !criteria.maximumCertification) {
            [params removeObjectForKey:@"certification_country"];
        }
    }
    
    if(criteria.releaseYear != NSNotFound) {
        params[@"year"] = @(criteria.releaseYear);
    }
    if(criteria.releaseDateGTE) {
        params[@"release_date.gte"] = [formatter stringFromDate:criteria.releaseDateGTE];
    }
    if(criteria.releaseDateLTE) {
        params[@"release_date.lte"] = [formatter stringFromDate:criteria.releaseDateLTE];
    }
    
    if(criteria.primaryReleaseYear) {
        params[@"primary_release_year"] = @(criteria.primaryReleaseYear);
    }
    if(criteria.primaryReleaseDateGTE) {
        params[@"primary_release_date.gte"] = [formatter stringFromDate:criteria.primaryReleaseDateGTE];
    }
    if(criteria.primaryReleaseDateLTE) {
        params[@"primary_release_date.lte"] = [formatter stringFromDate:criteria.primaryReleaseDateLTE];
    }

    params[@"sort_by"] = NSStringFromKMMMovieDiscoverSortBy(criteria.sortBy);
    
    if(criteria.voteCountGTE) {
        params[@"vote_count.gte"] = @(criteria.voteCountGTE);
    }
    
    if(criteria.voteCountLTE) {
        params[@"vote_count.lte"] = @(criteria.voteCountLTE);
    }
    
    if(criteria.voteAverageGTE) {
        params[@"vote_average.gte"] = @(criteria.voteAverageGTE);
    }
    
    if(criteria.voteAverageLTE) {
        params[@"vote_average.lte"] = @(criteria.voteAverageLTE);
    }
    
    if(criteria.cast.count > 0) {
        params[@"with_cast"] = [criteria.cast.allObjects componentsJoinedByString:@","];
    }
    
    if(criteria.crew.count > 0) {
        params[@"with_crew"] = [criteria.crew.allObjects componentsJoinedByString:@","];
    }
    
    if(criteria.companies.count > 0) {
        params[@"with_companies"] = [criteria.companies.allObjects componentsJoinedByString:@","];
    }
    
    if(criteria.genres.count > 0) {
        params[@"with_genres"] = [criteria.genres.allObjects componentsJoinedByString:@","];
    }
    
    if(criteria.keywords.count > 0) {
        params[@"with_keywords"] = [criteria.keywords.allObjects componentsJoinedByString:@","];
    }
    
    if(criteria.people.count > 0) {
        params[@"with_people"] = [criteria.people.allObjects componentsJoinedByString:@","];
    }
    
    return [params copy];
}

@end
