//
//  InfoView.m
//  navigation_orth
//
//  Created by Mobile on 07.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import "InfoView.h"
#import "EditingView.h"

@implementation InfoView
@synthesize someText;
@synthesize detailText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
/*-(void) ShowInView {
    if(delegate && [delegate respondsToSelector:@selector(showInfo:)]){
        
    }
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(520, 180);

    NSLog(@"log = %@",someText.text);
   // someText.text = detailText;
   // NSLog(@"log = %@",someText.text);


}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
