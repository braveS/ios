#import <UIKit/UIKit.h>

@interface SPClipboardViewController : UIViewController {
    IBOutlet UIButton *copyBtn;
    IBOutlet UIButton *pasteBtn;
    IBOutlet UITextView *toCopyTextView;
    IBOutlet UITextView *toPasteTextView;
    
    //буфер обмена
    UIPasteboard *pasteBoard;
}
@property (nonatomic, retain) IBOutlet UITextView *toCopyTextView;
@property (nonatomic, retain) IBOutlet UITextView *toPasteTextView;

- (IBAction) doCopyBtn;
- (IBAction) doPasteBtn;

@end
