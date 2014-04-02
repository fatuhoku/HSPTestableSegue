//
// Created by Hok Shun Poon on 02/04/2014.
// Copyright (c) 2014. All rights reserved.
//

#import "HSPTestSourceUIViewController.h"
#import "UIViewController+TestableSegues.h"
#import "HSPTestDestinationUIViewController.h"


@interface HSPTestSourceUIViewController ()
@property(nonatomic, copy) NSString *property;
@end

@implementation HSPTestSourceUIViewController
- (id)init {
    self = [super init];
    if (self) {
        self.property = @"Hello World!";
    }
    return self;
}

+ (NSDictionary *)seguePreparationBlocks {
    return @{
            @"seg_testable_segue":^(HSPTestSourceUIViewController *source, HSPTestDestinationUIViewController *destination, id sender) {
                NSLog(@"Well this is cool.");
                [destination say:source.property];
            }
    };
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self prepareForSegueWithSeguePreparationBlocks:segue sender:sender];
}

@end