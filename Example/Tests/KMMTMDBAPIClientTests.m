//
//  KMMTMDBAPIClientTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 11/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KMMTMDBAPIClient.h"

#import "KMMMovieCriteria.h"

@interface KMMTMDBAPIClientTests : XCTestCase

@end

@implementation KMMTMDBAPIClientTests

- (void)setUp {
    [super setUp];
    [[KMMTMDBAPIClient client] setAPIKey:@"dad3be1c54d32a605ed8931859ed6f0f"];
}

-(void)testDefaultIncludeAdultIsFalse {
    XCTAssert([[KMMTMDBAPIClient client].includeAdult isEqualToString:@"false"]);
}

-(void)testDefaultLanguageIsEnglish {
    XCTAssert([[KMMTMDBAPIClient client].language isEqualToString:@"en"]);
}

-(void)testClientIsSingleton {
    KMMTMDBAPIClient *client1 = [KMMTMDBAPIClient client];
    KMMTMDBAPIClient *client2 = [KMMTMDBAPIClient client];
    XCTAssertEqual(client1, client2);
}


@end
