//
//  ViewController.m
//  test1906
//
//  Created by mobindus on 6/19/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "Person.h"
#import "DetailViewController.h"

#define kDefaulTime @"16:00"

@interface ViewController ()
@end

@implementation ViewController

@synthesize setFirstname;
@synthesize setLastname;
@synthesize setAgeBtn;
@synthesize setAgeDatePicker;
@synthesize saveBtn;
@synthesize showBtn;
@synthesize myActionSheet;
@synthesize mySwitcher;

- (void)viewDidLoad
{
    [super viewDidLoad];
    setAgeDatePicker.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) persistNewPersonWithFirstname:(NSString*)firstname lastname:(NSString*)lastname birthday:(NSString *)birthday{
    
//   NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    [NSManagedObjectContext MR_defaultContext];
    
    //create a new Person obj
    Person *person = [Person MR_createEntity];//]InContext:localContext];
    person.firstname = firstname;
    person.lastname = lastname;
    person.birthday = birthday;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    NSLog(@"%@",[NSBundle allBundles]);
}

#pragma mark -
#pragma mark Picker

-(void) showDatePickerView {
    [self.setAgeDatePicker addTarget:self action:@selector(updateBtnLabel) forControlEvents:UIControlEventValueChanged];
}

-(void)updateBtnLabel{
    NSString *string = @"16:00";
    NSDateFormatter *timeOnlyFormatter = [NSDateFormatter new];
    [timeOnlyFormatter setDateFormat:@"HH:MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[timeOnlyFormatter dateFromString:string]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSString *time = [NSString new];
    if (mySwitcher.on){
        [dateFormatter setDateFormat:@"dd MMMM yyyy"];
        time = [NSString stringWithFormat:@"%@, %@",[dateFormatter stringFromDate:self.setAgeDatePicker.date], kDefaulTime];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm"];
        time = [dateFormatter stringFromDate:self.setAgeDatePicker.date];
    }
    [self.setAgeBtn setTitle:time forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark buttons methods
-(IBAction)doSetAge:(id)sender{
    if(setAgeDatePicker.hidden){
        setAgeDatePicker.hidden = NO;
        [self showDatePickerView];
    } else {
        setAgeDatePicker.hidden = YES;
    }
}

-(IBAction)doSaveIntoDatabase:(id)sender{
    setAgeDatePicker.hidden = YES;
    NSString *firstname = [NSString string];
    firstname = setFirstname.text;
    
    NSString *lastname = [NSString new];
    lastname = setLastname.text;
    
    NSString *bday = [NSString new];
    bday = setAgeBtn.titleLabel.text;
    [self persistNewPersonWithFirstname:firstname lastname:lastname birthday:bday];
}

-(IBAction)toggleSwitch:(id)sender{
    if (mySwitcher.on){
        NSLog(@"SET OFF");
        setAgeDatePicker.datePickerMode =UIDatePickerModeDate;
    } else {
        NSLog(@"SET ON");
        setAgeDatePicker.datePickerMode =UIDatePickerModeDateAndTime;
    }
}

#pragma merk -
#pragma mark helpers

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
