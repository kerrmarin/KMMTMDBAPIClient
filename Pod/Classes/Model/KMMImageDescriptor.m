//
//  KMMImageDescriptor.m
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

#import "KMMImageDescriptor.h"

@implementation KMMImageDescriptor

-(instancetype)initWithFilePath:(NSString*)filePath
                           size:(CGSize)imageSize
                 andAspectRatio:(CGFloat)aspectRatio {
    if(self = [super init]) {
        _filePath = [filePath copy];
        _size = imageSize;
        _aspectRatio = aspectRatio;
    }
    return self;
}

@end


@implementation KMMImageDescriptorParser

-(KMMImageDescriptor *)imageDescriptorFromDictionary:(NSDictionary *)json {
    NSString *filePath = json[@"file_path"] == [NSNull null] ? nil : json[@"file_path"];
    CGFloat width = [json[@"width"] floatValue];
    CGFloat height = [json[@"height"] floatValue];
    CGSize size = CGSizeMake(width, height);
    CGFloat aspectRatio = [json[@"aspect_ratio"] floatValue];
    
    KMMImageDescriptor *imageDescriptor = [[KMMImageDescriptor alloc] initWithFilePath:filePath
                                                                                  size:size
                                                                        andAspectRatio:aspectRatio];
    return imageDescriptor;
}

@end
