//
//  KMMAppDelegate.m
//  KMMTMDBAPIClient
//
//  Created by CocoaPods on 01/10/2015.
//  Copyright (c) 2014 Kerr Marin Miller. All rights reserved.
//

#import "KMMAppDelegate.h"

#import <KMMTMDBAPIClient/KMMTMDBAPIClient.h>

@implementation KMMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[KMMTMDBAPIClient client] setAPIKey:@"dad3be1c54d32a605ed8931859ed6f0f"];
    return YES;
}

@end
