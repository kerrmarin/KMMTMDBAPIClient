//
//  KMMTMDBAPIClient.m
//  Pods
//
//  Created by Kerr Marin Miller on 10/01/2015.
//
//

#import "KMMTMDBAPIClient.h"
#import "KMMParseConfigurationManager.h"

@interface KMMTMDBAPIClient ()

@property(nonatomic, strong, readonly) NSDictionary *defaultParameters;
@property(nonatomic, copy, readonly) NSString *configurationURL;

@end

@implementation KMMTMDBAPIClient

+(instancetype)client {
    static KMMTMDBAPIClient *_client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [KMMTMDBAPIClient new];
    });
    return _client;
}

/**
 *  Initializes the TMDBAPIClient
 *
 *  @return a fully initialized API client
 */
-(instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:[[KMMParseConfigurationManager manager] tmdbBaseUrl]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json"}];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024
                                                      diskCapacity:200 * 1024 * 1024
                                                          diskPath:nil];
    
    [config setURLCache:cache];
    //10 seconds timeout for whole resource
    [config setTimeoutIntervalForResource:10];
    //5 second timeout for any communication to occur
    [config setTimeoutIntervalForRequest:5];
    
    if(self = [super initWithBaseURL:baseURL sessionConfiguration:config]) {
        [self updateConfigURL];
    }
    
    return self;
}


@end
