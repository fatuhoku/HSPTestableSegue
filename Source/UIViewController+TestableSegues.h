//
// Created by Hok Shun Poon on 02/04/2014.
// Copyright (c) 2014. All rights reserved.
//

typedef void (^SeguePreparationBlock)(id sourceViewController, id destinationViewController, id sender);

@interface UIViewController (TestableSegues)

// Call this from your ViewController's prepareForSegue:sender: method
- (void)prepareForSegueWithSeguePreparationBlocks:(UIStoryboardSegue *)segue sender:(id)sender;

// Use this in your tests. You can inject a mock as a destinationViewController and verify interactions.
- (void)prepareForSegueWithIdentifier:(NSString *)identifier destinationViewController:(id)destinationViewController;

// Accesses seguePreparationBlocks
+ (SeguePreparationBlock)seguePreparationBlockForIdentifier:(NSString *)identifier;

// Subclasses must override this public method to supply a dictionary of segue preparation blocks
+ (NSDictionary *)seguePreparationBlocks;
@end