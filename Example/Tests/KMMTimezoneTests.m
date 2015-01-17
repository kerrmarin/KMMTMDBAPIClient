//
//  KMMTimezoneTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMTimezone.h>

@interface KMMTimezoneTests : XCTestCase

@end

@implementation KMMTimezoneTests

- (void)testTimezoneIsCorrectlyCreated {
    NSString *code = @"PG";
    NSArray *zones = @[@"London", @"Madrid"];
    
    KMMTimezone *timezone = [[KMMTimezone alloc] initWithCode:code zones:zones];
    
    XCTAssertNotNil(timezone);
    XCTAssertTrue([timezone.code isEqualToString:code], @"Code should be equal");
    XCTAssertTrue([timezone.zones[0] isEqualToString:@"London"], @"Timezone zones should be have the same objects a they were created with");
    XCTAssertTrue([timezone.zones[1] isEqualToString:@"Madrid"], @"Timezone zones should be have the same objects a they were created with");
    XCTAssertTrue(timezone.zones.count == zones.count, @"Timezone zones should be have the same objects a they were created with");
}

-(void)testTimezoneCannotBeCreatedWithoutCode {
    NSArray *zones = @[@"London", @"Madrid"];
    XCTAssertThrows([[KMMTimezone alloc] initWithCode:nil zones:zones]);
}

-(void)testTimezoneCannotBeCreatedWithoutZones {
    NSString *code = @"GB";
    XCTAssertThrows([[KMMTimezone alloc] initWithCode:code zones:nil]);
}

- (void)testTimezoneCreationPerformance {
    NSString *code = @"PG";
    NSArray *zones = @[@"London", @"Madrid"];

    [self measureBlock:^{
        for(int i = 0; i < 10000; i++) {
            KMMTimezone *timezone = [[KMMTimezone alloc] initWithCode:code zones:zones];
            XCTAssertNotNil(timezone);
        }
    }];
}

@end
