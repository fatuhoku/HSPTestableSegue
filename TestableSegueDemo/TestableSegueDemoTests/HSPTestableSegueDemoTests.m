//
//  HSPTestableSegueDemoTests.m
//  HSPTestableSegueDemoTests
//
//  Created by Hok Shun Poon on 02/04/2014.
//  Copyright (c) 2014 Hok Shun Poon. All rights reserved.
//

#import <XCTest/XCTest.h>

#define MOCKITO_SHORTHAND

#import <OCMockito/OCMockito.h>

#import "HSPTestSourceUIViewController.h"
#import "HSPTestDestinationUIViewController.h"
#import "UIViewController+TestableSegues.h"

@interface HSPTestableSegueDemoTests : XCTestCase

@end

@implementation HSPTestableSegueDemoTests

- (void)testStoryboardPrepareForSegueInteractionsAreVerifiableWithMocks {
    HSPTestSourceUIViewController *viewController = [[HSPTestSourceUIViewController alloc] init];
    id mockViewController = mock([HSPTestDestinationUIViewController class]);
    [viewController prepareForSegueWithIdentifier:@"seg_testable_segue"
                        destinationViewController:mockViewController];
    [MKTVerify(mockViewController) say:@"Hello World!"];
}

@end
