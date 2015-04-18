//
//  KMMMovieImageDescriptor.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

#import "KMMImageDescriptor.h"

typedef NS_ENUM(NSInteger, KMMMovieImageType) {
    KMMMovieImageTypeUnknown = 0,
    KMMMovieImageTypeBackdrop,
    KMMMovieImageTypePoster
};

@interface KMMMovieImageDescriptor : KMMImageDescriptor

@property(nonatomic, assign, readonly) NSInteger voteCount;
@property(nonatomic, assign, readonly) CGFloat voteAverage;
@property(nonatomic, assign, readonly) KMMMovieImageType imageType;
@property(nonatomic, copy, readonly) NSString *language;

-(instancetype)initWithFilePath:(NSString*)filePath
                           size:(CGSize)imageSize
                    aspectRatio:(CGFloat)aspectRatio
                      voteCount:(NSInteger)voteCount
                    voteAverage:(CGFloat)voteAverage
                      imageType:(KMMMovieImageType)imageType
                    andLanguage:(NSString*)language;

@end


@interface KMMMovieImageDescriptorParser : NSObject

-(KMMMovieImageDescriptor*)movieImageDescriptorWithDictionary:(NSDictionary*)json;

@end
