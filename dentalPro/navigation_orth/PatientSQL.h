//
//  PatientSQL.h
//  navigation_orth
//
//  Created by Napoleon Bonapart on 05.01.12.
//  Copyright (c) 2012 FPMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RootViewController.h"
#import "navigation_orthAppDelegate.h"
#import "SQLiteAccess.h"
#import "EditingView.h"

@class SQLiteAccess;
@interface PatientSQL : NSObject {
    //sqlite3 *database;
    NSInteger primaryKey;
    
    //patients
    NSString *name;
    NSString *phone;
    UIImage  *photo;
    NSString *meetTime;
    NSString *addressText;
    NSString *genderText;
    NSString *patientBDayText;
    NSData *dataPhoto;
    
    //Visit
    NSString *verdictText;
    NSString *diagnosisText;
    NSString *complainsText;
    NSString *anamnesisText;
    NSString *medHistoryText;
    NSString *completeDate;
    NSNumber *checkedBool;
    
}

@property (assign, nonatomic) NSInteger primaryKey;
//Patients
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) UIImage *photo;
@property (copy, nonatomic) NSData *dataPhoto;
@property (copy, nonatomic) NSString *meetTime;
@property (copy, nonatomic) NSString *addressText;
@property (copy, nonatomic) NSString *genderText;
@property (copy, nonatomic) NSString *patientBDayText;
//Visit
@property (copy, nonatomic) NSString *completeDate;
@property (copy, nonatomic) NSString *verdictText;
@property (copy, nonatomic) NSString *diagnosisText;
@property (copy, nonatomic) NSString *complainsText;
@property (copy, nonatomic) NSString *anamnesisText;
@property (copy, nonatomic) NSString *medHistoryText;
@property (copy, nonatomic) NSNumber *checkedBool;



+(void)finalizeStatements;
-(id)initWithIdentifier:(NSInteger)idKey database:(sqlite3 *)db;
-(void)readRecord;
-(void)updateRecordPatients;//:(sqlite3 *)db;
-(void)insertIntoDatabase:(sqlite3 *)db;
-(void)deleteFromDatabase;//:(sqlite3 *)db;

//take info from databases
//- (id)initWithUniqueId:(int)un name:(NSString *)n phone: (NSString *)p photo:(NSString*)ph time:(NSString *)t;

//- (id)initWithUniqueId:(int)uniquePatientId nameText:(NSString *)patientName phoneText:(NSString *)patientPhone photoText:(NSString *)patientPhoto  addressText:(NSString *)patientAddress genderText:(NSString *)patientGender patientBDayText:(NSString *)patientBDay uniqueToothId:(int)idTooth toothNum:(NSInteger *)toothNumber toothQuart:(NSInteger *)toothQuarter uniqueHistoryId:(int)idHistory commentText:(NSString *)comment historyDate:(NSDate *)historyD uniqueStateId:(int)idState  stateNameText:(NSString *)stateName uniqueVisitId:(int)idVisit verdictText:(NSString *)verdict completeDate:(NSDate *)complete diagnosisText:(NSString *) patientDiagnosis complainsText:(NSString *) complains anamnesisText:(NSString *)anamnesis medHistoryText:(NSString *)patientMedHistory;

@end
