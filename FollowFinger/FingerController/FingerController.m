#import "FingerController.h"

@interface FingerController ()
{
    BOOL followingfinger;
}

@property(nonatomic, strong) NSMutableArray *viewControllerStack;

- (UIViewController *)currentViewController;
- (UIViewController *)previousViewController;
- (void)setUpGestureRecognizers:(UIViewController *)viewController;
- (void)tearDownGestureRecognizers:(UIViewController *)viewController;
- (void)pushNewViewIn:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation FingerController

@synthesize viewControllerStack = _viewControllerStack;


- (void)setupNewViewController:(UIViewController *)viewController
{
    viewController.view.frame = self.view.bounds;
    [self setUpGestureRecognizers:viewController];
    if ([viewController respondsToSelector:@selector(setFinger:)])
        [viewController performSelector:@selector(setFinger:) withObject:self];
    [self.view addSubview:viewController.view];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if ((self = [super init])) {
        self.viewControllerStack = [NSMutableArray arrayWithObject:rootViewController];
        [self setupNewViewController:rootViewController];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController {
    NSLog(@"push a new view");

    [self setupNewViewController:viewController];
    [self.viewControllerStack addObject:viewController];
}


- (UIViewController *)currentViewController {
    return [self.viewControllerStack lastObject];
}

- (UIViewController *)previousViewController {
    return [self.viewControllerStack objectAtIndex:self.viewControllerStack.count - 2];
}

- (void)setUpGestureRecognizers:(UIViewController *)viewController {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
        initWithTarget:self
        action:@selector(handlePanGestures:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [viewController.view addGestureRecognizer:panGestureRecognizer];
}

- (void)tearDownGestureRecognizers:(UIViewController *)viewController {
    for (UIGestureRecognizer *gestureRecognizer in [viewController.view gestureRecognizers]) {
        [viewController.view removeGestureRecognizer:gestureRecognizer];
    }
}

- (void)pushNewViewIn:(UIGestureRecognizer *)gestureRecognizer {
    UIViewController *currentViewController = [self currentViewController];
    if ([currentViewController respondsToSelector:@selector(viewControllerToPush)]) {
        UIViewController *newViewController = [currentViewController performSelector:@selector(viewControllerToPush)];
        [self pushViewController:newViewController];
    }
}

- (void)handlePanGestures:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint loc = [gestureRecognizer locationInView:self.view];

    CGPoint translation = [gestureRecognizer translationInView:self.view];
    [gestureRecognizer setTranslation:CGPointZero inView:self.view];

    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        followingfinger = YES;

        if(translation.x < 0)
        {
            if(![[self currentViewController] respondsToSelector:@selector(viewControllerToPush)]) {
                followingfinger = NO;
                return ;
            }

            UIViewController *newViewController = [[self currentViewController] performSelector:@selector(viewControllerToPush)];
            [self pushViewController:newViewController];
        }

        UIView *myview = [self currentViewController].view;
        CGRect myFrame = myview.frame;
        myFrame.origin.x = loc.x;
        myview.frame = myFrame;
    } else if(gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if(!followingfinger)
            return ;

        UIView *myview = [self currentViewController].view;
        myview.center = CGPointMake(myview.center.x + translation.x, myview.center.y);
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded ||  gestureRecognizer.state == UIGestureRecognizerStateFailed) {
        if(!followingfinger)
            return ;

        BOOL remove = NO;
        if(loc.x > self.view.bounds.size.width/2) {
            if(self.viewControllerStack.count > 1)
                remove = YES;
            else
                [self alertUser];
        }

        [self resetViewWithRemove:remove];
    }
}

- (void)alertUser
{
    UIAlertView *alert = [[UIAlertView alloc]
        initWithTitle: @"Message"
        message: @"It's areadly the root view"
        delegate: nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];

    [alert show];
}

- (void)resetViewWithRemove:(BOOL)remove
{
    if(remove) {
        [self tearDownGestureRecognizers:[self currentViewController]];
        [[self currentViewController].view removeFromSuperview];
        NSLog(@"remove a view");
        [self.viewControllerStack removeLastObject];
    }
    UIView *myview = [self currentViewController].view;
    myview.frame = self.view.bounds;
}

@end
