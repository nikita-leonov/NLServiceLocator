//
//  NLServiceLocatorTests.m
//  ServiceLocator
//
//  Created by Nikita Leonov on 3/20/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Nikita Leonov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <XCTest/XCTest.h>
#import "NLServiceLocator.h"
#import "NLSampleServiceOne.h"
#import "NLSampleServiceTwo.h"
#import "NLSampleServiceThree.h"
#import "NLSampleServiceFour.h"

@interface NLServiceLocatorTests : XCTestCase

@end

@implementation NLServiceLocatorTests

- (void)setUp
{
    [super setUp];

    id notRegisteredService = [[NLSampleServiceOne alloc] init];
    [NLServiceLocator registerService:notRegisteredService];

    notRegisteredService = [[NLSampleServiceTwo alloc] init];
    [NLServiceLocator registerService:notRegisteredService];
    
    notRegisteredService = [[NLSampleServiceThree alloc] init];
    [NLServiceLocator registerService:notRegisteredService];

    notRegisteredService = [[NLSampleServiceFour alloc] init];
    [NLServiceLocator registerService:notRegisteredService forProtocol:@protocol(NLFifthSampleService)];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    id<NLFirstSampleService> locatedServiceOne = [NLServiceLocator serviceForProtocol:@protocol(NLFirstSampleService)];
    XCTAssertNotNil(locatedServiceOne, @"Service for protocol NLFirstSampleService was not located properly.");
    [locatedServiceOne testOne];


    id<NLSecondSampleService> locatedServiceTwo = [NLServiceLocator serviceForProtocol:@protocol(NLSecondSampleService)];
    XCTAssertNotNil(locatedServiceTwo, @"Service for protocol NLSecondSampleService was not located properly.");
    [locatedServiceTwo testTwo];

    id<NLThirdSampleService> locatedServiceThree = [NLServiceLocator serviceForProtocol:@protocol(NLThirdSampleService)];
    XCTAssertNotNil(locatedServiceThree, @"Service for protocol NLThirdSampleService was not located properly.");
    [locatedServiceThree testThree];

    id<NLFourthSampleService> locatedServiceFourth = [NLServiceLocator serviceForProtocol:@protocol(NLFourthSampleService)];
    XCTAssertNotNil(locatedServiceFourth, @"Service for protocol NLFourthSampleService was not located properly.");
    [locatedServiceFourth testFour];

    id<NLFifthSampleService> locatedServiceFifth = [NLServiceLocator serviceForProtocol:@protocol(NLFifthSampleService)];
    XCTAssertNotNil(locatedServiceFifth, @"Service for protocol NLFifthSampleService was not located properly.");
    [locatedServiceFifth testFive];

    locatedServiceFifth = [NLServiceLocator serviceForProtocol:@protocol(NLFirstSampleService)];
    XCTAssertThrows([locatedServiceFifth testFive], @"Service for protocol NLFirstSampleService was overriden, while no calls of such nature was done in setUp.");
}

@end
