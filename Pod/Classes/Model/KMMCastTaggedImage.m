//
//  KMMCastTaggedImage.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMCastTaggedImage.h"
#import "KMMMovieSummary.h"

static KMMCastTaggedImageType KMMCastTaggedImageTypeFromString(NSString *string) {
    if([string isEqualToString:@"backdrop"]) {
        return KMMCastTaggedImageTypeBackdrop;
    } else if([string isEqualToString:@""]) {
        return KMMCastTaggedImageTypeProfile;
    } else {
        return KMMCastTaggedImageTypeUnknown;
    }
}

static KMMCastTaggedMediaType KMMCastTaggedMediaTypeFromString(NSString *string) {
    if([string isEqualToString:@"movie"]) {
        return KMMCastTaggedMediaTypeMovie;
    } else if([string isEqualToString:@"tv"]) {
        return KMMCastTaggedMediaTypeTV;
    } else {
        return KMMCastTaggedMediaTypeUnknown;
    }
}

@implementation KMMCastTaggedImage

-(instancetype)initWithId:(NSString*)taggedImageId
                   height:(NSInteger)height
                    width:(NSInteger)width
                 filePath:(NSString*)filePath
                iso_639_1:(NSString*)iso_639_1
                imageType:(KMMCastTaggedImageType)imageType
                mediaType:(KMMCastTaggedMediaType)mediaType
              aspectRatio:(CGFloat)aspectRatio
              voteAverage:(CGFloat)voteAverage
                voteCount:(CGFloat)voteCount
                    media:(KMMMovieSummary*)media {
    
    if(self = [super init]) {
        _taggedImageId = [taggedImageId copy];
        _height = height;
        _width = width;
        _filePath = [filePath copy];
        _iso_639_1 = [iso_639_1 copy];
        _imageType = imageType;
        _mediaType = mediaType;
        _aspectRatio = aspectRatio;
        _voteAverage = voteAverage;
        _voteCount = voteCount;
        _media = [media copy];
    }
    return self;
}

@end

#import "KMMMovieSummary.h"

@implementation KMMCastTaggedImageParser

-(KMMCastTaggedImage *)castTaggedImageFromDictionary:(NSDictionary*)json {
    NSString *taggedImageId = json[@"id"];
    
    NSNumber *heightNumber = json[@"height"] == [NSNull null] ? nil : json[@"height"];
    NSInteger height = [heightNumber integerValue];
    
    NSNumber *widthNumber = json[@"width"] == [NSNull null] ? nil : json[@"width"];
    NSInteger width = [widthNumber integerValue];
    
    NSString *filePath = json[@"file_path"] == [NSNull null] ? nil : json[@"file_path"];
    NSString *iso_639_1 = json[@"iso_639_1"] == [NSNull null] ? nil : json[@"iso_639_1"];
    
    NSString *mediaTypeString = json[@"media_type"] == [NSNull null] ? nil : json[@"media_type"];
    NSString *imageTypeString = json[@"image_type"] == [NSNull null] ? nil : json[@"image_type"];
    KMMCastTaggedImageType imageType = KMMCastTaggedImageTypeFromString(imageTypeString);
    KMMCastTaggedMediaType mediaType = KMMCastTaggedMediaTypeFromString(mediaTypeString);
    
    NSNumber *aspectRatioNumber = json[@"aspect_ratio"] == [NSNull null] ? nil : json[@"aspect_ratio"];
    CGFloat aspectRatio = [aspectRatioNumber doubleValue];
    
    NSNumber *voteAverageNumber = json[@"vote_average"] == [NSNull null] ? nil : json[@"vote_average"];
    CGFloat voteAverage = [voteAverageNumber doubleValue];
    
    NSNumber *voteCountNumber = json[@"vote_count"] == [NSNull null] ? nil : json[@"vote_count"];
    CGFloat voteCount = [voteCountNumber doubleValue];
    
    KMMMovieSummaryParser *movieSummaryParser = [KMMMovieSummaryParser new];
    KMMMovieSummary *summary = [movieSummaryParser movieSummaryFromDictionary:json[@"media"]];
    
    KMMCastTaggedImage *taggedImage = [[KMMCastTaggedImage alloc] initWithId:taggedImageId
                                                                      height:height
                                                                       width:width
                                                                    filePath:filePath
                                                                   iso_639_1:iso_639_1
                                                                   imageType:imageType
                                                                   mediaType:mediaType
                                                                 aspectRatio:aspectRatio
                                                                 voteAverage:voteAverage
                                                                   voteCount:voteCount
                                                                       media:summary];
    return taggedImage;
    
}

@end
