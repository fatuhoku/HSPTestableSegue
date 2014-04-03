//
// Created by Hok Shun Poon on 02/04/2014.
// Copyright (c) 2014. All rights reserved.
//

#import "UIViewController+TestableSegues.h"

@implementation UIViewController (TestableSegues)

- (void)prepareForSegueWithSeguePreparationBlocks:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = segue.identifier;
    SeguePreparationBlock block = [self seguePreparationBlockForIdentifier:identifier];
    block(segue.destinationViewController, sender);
}

- (void)prepareForSegueWithIdentifier:(NSString *)identifier destinationViewController:(id)destinationViewController {
    SeguePreparationBlock preparationBlock = [self seguePreparationBlockForIdentifier:identifier];
    id sender = self;
    preparationBlock(destinationViewController, sender);
}

- (SeguePreparationBlock)seguePreparationBlockForIdentifier:(NSString *)identifier {
    SeguePreparationBlock x = [[self seguePreparationBlocks] objectForKey:identifier];
    if (!x) {
        NSLog(@"WARNING: '%@' segue preparation block requested but no such key was found in seguePreparationBlocks.", identifier);
    }
    return x;
}

- (NSDictionary *)seguePreparationBlocks {
    [NSException raise:@"Not implemented." format:@"You must supply seguePreparationBlocks in your class."];
    return nil;
}

@end