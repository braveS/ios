#import <UIKit/UIKit.h>

@interface SPInfoViewController : UIViewController {
    IBOutlet UIButton *gPlusBtn;
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
    IBOutlet UILabel *label4;
    IBOutlet UILabel *label5;
    IBOutlet UILabel *label6;
}

@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UILabel *label2;
@property (nonatomic, retain) IBOutlet UILabel *label3;
@property (nonatomic, retain) IBOutlet UILabel *label4;
@property (nonatomic, retain) IBOutlet UILabel *label5;
@property (nonatomic, retain) IBOutlet UILabel *label6;

- (IBAction) doGPlusBtn;

@end
