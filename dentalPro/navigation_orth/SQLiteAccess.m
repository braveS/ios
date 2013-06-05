
#import "SQLiteAccess.h"
#import <sqlite3.h>

@implementation SQLiteAccess
@synthesize lastInsertRowId;

static int singleRowCallbackNoModel(void *queryValuesVP, int columnCount, char **values, char **columnNames) {
    NSObject *queryValues = (NSObject *)queryValuesVP;
    for(int i=0; i<columnCount; i++) {
		NSString *key = [NSString stringWithUTF8String:columnNames[i]];
		//SEL selector = NSSelectorFromString(key);
		//if ([queryValues respondsToSelector:selector]) {
			[queryValues setValue:values[i] ? [NSString stringWithUTF8String:values[i]] : [NSNull null] 
                           forKey:key];
		//}
    }
    return 0;
}

static int singleRowCallback(void *queryValuesVP, int columnCount, char **values, char **columnNames) {
    NSObject *queryValues = (NSObject *)queryValuesVP;
    for(int i=0; i<columnCount; i++) {
		NSString *key = [NSString stringWithUTF8String:columnNames[i]];
		SEL selector = NSSelectorFromString(key);
		if ([queryValues respondsToSelector:selector]) {
			[queryValues setValue:values[i] ? [NSString stringWithUTF8String:values[i]] : [NSNull null] 
							forKey:key];
		}
    }
    return 0;
}

static int multipleRowCallback(void *queryValuesVP, int columnCount, char **values, char **columnNames) {
	NSDictionary *rules = (NSDictionary *)queryValuesVP;
    NSMutableArray *queryValues = [rules objectForKey:@"receiver"];
	Class class = NSClassFromString([rules objectForKey:@"class"]);
    NSObject *individualQueryValues = [class new];
    for(int i=0; i<columnCount; i++) {
		NSString *key = [NSString stringWithUTF8String:columnNames[i]];
		SEL selector = NSSelectorFromString(key);
		if ([individualQueryValues respondsToSelector:selector]) {
			[individualQueryValues setValue:values[i] ? [NSString stringWithUTF8String:values[i]] : [NSNull null] 
							forKey:key];
		}
    }
    [queryValues addObject:individualQueryValues];
	[individualQueryValues release];
    return 0;
}

+ (NSString *)pathToDB {

	NSString *homeDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *path = [homeDirectory stringByAppendingPathComponent:@"dBase39.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbExists = [fileManager fileExistsAtPath:path];
    if(!dbExists) {
		NSError *error = nil;
		NSString *originalDBPath = [[NSBundle mainBundle] pathForResource:@"dBase39" ofType:@"sqlite"];
		[fileManager copyItemAtPath:originalDBPath toPath:path error:&error];
    }
	
    return path;
}

+ (NSNumber *)executeSQL:(NSString *)sql withCallback:(void *)callbackFunction context:(id)contextObject 
{
    NSString *path = [self pathToDB];
    sqlite3 *db = NULL;
    int rc = SQLITE_OK;
    int lastRowId = 0;
    rc = sqlite3_open([path UTF8String], &db);
    if(SQLITE_OK != rc)
    {
        NSLog(@"Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return nil;
    }
    else 
        {
        char *zErrMsg = NULL;
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        rc = sqlite3_exec(db, [sql UTF8String], callbackFunction, (void*)contextObject, &zErrMsg);
        if(SQLITE_OK != rc) 
            {
                NSLog(@"Can't run query '%@' error message: %s\n", sql, sqlite3_errmsg(db));
                sqlite3_free(zErrMsg);
            }
        lastRowId = sqlite3_last_insert_rowid(db);
        sqlite3_close(db);
        [pool release];
    }
    NSNumber *lastInsertRowId = [[[NSNumber alloc] init ]autorelease];
    lastInsertRowId = nil;
    if(0 != lastRowId) 
    {
        lastInsertRowId = [NSNumber numberWithInteger:lastRowId];
    }
     NSLog(@"LASTROWID =%@",lastInsertRowId);
    return lastInsertRowId;
}

+ (NSString *)selectOneValueSQL:(NSString *)sql {
    NSMutableDictionary *queryValues = [NSMutableDictionary dictionary];
    [self executeSQL:sql withCallback:singleRowCallbackNoModel context:queryValues];
    NSString *value = nil;
    if([queryValues count] == 1) {
        value = [[queryValues objectEnumerator] nextObject];
    }
    return value;
}

+ (NSArray *)selectManyValuesWithSQL:(NSString *)sql {
	NSMutableArray *queryValues = [NSMutableArray array];
	Class modelClass = [NSMutableDictionary class];
	NSDictionary *rules = [NSDictionary dictionaryWithObjectsAndKeys:NSStringFromClass(modelClass), @"class",
						   queryValues, @"receiver", nil];
	
    [self executeSQL:sql withCallback:multipleRowCallback context:rules];

    NSMutableArray *values = [NSMutableArray array];
    for(NSDictionary *dict in queryValues) {
        [values addObject:[[dict objectEnumerator] nextObject]];
    }
    return values;
}

+ (id)selectOneRowWithSQL:(NSString *)sql model:(Class)modelClass {
    NSObject *queryValues = [modelClass new];
    [self executeSQL:sql withCallback:singleRowCallback context:queryValues];
    return [queryValues autorelease];    
}

+ (NSArray *)selectManyRowsWithSQL:(NSString *)sql model:(Class)modelClass {
    NSMutableArray *queryValues = [NSMutableArray array];
	NSDictionary *rules = [NSDictionary dictionaryWithObjectsAndKeys:NSStringFromClass(modelClass), @"class",
						   queryValues, @"receiver", nil];
    [self executeSQL:sql withCallback:multipleRowCallback context:rules];
    return queryValues;
}

+ (NSNumber *)insertWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    return [self executeSQL:sql withCallback:NULL context:NULL];
}

+ (void)updateWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    [self executeSQL:sql withCallback:NULL context:nil];
}

+ (void)deleteWithSQL:(NSString *)sql {
    sql = [NSString stringWithFormat:@"BEGIN TRANSACTION; %@; COMMIT TRANSACTION;", sql];
    [self executeSQL:sql withCallback:NULL context:nil];
}

@end
