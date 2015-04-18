//
//  KMMCertificationTests.m
//  KMMTMDBAPIClient
//
//  Created by Kerr Marin Miller on 17/01/2015.
//  Copyright (c) 2015 Kerr Marin Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <KMMTMDBAPIClient/KMMCertification.h>

@interface KMMCertificationTests : XCTestCase

@end

@implementation KMMCertificationTests

- (void)testCertificationIsCorrectlyCreated {
    NSString *code = @"PG";
    NSString *meaning = @"Parental guidance advised. There is no age restriction but some material may not be suitable for all children.";
    NSUInteger order = 2;
    
    KMMCertification *certification = [[KMMCertification alloc] initWithCode:code meanging:meaning order:order];
    
    XCTAssertNotNil(certification);
    XCTAssertTrue([certification.code isEqualToString:code], @"Code should be equal");
    XCTAssertTrue([certification.meaning isEqualToString:meaning], @"Meaning should be equal");
    XCTAssertTrue(certification.order == order, @"Order should be equal");
}

-(void)testCertificationCannotBeCreatedWithoutCode {
    NSString *meaning = @"Meaning";
    NSUInteger order = 2;
    XCTAssertThrows([[KMMCertification alloc] initWithCode:nil meanging:meaning order:order]);
}

-(void)testCertificationCannotBeCreatedWithoutMeaning {
    NSString *code = @"code";
    NSUInteger order = 2;
    XCTAssertThrows([[KMMCertification alloc] initWithCode:code meanging:nil order:order]);
}

- (void)testCertificationCreationPerformance {
    NSString *code = @"PG";
    NSString *meaning = @"Parental guidance advised. There is no age restriction but some material may not be suitable for all children.";
    NSUInteger order = 2;
    
    [self measureBlock:^{
            KMMCertification *certification = [[KMMCertification alloc] initWithCode:code meanging:meaning order:order];
            XCTAssertNotNil(certification);
    }];
}

-(void)testCertificationCopy {
    NSString *code = @"PG";
    NSString *meaning = @"Parental guidance advised. There is no age restriction but some material may not be suitable for all children.";
    NSUInteger order = 2;
    
    KMMCertification *certification = [[KMMCertification alloc] initWithCode:code meanging:meaning order:order];
    KMMCertification *otherCertification = [certification copy];
    
    XCTAssertEqual(certification, otherCertification);
}


@end
