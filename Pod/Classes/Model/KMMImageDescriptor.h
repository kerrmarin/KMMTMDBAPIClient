//
//  KMMImageDescriptor.h
//  Pods
//
//  Created by Kerr Marin Miller on 18/04/2015.
//
//

@import UIKit;

@interface KMMImageDescriptor : NSObject

@property(nonatomic, copy, readonly) NSString *filePath;
@property(nonatomic, assign, readonly) CGSize size;
@property(nonatomic, assign, readonly) CGFloat aspectRatio;

-(instancetype)initWithFilePath:(NSString*)filePath size:(CGSize)imageSize andAspectRatio:(CGFloat)aspectRatio;

@end



@interface KMMImageDescriptorParser : NSObject

-(KMMImageDescriptor*)imageDescriptorFromDictionary:(NSDictionary*)json;

@end
