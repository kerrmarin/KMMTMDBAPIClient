//
//  KMMMovieImageDescriptor.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMMovieImageDescriptor.h"

@implementation KMMMovieImageDescriptor

-(instancetype)initWithFilePath:(NSString*)filePath
                           size:(CGSize)imageSize
                    aspectRatio:(CGFloat)aspectRatio
                      voteCount:(NSInteger)voteCount
                    voteAverage:(CGFloat)voteAverage
                      imageType:(KMMMovieImageType)imageType
                    andLanguage:(NSString*)language {
    
    if(self = [super initWithFilePath:filePath size:imageSize andAspectRatio:aspectRatio]) {
        _voteCount = voteCount;
        _voteAverage = voteAverage;
        _imageType = imageType;
        //Backdrops don't have a language
        if(imageType == KMMMovieImageTypePoster) {
            _language = [language copy];
        }
    }
    return self;
}


@end

@implementation KMMMovieImageDescriptorParser

-(KMMMovieImageDescriptor *)movieImageDescriptorWithDictionary:(NSDictionary *)json {
    
    NSNumber *voteCountNumber = json[@"vote_count"] == [NSNull null] ? nil : json[@"vote_count"];
    NSInteger voteCount = [voteCountNumber integerValue];
    
    NSNumber *voteAverageNumber = json[@"vote_average"] == [NSNull null] ? nil : json[@"vote_average"];
    CGFloat voteAverage = [voteAverageNumber doubleValue];
    
    NSString *language = json[@"language"] == [NSNull null] ? nil : json[@"language"];
    
    KMMMovieImageType movieImageType = language ? KMMMovieImageTypeBackdrop : KMMMovieImageTypePoster;
    
    KMMImageDescriptor *imageDescriptor = [[KMMImageDescriptorParser alloc] imageDescriptorFromDictionary:json];
    
    KMMMovieImageDescriptor *movieImageDescriptor = [[KMMMovieImageDescriptor alloc] initWithFilePath:imageDescriptor.filePath
                                                                                                 size:imageDescriptor.size
                                                                                          aspectRatio:imageDescriptor.aspectRatio
                                                                                            voteCount:voteCount
                                                                                          voteAverage:voteAverage
                                                                                            imageType:movieImageType
                                                                                          andLanguage:language];
    return movieImageDescriptor;
}

@end
