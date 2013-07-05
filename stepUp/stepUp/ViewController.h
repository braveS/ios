//
//  ViewController.h
//  stepUp
//
//  Created by Mob Industry on 7/4/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "M13Checkbox.h"
#import "SVProgressHUD.h"

@interface ViewController : UIViewController <UITextViewDelegate>{
    __block int stepCounter;
    float thresholdMAX;
}

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitcher;
@property (weak, nonatomic) IBOutlet UITextView *debugTextView;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) M13Checkbox *holdDeviceBtn;


- (IBAction)toggleSwitcher:(id)sender;
- (IBAction)shareWithTwitter:(id)sender;
@end
