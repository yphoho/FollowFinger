//@protocol FingerControllerDelegate;

@interface FingerController : UIViewController

- (id)initWithRootViewController:(UIViewController*)rootViewController;
- (void)pushViewController:(UIViewController *)viewController;

@end


@protocol FingerControllerDelegate <NSObject>

@optional
@property(nonatomic, strong) FingerController *finger;
- (UIViewController *)viewControllerToPush;

@end
