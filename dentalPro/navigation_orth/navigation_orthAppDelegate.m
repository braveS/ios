//
//  navigation_orthAppDelegate.m
//  navigation_orth
//
//  Created by Napoleon Bonapart on 01.12.11.
//  Copyright 2011 FPMSoft. All rights reserved.
//

#import "navigation_orthAppDelegate.h"
#import "PatientSQL.h"

@implementation navigation_orthAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize patients;
@synthesize primaryKeyNum;
@synthesize primaryKey;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [self createEditableCopyOfDatabaseIfNeeded];
    [self initializeDatabase];
    
	// Configure and show the window
	
    //[window addSubview:navigationController.view];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    //[window makeKeyAndVisible];
}

// Копирует базу данных из ресурсов приложения в папку Documents на iPhone
-(void) createEditableCopyOfDatabaseIfNeeded{    
    NSString *homeDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *path = [homeDirectory stringByAppendingPathComponent:@"dBase39.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbExists = [fileManager fileExistsAtPath:path];
    if(!dbExists) {
		NSError *error = nil;
		NSString *originalDBPath = [[NSBundle mainBundle] pathForResource:@"dBase39" ofType:@"sqlite"];
		[fileManager copyItemAtPath:originalDBPath toPath:path error:&error];
    }
}
// Открывает базу данных и читает записи из нее
- (void) initializeDatabase {
    NSMutableArray *patientArray = [[[NSMutableArray alloc] init] autorelease];
    self.patients = patientArray;
    
    // Получаем путь к базе данных
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"dBase39.sqlite"];
    
    //int primaryKey;
    
    //Open dataBase
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //NSLog(@"nav_delegate - READ - success");
        // Запрашиваем список идентификаторов записей
        const char *sql = "SELECT PatientId FROM patients";
        sqlite3_stmt *statement;

        // Компилируем запрос в байткод перед отправкой в базу данных
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL)== SQLITE_OK){

            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                primaryKey = sqlite3_column_int(statement, 0);
                //NSLog(@"PKEY %i",primaryKey);
        // Заполняем массив объектами PatientSQL, инициализированными с ключами, полученными из базы
                PatientSQL *patient = [[[PatientSQL alloc] initWithIdentifier:primaryKey database:database]autorelease];
                NSLog(@"nav_delegate - READ - PATIENT %@ AND PRIMARY KEY %i",patient, primaryKey);
                [patients addObject:patient];
                //NSLog(@"nav_delegate - READ - patients %@",patients);
                //[patient release];
            }
        }
        sqlite3_finalize(statement);
    }   else {
        // Даже в случае ошибки открытия базы закрываем ее для корректного освобождения памяти
        sqlite3_close(database);
        NSAssert1(NO, @"Failed to open database with message '%s' .", sqlite3_errmsg(database));
        NSLog(@"nav_delegate close =========================");
    }
   // NSLog(@"nav_delegate _Patients = %i",patients.count);
    primaryKeyNum = [NSNumber numberWithInteger:primaryKey];
    //NSLog(@"pkkkk %@",primaryKeyNum); 
    
}
/*
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		
		//Get the object to delete from the array.
		PatientSQL *coffeeObj = [appDelegate.coffeeArray objectAtIndex:indexPath.row];
		[appDelegate removeCoffee:coffeeObj];
		
		//Delete the object from the table.
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}
*/

// Добавляет или обновляет информацию о записи в базе данных  !!!!!!!!!!!!!!
- (void) updateOrAddRecordIntoDatabase:(PatientSQL *) patient { 
    
    navigation_orthAppDelegate *appDelegate = (navigation_orthAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSInteger currId = [appDelegate.primaryKeyNum integerValue];

    if (currId < patient.primaryKey) {
        if ((patient.name == nil) || (patient.name.length == 0)) return;
        [patient insertIntoDatabase:database];
        [patients addObject:patient];
        //NSLog(@"nav_delegate - Inserted");
        NSLog(@"INSERTED     primary key= %i", patient.primaryKey);
    }
    else {//if (patient.primaryKey>) {
        NSLog(@"pRK  %i",patient.primaryKey);
        //NSLog(@" ");
        [patient updateRecordPatients];//:database];
        //NSLog(@"nav_delegate - Updated");
        NSLog(@"UPDATED     primary key= %i", patient.primaryKey);
    }
}

- (void) deleteRowFromDatabase: (PatientSQL *) patient {
    //[appDelegate updateOrAddRecordIntoDatabase:self.patient];
}
 
// Перед выходом из приложения закрываем базу данных
//- (void)applicationDidEnterBackground:(UIApplication *) application{
-(void) applicationWillTerminate:(UIApplication *)application{  
[PatientSQL finalizeStatements];
    NSLog(@"Entered Background");
    if (sqlite3_close(database)!= SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close the database with the message '%s'.", sqlite3_errmsg(database));
        NSLog(@"nav_delegate - TERMINATE NOT success");
    }
    else 
        NSLog(@"nav_delegate - TERMINATE  success");
}

- (void)dealloc
{
    [patients release];
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
 
