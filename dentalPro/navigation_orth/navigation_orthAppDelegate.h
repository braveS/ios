//
//  navigation_orthAppDelegate.h
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RootViewController.h"
#import "SQLiteAccess.h"

@class EditingView;
@class PatientSQL;

@interface navigation_orthAppDelegate : NSObject <UIApplicationDelegate>{
	
    NSInteger primaryKey;
    NSNumber *primaryKeyNum;
    sqlite3 *database;
	// Array to store the objects
	NSMutableArray *patients;
    IBOutlet UIWindow *window;
    IBOutlet UINavigationController *navigationController;
}
@property (assign, nonatomic) NSInteger primaryKey;
@property (nonatomic, retain) NSNumber *primaryKeyNum;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *patients;

-(void)createEditableCopyOfDatabaseIfNeeded;
-(void)initializeDatabase;
-(void)updateOrAddRecordIntoDatabase:(PatientSQL *) patient;
-(void) deleteRowFromDatabase: (PatientSQL *) patient; 

@end
