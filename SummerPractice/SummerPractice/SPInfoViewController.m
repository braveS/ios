#import "SPInfoViewController.h"
@implementation SPInfoViewController

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
@synthesize label6;

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Информация";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - Actions
- (IBAction) doGPlusBtn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/u/0/115258632142184381479/posts"]];
}

@end
