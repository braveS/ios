#import <UIKit/UIKit.h>
@interface SPViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    //Buttons 
    IBOutlet UIButton *calculatorBtn;
    IBOutlet UIButton *graphBtn;
    IBOutlet UIButton *clipboardBtn;
    IBOutlet UIButton *langBtn;
    IBOutlet UIButton *infoBtn;
    IBOutlet UIButton *galleryBtn;

}
@property (nonatomic, retain) IBOutlet UIImageView *backImg;
- (IBAction)doCalculatorBtn;
- (IBAction)doGraphBtn;
- (IBAction)doClipboardBtn;
- (IBAction)doLanguageBtn;
- (IBAction)doInfoBtn;
- (IBAction)doGalleryBtn;

@end
