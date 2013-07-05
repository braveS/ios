//
//  ViewController.m
//  stepUp
//
//  Created by Mob Industry on 7/4/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()
@property (strong, nonatomic) ACAccountStore *accountStore;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //create first checkbox
    self.holdDeviceBtn = [M13Checkbox new];
    self.holdDeviceBtn.frame = CGRectMake(256.0f, 288.0f, 34.0f, 25.0f);
    [self.view addSubview:self.holdDeviceBtn];
    
    //threshold for check
    thresholdMAX = 0.99;

    self.accountStore = [ACAccountStore new];
}


- (IBAction)toggleSwitcher:(id)sender {
    if (self.mySwitcher.on) {
        if(self.holdDeviceBtn.checkState == M13CheckboxStateChecked){
            [self showHUD];
        }
        [self callAccelerometer];
    } else {
        [self.motionManager stopAccelerometerUpdates];
        self.shareBtn.hidden = NO;
    }
}

- (void) callAccelerometer {
    self.motionManager = [CMMotionManager new];
    NSOperationQueue *queue = [NSOperationQueue new];
    if(self.motionManager.accelerometerAvailable){
        self.motionManager.accelerometerUpdateInterval = 1.0f/1.2f;
        stepCounter = 0;
        __block float myOldAccX = 0.000001f;
        __block float myOldAccY = 0.000001f;
        __block float myOldAccZ = 0.000001f;
        __block float myOldReg = 0.000001f;
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            NSString *str;
            if(error){
                [self.motionManager stopAccelerometerUpdates];
                str = [NSString stringWithFormat:@"error occured: %@", error];
            } else {
                float xx = accelerometerData.acceleration.x;
                float yy = accelerometerData.acceleration.y;
                float zz = accelerometerData.acceleration.z;
                float reg = (myOldAccX * xx) + (myOldAccY * yy) + (myOldAccZ * zz);
                float a = ABS(sqrt(myOldAccX * myOldAccX + myOldAccY * myOldAccY + myOldAccZ * myOldAccZ));
                float b = ABS(sqrt(xx * xx + yy * yy + zz * zz));
                reg /= (a * b);
                reg = ABS(reg);
                char cReg[256];
                char cOldReg[256];
                sprintf(cOldReg, "%.1f",myOldReg);
                sprintf(cReg, "%.1f",reg);
                if(reg < thresholdMAX && !(strcmp(cReg, cOldReg))){
                    stepCounter++;
                    myOldAccX = xx;
                    myOldAccY = yy;
                    myOldAccZ = zz;
                }
                myOldReg = reg;
                str = [NSString stringWithFormat:@"Accelerometer statistics: \nx:%f \ny:%f \nz:%f \ndelta:%f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z,reg];
            }
//            DLog(@"%@",str);
            [self.debugTextView performSelectorOnMainThread:@selector(setText:) withObject:str waitUntilDone:YES];
            [self.outputLabel performSelectorOnMainThread:@selector(setText:) withObject:[[NSNumber numberWithInt:stepCounter] stringValue] waitUntilDone:YES];
        }];
    }

}

- (void)showHUD {
	[SVProgressHUD showWithStatus:@"Now put device into your pocket" maskType:SVProgressHUDMaskTypeGradient];
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:4.0f];
}

- (void) dismissHUD{
    [SVProgressHUD dismiss];
}

#pragma mark
#pragma mark Social - Twitter
- (BOOL) userHasAccessToTwitter {
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];        
}

- (void) fetchTimeLineForUser:(NSString*) username{
    if ([self userHasAccessToTwitter]) {
        ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [self.accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
            if(granted){
                NSArray *arrayWithTwitterData = [self.accountStore accountsWithAccountType:twitterAccountType];
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                                                  @"/1.1/statuses/user_timeline.json"];
                NSDictionary *parameters = @{@"screen_name": username,
                                             @"include_rts" : @"0",
                                             @"trim_user" : @"1",
                                             @"count" : @"1"};
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:parameters];
                
                [request setAccount:[arrayWithTwitterData lastObject]];
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if (responseData) {
                        if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                            NSError *jsonError;
                            NSDictionary *timeLineData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
                            
                            if (timeLineData) {
                                DLog(@"Timeline Response %@\n", timeLineData);
                            } else {
                                DLog(@"JSON error: %@", [jsonError localizedDescription]);
                            }
                        } else {
                            DLog(@"the response status is: %d",urlResponse.statusCode);
                        }
                    }
                }];
            } else {
                DLog(@"Error %@", [error localizedDescription]);
            }
        }];
    }
}

#pragma mark Buttons
//- (void) holdDeviceBtnChecked: (id) sender {
//    if (self.holdDeviceBtn.checkState == M13CheckboxStateChecked) {
////        thresholdMAX = 0.f;
////        thresholdMIN = 0.f;
//        
//    } else {
//        [self setStandartThreshold];
//    }
//}

- (IBAction)shareWithTwitter:(id)sender{
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result){
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
                
            default:
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:^{
                DLog(@"Twitter has been dismissed");
            }];
        });
    };

    [tweetSheet setInitialText:[NSString stringWithFormat:@"Test #%d", stepCounter]];

    [self presentViewController:tweetSheet animated:YES completion:^{
        DLog(@"Done!");
    }];
}

- (void)viewDidUnload {
    [self setDebugTextView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
