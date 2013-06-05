#import "SPGalleryViewController.h"

@implementation SPGalleryViewController
@synthesize backGroundImage;
@synthesize popoverController;
@synthesize toolbar;

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Взаимодействие с Фотогалереей";
    UIBarButtonItem *photoButton = [[UIBarButtonItem alloc]  initWithTitle:@"Выбрать картинку" style:UIBarButtonItemStyleBordered target:self action:@selector(doOpenGalleryBtn:)];
    NSArray *items = [NSArray arrayWithObjects:photoButton, nil];
    [toolbar setItems:items animated:NO];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - doChooseBackGroundImg
- (IBAction)doOpenGalleryBtn: (id)sender {
    if ([self.popoverController isPopoverVisible]) {
        [self.popoverController dismissPopoverAnimated:YES];
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker.allowsEditing = NO;
            
            self.popoverController = [[UIPopoverController alloc]
                                      initWithContentViewController:imagePicker];
            
            popoverController.delegate = self;
            
            [self.popoverController 
             presentPopoverFromBarButtonItem:sender
             permittedArrowDirections:UIPopoverArrowDirectionUp
             animated:YES];
          newMedia = NO;
        }
    }
 }

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.popoverController dismissPopoverAnimated:true];    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        backGroundImage.image = image;
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Ошибка при сохранении"
                              message: @"Ошибка"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
}

@end
