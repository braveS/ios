#import "SPClipboardViewController.h"

@implementation SPClipboardViewController

@synthesize toCopyTextView;
@synthesize toPasteTextView;

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Буфер обмена";
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    pasteBoard = [UIPasteboard generalPasteboard];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [pasteBoard setString:@""];
}


#pragma mark - Actions
-(IBAction)doCopyBtn {
    //Проверка на введение символов в поле 1
    if (![toCopyTextView.text isEqualToString:@""]){
        pasteBoard.string = toCopyTextView.text;
        NSLog(@"pasteb1 %@", pasteBoard.string);
    } else {
        NSString *msg = [[NSString alloc] initWithString:@"Write something first"];
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(IBAction)doPasteBtn {
    //Проверка на содержимое буфера обмена
    if (![pasteBoard.string isEqualToString:@""]){
        toPasteTextView.text = pasteBoard.string;
        NSLog(@"pasteb2 %@", pasteBoard.string);
    } else {
        NSString *msg = [[NSString alloc] initWithString:@"Copy something first"];
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
