//  PatientSQL.m
//  navigation_orth
//
//  Created by Napoleon Bonapart on 05.01.12.
//  Copyright (c) 2012 FPMSoft. All rights reserved.
//

#import "PatientSQL.h"
#import "SQLiteAccess.h"
#import <sqlite3.h>

@implementation PatientSQL
@synthesize primaryKey, name, phone, photo, meetTime;
@synthesize addressText, genderText, patientBDayText;
@synthesize completeDate, verdictText, diagnosisText, complainsText, anamnesisText, medHistoryText, checkedBool; 
@synthesize dataPhoto;

static sqlite3 *database;
static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *read_statement = nil;
static sqlite3_stmt *update_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *delete_statement = nil;

+(void)finalizeStatements {
    
    if (init_statement) sqlite3_finalize(init_statement);
    if (read_statement) sqlite3_finalize(read_statement);
    if (update_statement) sqlite3_finalize(update_statement);
    if (insert_statement) sqlite3_finalize(insert_statement);
    if (delete_statement) sqlite3_finalize(delete_statement);
    NSLog(@"DO FINALIZE");
}

// Инициализирует запись и читает для нее заголовок из базы
-(id)initWithIdentifier:(NSInteger)idKey database:(sqlite3 *)db {
    if (self = [super init]) {
        database = db;
        primaryKey = idKey;
        //NSLog(@"PIR 1= %i",primaryKey);
        // Инициализуем переменную init_statement при первом вызове метода
        if (init_statement == nil) {
            // Подготавливаем запрос перед отправкой в базу данных
            const char *sql = "SELECT patients.PatientName, patients.PatientPhone, patients.PhotoPath, patients.PatientMeetTime, visit.PatientDiagnosis, visit.PatientComplain, visit.Checked FROM patients JOIN visit ON patients.PatientId=visit.PatientId WHERE patients.PatientId=?";
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(NO, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
        //NSLog(@"PrimaryKeyCount =%i", self.primaryKey);
        // Подставляем значение в запрос
        sqlite3_bind_int(init_statement, 1, self.primaryKey);
        //NSLog(@"PIR 2= %i",primaryKey);
        // Получаем результаты выборки
        if (sqlite3_step(init_statement) == SQLITE_ROW) {
            // NSLog(@"ROW, indentify");
            //if (sqlite3_step(init_statement) != SQLITE_NULL){ 
            if((char*)sqlite3_column_text(init_statement, 0) != NULL)
            self.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
            else self.name = @"Tap here to make a note";
            
            if((char*)sqlite3_column_text(init_statement, 1) != NULL)
            self.phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
            else self.phone = @"tap to edit phone number";
            
            /*if ((char*) sqlite3_column_text(init_statement, 2) != NULL) 
                self.photo = [NSString stringWithUTF8String:(char *) sqlite3_column_text(init_statement, 2)];
            else self.photo = [[NSBundle mainBundle] pathForResource:@"Tnophotol" ofType:@"png"];
            NSLog(@"self.photo =%@",);*/
            
            dataPhoto = [[NSData alloc] initWithBytes:sqlite3_column_blob(init_statement, 2) length:sqlite3_column_bytes(init_statement, 2)];
            //NSLog(@"dataPhotoInit %@", dataPhoto);
            if(dataPhoto == NULL) {
                NSLog(@"No image found.");
                self.photo = [UIImage imageNamed:@"nophoto.png"];
            } else
                self.photo = [UIImage imageWithData:dataPhoto];
            NSLog(@"photo is init%@",self.photo);
            
            
            if((char*)sqlite3_column_text(init_statement, 3) != NULL)
                self.meetTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
            else self.meetTime = @"set-time";
           // NSLog(@"Comin in - init -- meet %@", meetTime);
        
            if((char*)sqlite3_column_text(init_statement, 4) != NULL)
                self.diagnosisText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 4)];
            else
                self.diagnosisText = @"set-Diagnosis";
            
            if((char*)sqlite3_column_text(init_statement, 5) != NULL)
                self.complainsText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 5)];
            else
                self.complainsText = @"set-Complains";
            
            if ((int *) sqlite3_column_int(init_statement, 6) != NULL)
                self.checkedBool = [NSNumber numberWithInteger:(NSInteger ) sqlite3_column_int(init_statement, 6)];
            NSLog(@"self.checkedBool =%@",self.checkedBool);
            
        //}
        }
        else NSLog(@"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Сбрасываем подготовленное выражение для повторного использования
        sqlite3_reset(init_statement);
    }
    return self;
}

// Читает полный текст записи из базы
-(void)readRecord{
    //NSLog(@"Comin in - READRECORD");
    if (read_statement == nil) {
        const char *sql = "SELECT patients.PatientName, patients.PatientPhone, patients.PatientMeetTime, patients.PatientGender, patients.PatientAddress, patients.PatientBDay, visit.PatientDiagnosis, visit.PatientComplain, visit.PatientAnamnesis, visit.PatientMedHistory, visit.Verdict, visit.Complete, visit.Checked FROM patients JOIN visit ON patients.PatientId=visit.PatientId WHERE patients.PatientId=?";
        //NSLog(@"Comin in - READRECORD const char");
        if (sqlite3_prepare_v2(database, sql, -1, &read_statement, NULL) != SQLITE_OK) {
            NSLog(@"Comin in - READRECORD -- ERROR");
            NSAssert1(NO, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
    sqlite3_bind_int(read_statement, 1, self.primaryKey);
    //NSLog(@"PIR 3= %i",primaryKey);
   
    if (sqlite3_step(read_statement) == SQLITE_ROW) {
        
        self.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 0)];
        
        self.phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 1)];

        NSLog(@"photo is read %@",self.photo);

        if((char*)sqlite3_column_text(read_statement, 2) != NULL)
        self.meetTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 2)];
        else
        self.meetTime = @"set-time";      
        
        if((char*)sqlite3_column_text(read_statement, 3) != NULL)
            self.genderText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 3)];
        else
            self.genderText = @"set-gender";
        
        if((char*)sqlite3_column_text(read_statement, 4) != NULL)
            self.addressText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 4)];
        else
            self.addressText = @"set-address";
        
        if((char*)sqlite3_column_text(read_statement, 5) != NULL)
            self.patientBDayText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 5)];
        else
            self.patientBDayText = @"set-BDay";
        
        if((char*)sqlite3_column_text(read_statement, 6) != NULL)
            self.diagnosisText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 6)];
        else
            self.diagnosisText = @"set-Diagnosis";
        
        if((char*)sqlite3_column_text(read_statement, 7) != NULL)
            self.complainsText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 7)];
        else
            self.complainsText = @"set-complains";
        
        if((char*)sqlite3_column_text(read_statement, 8) != NULL)
            self.anamnesisText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 8)];
        else
            self.anamnesisText = @"set-anamnesis";
        
        if((char*)sqlite3_column_text(read_statement, 9) != NULL)
            self.medHistoryText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 9)];
        else
            self.medHistoryText = @"set-history";
        
        if((char*)sqlite3_column_text(read_statement, 10) != NULL)
            self.verdictText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 10)];
        else
            self.verdictText = @"set-verdict";
        
        if((char*)sqlite3_column_text(read_statement, 11) != NULL)
            self.completeDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(read_statement, 11)];
        
        else{
            NSLog(@"coming in the Date ELSE");
            NSDate *now = [[NSDate date] autorelease];
            NSDateFormatter *dateF = [[[NSDateFormatter alloc] init] autorelease];
            [dateF setDateFormat:@"HH:mm aaa EEE, MMM d"];
            NSString *dateS = [dateF stringFromDate:now];
            self.completeDate = dateS;
        }   
        
        if ((int *) sqlite3_column_int(read_statement, 12) != NULL)
            self.checkedBool  = [NSNumber numberWithInteger:(NSInteger ) sqlite3_column_int(read_statement, 12)];
        NSLog(@"self.checkedBool read =%@",self.checkedBool);

    }
    
    sqlite3_reset(read_statement);
}

// Обновляет значение записи в базе
-(void)updateRecordPatients{//:(sqlite3 *)db {
    
    //NSLog(@"photo.self =%@",self.photo);
    dataPhoto =  UIImagePNGRepresentation(self.photo);
    //NSData *imageData = UIImagePNGRepresentation(drawImage.image);
    /*NSUInteger len = [dataPhoto length];
    Byte * byteData = (Byte*)malloc(len);
    memcpy(byteData, [dataPhoto bytes], len);*/
    
    /*int returnValue = sqlite3_bind_blob(update_statement, 3, [imgData bytes], [imgData length], NULL);*/
    // dataPhoto = [NSData dataWithData:];
    //NSData *imageData = [NSData dataWithData: UIImagePNGRepresentation(self.photo)];
    //NSLog(@"dataPhotoLog =%@",imageData);

    [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"UPDATE patients SET PatientName='%@', PatientPhone='%@', PhotoPath='%@', PatientMeetTime='%@', PatientGender='%@', PatientAddress='%@', PatientBDay='%@' WHERE PatientId='%i'; UPDATE visit SET PatientDiagnosis='%@', PatientComplain='%@', PatientAnamnesis='%@', PatientMedHistory='%@', Verdict='%@', Complete='%@', Checked='%@' WHERE PatientId='%i'", self.name, self.phone,self.dataPhoto, self.meetTime, self.genderText, self.addressText, self.patientBDayText, self.primaryKey,self.diagnosisText,  self.complainsText, self.anamnesisText, self.medHistoryText, self.verdictText, self.completeDate, self.checkedBool, self.primaryKey ]];
    
    
    
    NSLog(@"UPDATE --- SECOND TABLE");
    NSLog(@"PIR 4= %i",primaryKey);
    //  NSLog(@"COMPLETE_DATE =%@", self.completeDate);
    
    NSLog([NSString stringWithFormat:@"UPDATE patients SET PatientName='%@', PatientPhone='%@', PhotoPath='%@', PatientMeetTime='%@', PatientGender='%@', PatientAddress='%@', PatientBDay='%@' WHERE PatientId='%i'; UPDATE visit SET PatientDiagnosis='%@', PatientComplain='%@', PatientAnamnesis='%@', PatientMedHistory='%@', Verdict='%@', Complete='%@', Checked='%@' WHERE PatientId='%i'", self.name, self.phone,self.dataPhoto, self.meetTime, self.genderText, self.addressText, self.patientBDayText, self.primaryKey,self.diagnosisText,  self.complainsText, self.anamnesisText, self.medHistoryText, self.verdictText, self.completeDate, self.checkedBool, self.primaryKey ]);
    
    sqlite3_reset(update_statement);
}

// Добавляет новую запись в базу
-(void)insertIntoDatabase:(sqlite3 *)db {
    
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //NSLog(@"aaa %@", appDelegate.primaryKeyNum);
    dataPhoto =  UIImagePNGRepresentation(self.photo);
    NSLog(@"dataPhotoLog =%@",dataPhoto);
    
   /* NSUInteger len = [dataPhoto length];
    Byte * byteData = (Byte*)malloc(len);
    memcpy(byteData, [dataPhoto bytes], len);*/

    NSInteger currValue = [appDelegate.primaryKeyNum integerValue];
    currValue +=1;
    [SQLiteAccess insertWithSQL:[NSString stringWithFormat:@"INSERT INTO patients(PatientName, PatientPhone, PhotoPath, PatientMeetTime, PatientGender, PatientAddress, PatientBDay)  VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@') ; INSERT INTO visit(PatientDiagnosis, PatientComplain, PatientAnamnesis, PatientMedHistory, Verdict, Complete, Checked, PatientId) VALUES('%@', '%@', '%@', '%@', '%@', '%@','%@', '%i')", self.name, self.phone, self.dataPhoto, self.meetTime, self.genderText, self.addressText, self.patientBDayText,self.diagnosisText, self.complainsText, self.anamnesisText, self.medHistoryText, self.verdictText,self.completeDate,self.checkedBool, currValue]];
    
    appDelegate.primaryKeyNum = [NSNumber numberWithInteger:currValue];
    //NSLog(@"trollFace =%@",appDelegate.primaryKeyNum);
    //NSLog(@"trollFuu= %i",self.primaryKey);
    NSLog([NSString stringWithFormat:@"INSERT INTO patients(PatientName, PatientPhone, PhotoPath, PatientMeetTime, PatientGender, PatientAddress, PatientBDay)  VALUES('%@', '%@', '%@', '%@', '%@', '%@', '%@') ; INSERT INTO visit(PatientDiagnosis, PatientComplain, PatientAnamnesis, PatientMedHistory, Verdict, Complete, Checked, PatientId) VALUES('%@', '%@', '%@', '%@', '%@', '%@','%@', '%i')", self.name, self.phone, self.dataPhoto, self.meetTime, self.genderText, self.addressText, self.patientBDayText,self.diagnosisText, self.complainsText, self.anamnesisText, self.medHistoryText, self.verdictText,self.completeDate,self.checkedBool, currValue]);
    
    sqlite3_reset(insert_statement);
}

-(void)deleteFromDatabase{//:(sqlite3 *)db {
   /* [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"DELETE PatientName='%@', PatientPhone='%@', PhotoPath='%@', PatientMeetTime='%@', PatientGender='%@', PatientAddress='%@', PatientBDay='%@' FROM patients WHERE PatientId='%i' ; DELETE PatientDiagnosis='%@', PatientComplain='%@', PatientAnamnesis='%@', PatientMedHistory='%@', Verdict='%@', Complete='%@' FROM visitWHERE PatientId='%i'",self.name, self.phone, self.photo, self.meetTime, self.genderText, self.addressText, self.patientBDayText, self.primaryKey,self.diagnosisText,  self.complainsText, self.anamnesisText, self.medHistoryText, self.verdictText, self.completeDate, self.primaryKey]];
*/
    [SQLiteAccess deleteWithSQL:[NSString stringWithFormat:@"DELETE FROM patients WHERE PatientId=? "]];
    [SQLiteAccess updateWithSQL:[NSString stringWithFormat:@"DELETE FROM visit WHERE PatientId=?"]];
}

- (void)dealloc {
    //[primaryKey release];
    [name release];
    [phone release];
    [photo release];
    [dataPhoto release];
    [meetTime release];
    [genderText release];
    [addressText release];
    [patientBDayText release];
    [diagnosisText release];
    [complainsText release];
    [anamnesisText release];
    [medHistoryText release];
    [verdictText release];
    [completeDate release];
    [super dealloc];
}

@end
