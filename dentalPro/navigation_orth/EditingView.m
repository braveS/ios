//
//  EditingView.m
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import "EditingView.h"
//#import "RegexKitLite.h"
#import "PatientSQL.h"
#import "navigation_orthAppDelegate.h"
#import "InfoView.h"
//#import "FCheckBox.h"

#define SCROLLVIEW_CONTENT_HEIGHT 833
#define SCROLLVIEW_CONTENT_WIDTH  768
#define NUM_PAGES 3

@implementation EditingView
@synthesize diagnosisView, complainView, anamnesisView, medicalHystoryView, photoImg,nameField, genderField, birthField, addressField, phoneField,nextVisitLabel,
    navBar1,homePage,currentDayLabel, currentDateLabel,notesView, notesLabel, jawImg,
    doBtn11, doBtn12, doBtn13, doBtn14, doBtn15, doBtn16, doBtn17,doBtn18,doBtn21, doBtn22, doBtn23, doBtn24, doBtn25, doBtn26,doBtn27, doBtn28, doBtn31, doBtn32, doBtn33, doBtn34, doBtn35,doBtn36,doBtn37,doBtn38,doBtn41,doBtn42,doBtn43,doBtn44,doBtn45,doBtn46,doBtn47,doBtn48,
    nextMeetPicker, verdictView, patientWasBtn, setDateText, dateField, currentDate,dateString1,delegate, selector,
    View1, View2, View3, 
    myScroll, pageControl,patient,standartImg,checkboxSelected;

-(void) dealloc{
    [myScroll release];
    [pageControl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // view 1 
    NSDate *now = [NSDate date]; //Set the current Date
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:now];
    NSDateFormatter *dateFormat2 = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat2 setDateFormat:@"EEEE"];
    NSString *dayString2 = [dateFormat2 stringFromDate:now];
    currentDateLabel.text = dateString;
    currentDayLabel.text  = dayString2;
    
    //[photoImg setImage:[UIImage imageNamed:@"nophoto.png"]];
    self.title = @"Visit";
    
    //set tags for views:
    [genderField setTag:111];
    [birthField setTag:222];
    [phoneField setTag:333];
    [nameField setTag:444];
    [addressField setTag:555];
    [diagnosisView setTag:666];
    [complainView  setTag:777];
    [medicalHystoryView setTag:888];
    [anamnesisView setTag:999];
    
    //keyboard types
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    birthField.keyboardType = UIKeyboardTypeNumberPad; 
    //end$
    //---------------------------------------------------------------
    
    //view 2
    jawImg.image = [UIImage imageNamed:@"teeth.png"];
    [jawImg release];
    
    // Set tags for each tooth-button
    doBtn18.tag = 18;
    doBtn17.tag = 17;
    doBtn16.tag = 16;
    doBtn15.tag = 15;
    doBtn14.tag = 14;
    doBtn13.tag = 13;
    doBtn12.tag = 12;
    doBtn11.tag = 11;
    
    doBtn21.tag = 21;
    doBtn22.tag = 22;
    doBtn23.tag = 23;
    doBtn24.tag = 24;
    doBtn25.tag = 25;
    doBtn26.tag = 26;
    doBtn27.tag = 27;
    doBtn28.tag = 28;
    
    doBtn31.tag = 31;
    doBtn32.tag = 32;
    doBtn33.tag = 33;
    doBtn34.tag = 34;
    doBtn35.tag = 35;
    doBtn36.tag = 36;
    doBtn37.tag = 37;
    doBtn38.tag = 38;

    doBtn41.tag = 41;
    doBtn42.tag = 42;
    doBtn43.tag = 43;
    doBtn44.tag = 44;
    doBtn45.tag = 45;
    doBtn46.tag = 46;
    doBtn47.tag = 47;
    doBtn48.tag = 48;
    //---------------------------------------------------------
    
    //view 3
    
	//checkboxSelected = 0;
    
    //---------------------------------------------------------
    
    //Independent
    [myScroll setCanCancelContentTouches:NO]; //Set methods for Scroll (myScroll)
	[myScroll setBackgroundColor:[UIColor blackColor]]; //Set background
    myScroll.scrollEnabled = YES; // important
    myScroll.pagingEnabled = YES; // very important
    
    //add our subviews into scroll View
    [myScroll addSubview:View1];
    [myScroll addSubview:View2];
    [myScroll addSubview:View3];
    
    [self layoutScrollPages]; // important method
    
    
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
}

//===========================================
#pragma mark - Independent
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.myScroll.frame.size.width;
    int page = floor((self.myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void) layoutScrollPages {
	UIView *view = nil;
	NSArray *subviews = [myScroll subviews];
	CGFloat curXLoc = 0;
	for (view in subviews) {
		if ([view isKindOfClass:[UIView class]] && view.tag > 0) {
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			curXLoc += [UIScreen mainScreen].applicationFrame.size.width;
            pageControl.currentPage= view.tag ;
        }
	}
    [myScroll setContentSize:CGSizeMake((NUM_PAGES * [UIScreen mainScreen].applicationFrame.size.width), [myScroll bounds].size.height)];
}

-(IBAction)goHomeBtn {
    //NSLog(@"saaab =%i",patient.primaryKey);
    
    if (displayKeyboard) {
        //put the frame with scrollView to it's first place
        myScroll.frame = CGRectMake(0, 138, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
        myScroll.contentOffset =offset;
        displayKeyboard = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction) doCancelBtn{
    if (displayKeyboard) {
        //put the frame with scrollView to it's first place
        myScroll.frame = CGRectMake(0, 138, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
        myScroll.contentOffset =offset;
        displayKeyboard = NO;
    }
    btnPressed = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated {    
	[super viewWillAppear:animated];

    //listen to keyboard
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillHide:) name: UIKeyboardWillHideNotification object:nil];
    
    if (displayKeyboard) {
        //put the frame with scrollView to it's first place
        myScroll.frame = CGRectMake(0, 138, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
        myScroll.contentOffset =offset;
        displayKeyboard = NO;
    }
    
    btnPressed = NO;
	displayKeyboard = NO;
    nameField.text = patient.name;
    phoneField.text = patient.phone;
    NSLog(@"photo is edit appear %@",patient.photo);
    if (patient.photo == nil) {
        [photoImg setImage:[UIImage imageNamed:@"nophoto.png"]];
        NSLog(@"was here");
    }
    else [photoImg setImage:patient.photo];
    genderField.text = patient.genderText;
    addressField.text = patient.addressText;
    birthField.text = patient.patientBDayText;
    diagnosisView.text = patient.diagnosisText;
    complainView.text = patient.complainsText;
    anamnesisView.text = patient.anamnesisText;
    medicalHystoryView.text = patient.medHistoryText;
    verdictView.text = patient.verdictText;
    //nextMeetPicker = patient.completeDate;
    if ((patient.completeDate = NULL)){
        NSDate *now = [NSDate date]; //Set the current Date
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"HH:mm aaa EEE, MMM d"];
        NSString *dateStr = [dateFormat1 stringFromDate:now];
        dateField.text = dateStr;
        [dateFormat1 release];
        [dateStr release];
        //NSLog(@"patient COMPLETEDATE = NULL");
    } else {
        dateField.text=patient.completeDate;
    }
    NSInteger currValue = [patient.checkedBool integerValue];
    if (currValue == 1) {
        [patientWasBtn setSelected:YES];
		checkboxSelected = 1;
    } else {
        [patientWasBtn setSelected:NO];
		checkboxSelected = 0;
    }

}

// Вызываем процедуру окончания редактирования на случай закрытия окна ViewControlle
-(void) viewWillDisappear:(BOOL)animated {
    if  (btnPressed == NO) {
        navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
        standartImg = [UIImage imageNamed:@"nophoto.png"];
        NSLog(@"photo is edit disappear %@",patient.photo);
        NSLog(@"photoImg is edit disappear %@",photoImg);
        
        patient.name = nameField.text;
        patient.phone = phoneField.text;
        if (patient.photo == NULL) {
            //NSData *currImageData =  UIImagePNGRepresentation(standartImg);
            patient.photo = standartImg;
            //NSLog(@"path to photo here = %@", currImageData);\        
            NSLog(@"was here too");
        }
        NSLog(@"photo is edit disappear curr image  %@",patient.photo);
        
        patient.genderText = genderField.text;
        patient.addressText = addressField.text;
        patient.patientBDayText = birthField.text;
        patient.diagnosisText = diagnosisView.text;
        patient.complainsText = complainView.text;
        patient.anamnesisText = anamnesisView.text;
        patient.medHistoryText = medicalHystoryView.text;
        patient.verdictText = verdictView.text;
        //patient.completeDate = nextMeetPicker;
        if (dateField.text!=nil) {
            patient.completeDate = dateField.text;
            //NSLog(@"dateF %@",dateField.text);
        }
        
        //NSLog(@"sda %i",patient.primaryKey);
        if (patient.primaryKey == 0){
            NSInteger currValue = [appDelegate.primaryKeyNum integerValue];
            currValue +=1;
            patient.primaryKey =currValue;
            //NSLog(@"sad =%i",patient.primaryKey);
        }
        //navigation_orthAppDelegate *appDelegate = ( navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate ];
        
        if (checkboxSelected == 1) {
            [patientWasBtn setSelected:YES];
            patient.checkedBool = [NSNumber numberWithInteger:checkboxSelected];
        } else {
            patient.checkedBool = [NSNumber numberWithInteger:checkboxSelected];
        }
        
        [appDelegate updateOrAddRecordIntoDatabase:self.patient];        
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

-(void) textViewDidEndEditing:(UITextView *)textView {
    
}

-(void) keyboardWillShow: (NSNotification *)notif {
    //asks - if keyboard has already shown
    if (displayKeyboard) {
        return;
	}
    
    //set scrollView settings
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	offset = myScroll.contentOffset;
	
    CGRect viewFrame = myScroll.frame;
	viewFrame.size.height -= keyboardSize.height;
	myScroll.frame = viewFrame;
	CGRect textFieldRect;
    
    
    if (tTag==888) {
        textFieldRect = [medicalHystoryView frame]; //set the frame of field, when keyboard appears**
    }
    
    textFieldRect.origin.y += 200; //scroll when keyboard appears
    [myScroll scrollRectToVisible: textFieldRect animated:YES];// add animation
    
    displayKeyboard = YES;
}

-(void) keyboardWillHide: (NSNotification *)notif {
	if (!displayKeyboard) {
		return; 
	}
    //put the frame with scrollView to it's first place
	myScroll.frame = CGRectMake(0, 138, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	myScroll.contentOffset =offset;
    //end$
	displayKeyboard = NO;
}

/*
 - (void)textViewDidBeginEditing:(UITextView *)textView // make limits for  UITextView's field content
 {
 if (tTag == 111) {maxTextFieldCount=5; minTextFieldCount = 1;}
 if (tTag == 222) {maxTextFieldCount=16; minTextFieldCount = 1;}
 if (tTag == 333) {maxTextFieldCount=55; minTextFieldCount = 1;}
 if (tTag == 444) {maxTextFieldCount=60; minTextFieldCount = 1;}
 if (tTag == 555) {maxTextFieldCount=60; minTextFieldCount = 1;}
 }*/

//===========================================
#pragma mark - VIEW_1

-(IBAction)takePhotoBtn{
    //empty - choose the photo
}


//===========================================
#pragma mark - VIEW_2

/*
 -(InfoView *)infoFrameText {
 
 }*/

- (IBAction) startClickBtn:(id) sender{
    
    // [pop presentPopoverFromRect:doBtn18.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    //make actions for each button
    if ([sender tag] == 18){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"HEllo;";
        [pop setDelegate:self];    
        
        [pop presentPopoverFromRect:doBtn18.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    if ([sender tag] == 17){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Another text here;";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn17.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 16){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        [pop setDelegate:self];    
        infoView.someText.text = @"Caries";
        [pop presentPopoverFromRect:doBtn16.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 15){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn15.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 14){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn14.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 13){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn13.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 12){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn12.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 11){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn11.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    
    
    if ([sender tag] == 21){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn21.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 22){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn22.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 23){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn23.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 24){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn24.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 25){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn25.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 26){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn26.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 27){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn27.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 28){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn28.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    
    
    if ([sender tag] == 31){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn31.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 32){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn32.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 33){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn33.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 34){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn34.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 35){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn35.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 36){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn36.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 37){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn37.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 38){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn38.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 41){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn41.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 42){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn42.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 43){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn43.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 44){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn44.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 45){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn45.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 46){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn46.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 47){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn47.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
    if ([sender tag] == 48){
        InfoView * infoView = [[InfoView alloc] init];
        UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:infoView];
        infoView.someText.text = @"Caries";
        [pop setDelegate:self];    
        [pop presentPopoverFromRect:doBtn48.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [infoView release];  
    }
}


#pragma mark - VIEW_3
- (id) initWithDelegate:(id)aDelegate selector:(SEL)aSelector {
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
        self.selector = aSelector;
    }
    return self;
}

-(IBAction)checkRadioButton:(id)sender
{
    if (checkboxSelected == 0){
		[patientWasBtn setSelected:YES];
		checkboxSelected = 1;
	} else {
		[patientWasBtn setSelected:NO];
		checkboxSelected = 0;
	}
}

/*
- (IBAction)doPatientWasBtn:(id)sender{
    [self performSelector:@selector(flipButton) withObject:nil afterDelay:0.0];
}


-(void) flipButton {
    if ( self.patientWasBtn.selected ) {
        self.patientWasBtn.highlighted = NO;
        self.patientWasBtn.selected = NO;
    } else {
        self.patientWasBtn.highlighted = YES;
        self.patientWasBtn.selected = YES;
    }
}
*/

-(IBAction)displayDate{
    NSDate * selected = [nextMeetPicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm aaa EEE, MMM d"];
    dateString1 = [dateFormat stringFromDate:selected];
	dateField.text = dateString1;
    
    currentDate = [dateFormat dateFromString:dateString1];
    //NSLog(@"dateString= %@", dateString1);
    NSLog(@"currDate= %@", currentDate);
    
    [dateFormat release];
    //[dateString1 release];
}


#pragma mark - View lifecycle - END
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end