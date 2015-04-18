//
//  KMMReview.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMReview.h"

@implementation KMMReview

-(instancetype)initWithReviewID:(NSString *)reviewID author:(NSString *)author andContent:(NSString *)content {
    
    //    NSParameterAssert(reviewID);
    //    NSParameterAssert(author);
    //    NSParameterAssert(content);
    
    if(self = [super init]) {
        _reviewID = [reviewID copy];
        _author = [author copy];
        _content = [content copy];
    }
    return self;
}

@end


@implementation KMMReviewParser

-(KMMReview *)reviewFromDictionary:(NSDictionary *)json {
    
    NSString *reviewID = json[@"id"] == [NSNull null] ? nil : json[@"id"];
    NSString *author = json[@"author"] == [NSNull null] ? nil : json[@"author"];
    NSString *content = json[@"content"] == [NSNull null] ? nil : json[@"content"];
    
    KMMReview *review = [[KMMReview alloc] initWithReviewID:reviewID author:author andContent:content];
    return review;
}


@end
