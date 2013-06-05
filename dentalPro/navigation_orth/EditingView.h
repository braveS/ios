//
//  EditingView.h
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "InfoView.h"
// #import "RegexKitLite.h"
#import "PatientSQL.h"
#import "SQLiteAccess.h"
//#import "FCheckBox.h"

@class RootViewController;
@class PatientSQL;
@protocol toothDetailDeleg;


@interface EditingView : UIViewController <UIScrollViewDelegate,UIPageViewControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate, UIPickerViewDelegate,UIApplicationDelegate> {
    
#pragma mark - Independent
// Independent
    IBOutlet UIScrollView *myScroll;
    IBOutlet UIPageControl *pageControl;
    int pageNumber;
    // for scrolling keyboard
    CGFloat animatedDistance;
    CGPoint offset;
    // end$
    int tTag;
    int maxTextFieldCount,minTextFieldCount;
    BOOL LengthControl, displayKeyboard;
    PatientSQL *patient;
    UIImage *standartImg;
    
    BOOL btnPressed;
#pragma mark - View_1
// VIEW 1 ============================================================
    IBOutlet UIView *View1;
    IBOutlet UITextView *nameField;
    IBOutlet UIImageView *photoImg;
    IBOutlet UITextView *phoneField;
    IBOutlet UITextView *genderField;
    IBOutlet UITextView *addressField;
    IBOutlet UITextView *birthField;
    
    IBOutlet UITextView *diagnosisView;
    IBOutlet UITextView *complainView;
    IBOutlet UITextView *anamnesisView;
    IBOutlet UITextView *medicalHystoryView;
    
    IBOutlet UINavigationBar *navBar1;
    RootViewController *homePage;
    IBOutlet UIBarButtonItem *homeBtn;
    IBOutlet UIBarButtonItem *cancelBtn;
    IBOutlet UILabel *currentDateLabel;
    IBOutlet UILabel *currentDayLabel;


#pragma mark - VIEW_2        
// VIEW 2 ============================================================
    IBOutlet UIView *View2;
    IBOutlet UILabel *notesLabel;
    IBOutlet UITextView *notesView;
    IBOutlet UIImageView *jawImg;

    //buttons
    IBOutlet UIButton *doBtn18;
    IBOutlet UIButton *doBtn17;
    IBOutlet UIButton *doBtn16;
    IBOutlet UIButton *doBtn15;
    IBOutlet UIButton *doBtn14;
    IBOutlet UIButton *doBtn13;
    IBOutlet UIButton *doBtn12;
    IBOutlet UIButton *doBtn11;
    
    IBOutlet UIButton *doBtn21;
    IBOutlet UIButton *doBtn22;
    IBOutlet UIButton *doBtn23;
    IBOutlet UIButton *doBtn24;
    IBOutlet UIButton *doBtn25;
    IBOutlet UIButton *doBtn26;
    IBOutlet UIButton *doBtn27;
    IBOutlet UIButton *doBtn28;
    
    IBOutlet UIButton *doBtn48;
    IBOutlet UIButton *doBtn47;
    IBOutlet UIButton *doBtn46;
    IBOutlet UIButton *doBtn45;
    IBOutlet UIButton *doBtn44;
    IBOutlet UIButton *doBtn43;
    IBOutlet UIButton *doBtn42;
    IBOutlet UIButton *doBtn41;
    
    IBOutlet UIButton *doBtn31;
    IBOutlet UIButton *doBtn32;
    IBOutlet UIButton *doBtn33;
    IBOutlet UIButton *doBtn34;
    IBOutlet UIButton *doBtn35;
    IBOutlet UIButton *doBtn36;
    IBOutlet UIButton *doBtn37;
    IBOutlet UIButton *doBtn38;
       
    id delegate;

#pragma mark - VIEW_3
// VIEW 3 ============================================================
    IBOutlet UIView *View3;
    IBOutlet UIDatePicker *nextMeetPicker;
    IBOutlet UITextView *verdictView;
    IBOutlet UIButton *patientWasBtn;
    NSString *setDateText;
    IBOutlet UITextField *dateField;
    NSDate *currentDate;
    NSString *dateString1;
    
    //FCheckBox *checkAllowMsg;
    BOOL checkboxSelected;

  /*  NSInteger *changeInt;
    id delegate;
    SEL selector;*/
    
   // NSInteger *choiseInt;
    
}
#pragma mark - property_View_1
// VIEW 1 ============================================================
@property (nonatomic, retain) IBOutlet UIView *View1;
@property (nonatomic, retain) IBOutlet UITextView *diagnosisView;
@property (nonatomic, retain) IBOutlet UITextView *complainView;
@property (nonatomic, retain) IBOutlet UITextView *anamnesisView;
@property (nonatomic, retain) IBOutlet UITextView *medicalHystoryView;

@property (nonatomic, retain) IBOutlet UIImageView *photoImg;

@property (nonatomic, retain) IBOutlet UITextView *nameField;
@property (nonatomic, retain) IBOutlet UITextView *birthField;
@property (nonatomic, retain) IBOutlet UITextView *genderField;
@property (nonatomic, retain) IBOutlet UITextView *addressField;
@property (nonatomic, retain) IBOutlet UITextView *phoneField;
@property (nonatomic, retain) IBOutlet UILabel *nextVisitLabel;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar1;
@property (nonatomic, retain) RootViewController *homePage;
@property (nonatomic, retain) IBOutlet UILabel *currentDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentDayLabel;

- (IBAction) goHomeBtn;
- (IBAction) takePhotoBtn;
- (IBAction) doCancelBtn;
//-(void)closeController;


#pragma mark - property_View_2
// VIEW 2 ==================================================================
@property (nonatomic,retain)IBOutlet UIView *View2;
@property (nonatomic,retain)IBOutlet UILabel *notesLabel;
@property (nonatomic,retain)IBOutlet UITextView *notesView;
@property (nonatomic,retain)IBOutlet UIImageView *jawImg;

@property (nonatomic,retain)IBOutlet UIButton *doBtn18;
@property (nonatomic,retain)IBOutlet UIButton *doBtn17;
@property (nonatomic,retain)IBOutlet UIButton *doBtn16;
@property (nonatomic,retain)IBOutlet UIButton *doBtn15;
@property (nonatomic,retain)IBOutlet UIButton *doBtn14;
@property (nonatomic,retain)IBOutlet UIButton *doBtn13;
@property (nonatomic,retain)IBOutlet UIButton *doBtn12;
@property (nonatomic,retain)IBOutlet UIButton *doBtn11;

@property (nonatomic,retain)IBOutlet UIButton *doBtn21;
@property (nonatomic,retain)IBOutlet UIButton *doBtn22;
@property (nonatomic,retain)IBOutlet UIButton *doBtn23;
@property (nonatomic,retain)IBOutlet UIButton *doBtn24;
@property (nonatomic,retain)IBOutlet UIButton *doBtn25;
@property (nonatomic,retain)IBOutlet UIButton *doBtn26;
@property (nonatomic,retain)IBOutlet UIButton *doBtn27;
@property (nonatomic,retain)IBOutlet UIButton *doBtn28;

@property (nonatomic,retain)IBOutlet UIButton *doBtn48;
@property (nonatomic,retain)IBOutlet UIButton *doBtn47;
@property (nonatomic,retain)IBOutlet UIButton *doBtn46;
@property (nonatomic,retain)IBOutlet UIButton *doBtn45;
@property (nonatomic,retain)IBOutlet UIButton *doBtn44;
@property (nonatomic,retain)IBOutlet UIButton *doBtn43;
@property (nonatomic,retain)IBOutlet UIButton *doBtn42;
@property (nonatomic,retain)IBOutlet UIButton *doBtn41;

@property (nonatomic,retain)IBOutlet UIButton *doBtn31;
@property (nonatomic,retain)IBOutlet UIButton *doBtn32;
@property (nonatomic,retain)IBOutlet UIButton *doBtn33;
@property (nonatomic,retain)IBOutlet UIButton *doBtn34;
@property (nonatomic,retain)IBOutlet UIButton *doBtn35;
@property (nonatomic,retain)IBOutlet UIButton *doBtn36;
@property (nonatomic,retain)IBOutlet UIButton *doBtn37;
@property (nonatomic,retain)IBOutlet UIButton *doBtn38;


-(IBAction) startClickBtn: (id) sender;
@property (nonatomic, assign) id <toothDetailDeleg> delegate;




#pragma mark - property_View_3
// VIEW 3 ==================================================================
@property(nonatomic,retain) IBOutlet UIView *View3;
@property(nonatomic,retain) IBOutlet UIDatePicker *nextMeetPicker;
@property(nonatomic,retain) IBOutlet UITextView *verdictView;
@property(nonatomic,retain) IBOutlet UIButton *patientWasBtn;
@property(nonatomic,retain) IBOutlet NSString *setDateText;
@property(nonatomic,retain) IBOutlet UITextField *dateField;
@property(nonatomic,retain) IBOutlet NSDate *currentDate;
@property(nonatomic,retain) IBOutlet NSString *dateString1;
@property(nonatomic,assign) BOOL checkboxSelected;


-(IBAction)checkRadioButton:(id)sender;
@property (nonatomic, assign) SEL selector;

//- (IBAction)doPatientWasBtn:(id)sender;

- (id) initWithDelegate:(id)aDelegate selector:(SEL)aSelector;


#pragma mark - Independent
// Independent ==================================================================
@property (nonatomic,retain) IBOutlet UIScrollView *myScroll;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) PatientSQL *patient;
@property (nonatomic, retain) UIImage *standartImg;
//-(void)doneAction:(id)sender;

- (void) layoutScrollPages;
-(IBAction)displayDate;

@end

@protocol toothDetailDeleg <NSObject>

-(void) showInfo;

@end
