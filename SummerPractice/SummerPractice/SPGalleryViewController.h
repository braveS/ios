#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface SPGalleryViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate> {
    IBOutlet UIImageView *backGroundImage;
    UIPopoverController *popoverController;
    BOOL newMedia;
    UIToolbar *toolbar;
}
@property (nonatomic, retain) IBOutlet UIImageView *backGroundImage;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIToolbar *toolbar;

-(IBAction) doOpenGalleryBtn: (id)sender;

@end