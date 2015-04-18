//
//  KMMCastTaggedImage.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

typedef NS_ENUM(NSInteger, KMMCastTaggedImageType) {
    KMMCastTaggedImageTypeUnknown = 0,
    KMMCastTaggedImageTypeBackdrop,
    KMMCastTaggedImageTypeProfile
};

typedef NS_ENUM(NSInteger, KMMCastTaggedMediaType) {
    KMMCastTaggedMediaTypeUnknown = 0,
    KMMCastTaggedMediaTypeMovie,
    KMMCastTaggedMediaTypeTV
};

@class KMMMovieSummary;

@interface KMMCastTaggedImage : NSObject


@property(nonatomic, assign, readonly) NSInteger height;
@property(nonatomic, assign, readonly) NSInteger width;

@property(nonatomic, copy, readonly) NSString *filePath;
@property(nonatomic, copy, readonly) NSString *taggedImageId;
@property(nonatomic, copy, readonly) NSString *iso_639_1;

@property(nonatomic, assign, readonly) KMMCastTaggedImageType imageType;
@property(nonatomic, assign, readonly) KMMCastTaggedMediaType mediaType;

@property(nonatomic, assign, readonly) CGFloat aspectRatio;
@property(nonatomic, assign, readonly) CGFloat voteAverage;
@property(nonatomic, assign, readonly) CGFloat voteCount;

@property(nonatomic, copy, readonly) KMMMovieSummary* media;

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
                    media:(KMMMovieSummary*)media;

@end

@interface KMMCastTaggedImageParser : NSObject

-(KMMCastTaggedImage*)castTaggedImageFromDictionary:(NSDictionary*)json;

@end
