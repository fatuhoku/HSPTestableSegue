HSPTestableSegue
================

A Objective-C category that helps you structure your iOS UIViewControllers' `prepareForSegue:sender:` code in a testable way.

### Usage

If you use Storyboards, you're probably going to have `UIViewController` subclasses whose `prepareForSegue:sender:` method looks a bit like this:

```objc
// YOURSourceViewController.m
...
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"seg_untestable_segue"]) {
        YOURSpecificViewController *viewController = segue.destinationViewController;
        // Do something with the destination View Controller
        viewController.model = [self launchTheNukes];
    } else if ([segue.identifier isEqualToString:@"seg_another_untestable_segue"]) {
        YOURDestinationViewController *viewController = segue.destinationViewController;
        // Do something else with this destination View Controller...
        ...
    }
    ...
}
...
```

This is the vital glue that links one screen of your application to the next:
and yet, written like this, it's notoriously difficult to test and to verify
the behaviour of. Your options are:

 - supply a mock `UIStoryboardSegue`, whose behaviours need to be set up to return various `destinationViewController`s
 - actually fire up the app and physically invoke the segue

With `HSPTestableSegue` you can write the same code like this:

```objc
// YOURSourceViewController.m
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self prepareForSegueWithSeguePreparationBlocks:segue sender:sender];
}

+ (NSDictionary *)seguePreparationBlocks {
    return @{
            @"seg_testable_segue":^(YOURSourceUIViewController *source,
                                    YOURDestinationUIViewController *destination,
                                    id sender) {
                // Do something with the source and destination View Controller
                destination.model = source.property;
            }
    };
}
```


Here, we've effectively split up the implementation of
`prepareForSegue:sender:` into a dictionary of segue preparation code blocks
keyed on the segue identifier, supplied by the dictionary returned by
`seguePreparationBlocks`.

This is made possible by implementing a small category on `UIViewController`
that implements methods like
`prepareForSegueWithSeguePreparationBlocks:sender:`. This method replaces the
conditional block and looks up the appropriate code block by using the segue
identifier.

With the blocks separately defined, there's another method called
`prepareForSegueWithIdentifier:destinationViewController:` that's intended to
let you inject a mock View Controller into the segue preparation code block, so
that you can verify its behaviour.


```objc
    YOURSourceUIViewController *viewController = [[YOURSourceUIViewController alloc] init];
    id mockViewController = mock([YOURDestinationUIViewController class]);   // create a mock here

    [viewController prepareForSegueWithIdentifier:@"seg_very_testable_segue"
                        destinationViewController:mockViewController];   // pretend you're about to perform the segue

    [MKTVerify(mockViewController) setModel:source.property];   // verify behaviour (here, OCMockito is used)
```

If you're unsure on anything, a demo project has been included. Check it out
and run the test to get a feel for how this works.  If in doubt, just read
through the code. There's not a huge amount of it =]


### Installation

Just copy `UIViewController+TestableSegues.{h,m}` into your project and start
using them right away away.


### Contributing

I'd love to hear what you think of this approach to making segue preparation
code more testable.  Feedback welcome! Any questions or problems, just [open a
new issue](https://github.com/fatuhoku/HSPTestableSegue/issues) and I'll get
back to you.

### License

MIT
