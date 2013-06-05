//объявление классов
#import "SPViewController.h"
#import "SPCalculatorViewController.h"
#import "SPClipboardViewController.h"
#import "SPGraphViewController.h"
#import "SPComponentViewController.h"
#import "SPInfoViewController.h"
#import "SPGalleryViewController.h"

@implementation SPViewController
@synthesize backImg;

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Главная страница";
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Actions
- (IBAction)doCalculatorBtn {
    SPCalculatorViewController *calculatorView = [[SPCalculatorViewController alloc] initWithNibName:@"SPCalculatorViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:calculatorView animated:YES];
}

- (IBAction)doGraphBtn {
    SPGraphViewController *graphView = [[SPGraphViewController alloc] initWithNibName:@"SPGraphViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:graphView animated:YES];
}

- (IBAction)doClipboardBtn {
    SPClipboardViewController *clipboardView = [[SPClipboardViewController alloc] initWithNibName:@"SPClipboardViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:clipboardView animated:YES];
}

- (IBAction)doLanguageBtn {
    SPComponentViewController *componentView = [[SPComponentViewController alloc] initWithNibName:@"SPComponentViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:componentView animated:YES];
}

-(IBAction)doInfoBtn {
    SPInfoViewController *infoView = [[SPInfoViewController alloc] initWithNibName:@"SPInfoViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)doGalleryBtn {
    SPGalleryViewController *galleryView = [[SPGalleryViewController alloc] initWithNibName:@"SPGalleryViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:galleryView animated:YES];
}


@end
