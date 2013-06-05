#import <UIKit/UIKit.h>
#import "SPCalculatorBrain.h"

@interface SPCalculatorViewController : UIViewController {
    IBOutlet UITextView *dialogText;    
    IBOutlet UILabel *displayLabel;

    SPCalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumer;
	BOOL decUsed;
}
@property (nonatomic, retain) IBOutlet UITextView *dialogText;
@property (nonatomic, retain) IBOutlet UILabel *displayLabel;

-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;


@end
