//
//  KMMCountryTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMCountry.h>

@interface KMMCountryTests : XCTestCase

@end

@implementation KMMCountryTests

- (void)testCountryIsCorrectlyCreated {
    NSString *code = @"GB";
    KMMCountry *country = [[KMMCountry alloc] initWithCountryCode:code];
    XCTAssertNotNil(country);
    XCTAssertTrue([country.countryCode isEqualToString:code], @"Code should be equal");
}


-(void)testCountryCannotBeCreatedWithoutCode {
    XCTAssertThrows([[KMMCountry alloc] initWithCountryCode:nil]);
}

- (void)testCountryCreationPerformance {
    NSString *code = @"GB";
    
    [self measureBlock:^{
        for(int i = 0; i < 10000; i++) {
            KMMCountry *country = [[KMMCountry alloc] initWithCountryCode:code];
            XCTAssertNotNil(country);
        }
    }];
}

@end
