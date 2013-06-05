//
//  RootViewController.h
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingView.h"
#import "someCell.h"
#import "SQLiteAccess.h"
//#import "navigation_orthAppDelegate.h"

@class EditingView;
@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *sceduleTable;
    IBOutlet UINavigationBar *mainBar;
    IBOutlet UILabel *currentDateLabel;
    IBOutlet UILabel *currentDayLabel;
    EditingView *editViewController;    
}
@property (nonatomic, retain)  IBOutlet UINavigationBar *mainBar;
@property (nonatomic, retain)  IBOutlet UITableView *sceduleTable;
@property (nonatomic, retain)  IBOutlet UILabel *currentDateLabel;
@property (nonatomic, retain)  IBOutlet UILabel *currentDayLabel;

- (IBAction) addRecord;
- (IBAction) deleteRecord;

@end
