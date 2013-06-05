#import <UIKit/UIKit.h>

@class SPViewController;

@interface SPAppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SPViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;


@end
