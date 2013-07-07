//
//  ViewController.h
//  test1906
//
//  Created by mobindus on 6/19/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *setFirstname;
@property (nonatomic, weak) IBOutlet UITextField *setLastname;
@property (nonatomic, weak) IBOutlet UIButton *setAgeBtn;
@property (nonatomic, weak) IBOutlet UIButton *saveBtn;
@property (nonatomic, weak) IBOutlet UIButton *showBtn;
@property (nonatomic, weak) IBOutlet UIDatePicker *setAgeDatePicker;
@property (nonatomic, strong) UIActionSheet *myActionSheet;
@property (nonatomic, weak) IBOutlet UISwitch *mySwitcher;

-(IBAction)doSaveIntoDatabase:(id)sender;
-(IBAction)doShowDetailView:(id)sender;
-(IBAction)doSetAge:(id)sender;
-(IBAction)toggleSwitch:(id)sender;

@end
