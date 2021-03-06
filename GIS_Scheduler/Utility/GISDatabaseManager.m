//
//  GISDatabaseMnager.m
//  Gallaudet-Interpreting-Service
//
//  Created by Anand on 14/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISDatabaseManager.h"
#import "GISJSONProperties.h"
#import "GISLoginDetailsObject.h"
#import "GISDropDownsObject.h"
#import "GISContactsInfoObject.h"
#import "GISServiceProviderObject.h"

static GISDatabaseManager *sharedDataManager = nil;

NSString* documentDirectory() {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
}

@implementation GISDatabaseManager


+ (id) sharedDataManager
{
    @synchronized(self) {
        
        if (sharedDataManager == nil)
        {
            sharedDataManager =  [[super allocWithZone:NULL] init];
        }
    }
    return sharedDataManager;
}

-(void)reloadTheDatabaseFile
{
    [self closeDB];
    
    NSString *pathOfDatabase = [self CheckDbFilePath];
    const char *dbpath = [pathOfDatabase UTF8String];
    if (sqlite3_open_v2(dbpath, &_subscriptionDB,SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX,NULL) == SQLITE_OK)
    {
        //self.openConnection = YES;
        NSLog(@"database opened successfully");
    }
}

-(void)closeDB
{
    if (sqlite3_close(_subscriptionDB) == SQLITE_OK) {
        //self.openConnection = NO;
    }
}
- (id) init
{
    if ((self = [super init]))
    {
        appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
        [self reloadTheDatabaseFile];
    }
    return self;
}



-(NSString *)CheckDbFilePath
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *gallaudetPath=[cacheDirectory stringByAppendingPathComponent:@"GallaudetScheduler"];
    
    NSString *dbPath =[gallaudetPath stringByAppendingPathComponent:@"GISSchedulerDatabase.db"];
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        
        [self createDbFileinDocumentDirectory:dbPath andLcidPath:gallaudetPath];
    }
    else
    {
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        NSArray *files = [fileManager contentsOfDirectoryAtPath:gallaudetPath error:nil];
        for (NSString *file in files)
        {
            if([file isEqualToString:@"GISSchedulerDatabase.db"])
            {
                // NSString *fullPath = [lcidPath stringByAppendingPathComponent:file];
                if(appDelegate.isLogout){
                    if ([fileManager contentsOfDirectoryAtPath:gallaudetPath error:nil]){
                        [fileManager removeItemAtPath:gallaudetPath error:nil];
                        NSLog(@"DB deleted successfully");
                    }
                }
            }
        }
        
    }
    
    return dbPath;
}

-(void)createDbFileinDocumentDirectory:(NSString *)dbPath andLcidPath:(NSString *)lcidPath
{
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:lcidPath  withIntermediateDirectories:YES attributes:nil error:&error];
    //Since file is not available at the path create a Database File
    [[NSFileManager defaultManager] createFileAtPath:dbPath contents:[NSData data] attributes:nil];
    //NSLog(@"error -----------> is %@",[error description]);
}

-(NSString *)getDbFilePath
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *galludatePath=[cacheDirectory stringByAppendingPathComponent:@"Gallaudet"];
    NSString *dbPath =[galludatePath stringByAppendingPathComponent:@"GISDatabase.db"];
    appDelegate=(GISAppDelegate *)[[UIApplication sharedApplication]delegate];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath])
    {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:galludatePath  withIntermediateDirectories:YES attributes:nil error:&error];
        //Since file is not available at the path create a Database File
        [[NSFileManager defaultManager] createFileAtPath:dbPath contents:[NSData data] attributes:nil];
       // NSLog(@"error -----------> is %@",[error description]);
        
    }
    
    return dbPath;
}

-(BOOL)checkFolderDate:(NSString *)dbPath
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSDictionary* attrs = [fm attributesOfItemAtPath:dbPath error:nil];
    
    if (attrs != nil)
    {
        NSDate *date = (NSDate*)[attrs objectForKey: NSFileModificationDate];
        //NSLog(@"Date Created: %@", [date description]);
        // NSLog(@"Date Created: %@", [NSDate date]);
        // NSLog(@"check number of days %d",[self CheckNumberOfDays:date andCurrentDate:[NSDate date]]);
        if([self CheckNumberOfDays:date andCurrentDate:[NSDate date]]>30)
        {
            return YES;
        }
    }
    else
    {
        return NO;
    }
    return NO;
}


-(int)CheckNumberOfDays:(NSDate *)createdFolderDate andCurrentDate:(NSDate *)cdate
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-ddHH:mm:ss ZZZ"];
    NSDate *startDate = createdFolderDate;
    //NSLog(@"%@",startDate);
    NSDate *endDate = cdate;
   //NSLog(@"%@",endDate);
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    return components.day;
}


/////////------ query implementation methods --------///////////

- (BOOL) executeCreateTableQuery:(NSString *)query
{
	BOOL SuccessMsg = YES;
    char *errMsg;
    const char *sql_stmt = [query UTF8String];
    
    if (sqlite3_exec(_subscriptionDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
    {
        SuccessMsg = NO;
        NSLog(@"------------Couldn't Create Table:%@ error %s",query,sqlite3_errmsg(_subscriptionDB));
    }else{
        NSLog(@"table created");
    }
    
	return SuccessMsg;
	
}

- (BOOL) executeInsertQuery:(NSString *)query
{
   	BOOL successMsg = YES;
	sqlite3_stmt  *statement;
   
    const char *insert_stmt = [query UTF8String];
    
    sqlite3_prepare_v2(_subscriptionDB, insert_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        
    }
    else
    {
        successMsg = NO;
        NSLog(@"------------Record Not Inserted:%@ error %s",query,sqlite3_errmsg(_subscriptionDB));
    }
    sqlite3_reset(statement);
 
	return successMsg;
}

- (BOOL) deleteTable:(NSString *)tableName
{
    
    NSString *query=[NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",tableName];
    
    NSLog(@"query is %@",query);
	BOOL SuccessMsg = YES;

    char *errMsg;
    const char *sql_stmt = [query UTF8String];
    
    if (sqlite3_exec(_subscriptionDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
    {
        SuccessMsg = NO;
    }
   
	return SuccessMsg;
	
}
- (BOOL) executeUpdateQuery:(NSString *)query
{
    
    NSLog(@"query -------> is %@",query);
	BOOL successMsg = YES;
	sqlite3_stmt  *statement;

    NSLog(@"Table_Insert_Query:%@",query);
    const char *insert_stmt = [query UTF8String];
    
    sqlite3_prepare_v2(_subscriptionDB, insert_stmt, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"record inserted successfully");
        
    }
    else
    {
        successMsg = NO;
        NSLog(@"Record Not Inserted");
    }
    //sqlite3_reset(statement);
    sqlite3_reset(statement);
	return successMsg;
}

-(void)insertContactInfoData:(NSDictionary*)contactInfoDict
{
    //    DLog(@"the activity feed is:%@",activityFeedDict);
    NSString *contactInfoId = [contactInfoDict objectForKey:kGetContactInfoId];
    NSString *contactNo = [contactInfoDict objectForKey:kGetContactNo];
    NSString *contactType = [contactInfoDict objectForKey:kGetContactType];
    NSString *contactTypeId = [contactInfoDict objectForKey:kGetContactTypeId];
    NSString *contactTypeNo = [contactInfoDict objectForKey:kGetContactTypeNo];
    
    const char *insertString = "INSERT INTO TBL_CONTACTS_INFO(CONTACT_INFO_ID,CONTACT_NO,CONTACT_TYPE,CONTACT_TYPE_ID,CONTACT_TYPE_NO) VALUES (?,?,?,?,?)";
    sqlite3_stmt *addStmt;
    if(sqlite3_prepare_v2(_subscriptionDB, insertString, -1, &addStmt, NULL) == SQLITE_OK)
    {
        if (contactInfoId) {
            sqlite3_bind_text(addStmt, 1, [contactInfoId UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (contactNo) {
            sqlite3_bind_text(addStmt, 2, [contactNo UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (contactType)
        {
            sqlite3_bind_text(addStmt, 3, [contactType UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (contactTypeId) {
            sqlite3_bind_text(addStmt, 4, [contactTypeId UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (contactTypeNo)
        {
            sqlite3_bind_text(addStmt, 5, [contactTypeNo UTF8String], -1, SQLITE_TRANSIENT);
        }
    }
    if(sqlite3_step(addStmt) != SQLITE_DONE){
        NSLog(@"Insert Failed");
    }
    else{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive)
        {
            NSLog(@"Application Background State");
            // [[PCLogger sharedLogger] logToSave:@"Application Background State" ofType:PC_LOG_INFO];
            
        }
    }
    sqlite3_reset(addStmt);
    //[[NSNotificationCenter defaultCenter]postNotificationName:KFileUploadFinishFinalized object:nil];
}

-(void)insertLoginData:(NSDictionary*)loginDict
{
    //    DLog(@"the activity feed is:%@",activityFeedDict);
    NSString *request_ID = [loginDict objectForKey:kLoginRequestorID];
    NSString *firstName = [loginDict objectForKey:kLoginFirstName];
    NSString *lastName = [loginDict objectForKey:kLoginLastName];
    NSString *email = [loginDict objectForKey:kLoginEmail];
    NSString *token = [loginDict objectForKey:kLoginToken];
    NSString *userStatus = [loginDict objectForKey:kLoginUserStatus];
    NSString *roles = [loginDict objectForKey:kLoginRoles];
    NSString *role_id = [loginDict objectForKey:kLoginRoleId];
    
    const char *insertString = "INSERT INTO TBL_LOGIN(REQUESTOR_ID,EMAIL,FIRST_NAME,LAST_NAME,REQUEST_TOKEN,USER_STATUS,ROLES,ROLE_ID) VALUES (?,?,?,?,?,?,?,?)";
    sqlite3_stmt *addStmt;
    if(sqlite3_prepare_v2(_subscriptionDB, insertString, -1, &addStmt, NULL) == SQLITE_OK)
    {
        if (request_ID) {
            sqlite3_bind_text(addStmt, 1, [request_ID UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (firstName) {
            sqlite3_bind_text(addStmt, 2, [email UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (lastName)
        {
            sqlite3_bind_text(addStmt, 3, [firstName UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (email) {
            sqlite3_bind_text(addStmt, 4, [lastName UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (token)
        {
            sqlite3_bind_text(addStmt, 5, [token UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (userStatus)
        {
            sqlite3_bind_text(addStmt, 6, [userStatus UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (roles)
        {
            sqlite3_bind_text(addStmt, 7, [roles UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (role_id)
        {
            sqlite3_bind_text(addStmt, 8, [role_id UTF8String], -1, SQLITE_TRANSIENT);
        }
    }
    if(sqlite3_step(addStmt) != SQLITE_DONE){
        NSLog(@"Insert Failed");
    }
    else{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive)
        {
            NSLog(@"Application Background State");
           // [[PCLogger sharedLogger] logToSave:@"Application Background State" ofType:PC_LOG_INFO];
            
        }
    }
    sqlite3_reset(addStmt);
    //[[NSNotificationCenter defaultCenter]postNotificationName:KFileUploadFinishFinalized object:nil];
}

-(void)insertDropDownData:(NSDictionary*)loginDict Query:(NSString *)query
{
    //    DLog(@"the activity feed is:%@",activityFeedDict);
    
    NSString *dropdown_ID = [loginDict objectForKey:kDropDownID];
    NSString *dropdown_type = [loginDict objectForKey:kDropDownType];
    NSString *dropdown_value = [loginDict objectForKey:kDropDownValue];
    
    NSLog(@"Table_Insert_Query:%@",query);
    const char *insertString = [query UTF8String];
    
    sqlite3_stmt *addStmt;
    if(sqlite3_prepare_v2(_subscriptionDB, insertString, -1, &addStmt, NULL) == SQLITE_OK)
    {
        
        if (dropdown_ID) {
            sqlite3_bind_text(addStmt, 1, [dropdown_ID UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (dropdown_type) {
            sqlite3_bind_text(addStmt, 2, [dropdown_type UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (dropdown_value)
        {
            sqlite3_bind_text(addStmt, 3, [dropdown_value UTF8String], -1, SQLITE_TRANSIENT);
        }
        
    }
    
    if(sqlite3_step(addStmt) != SQLITE_DONE){
        NSLog(@"Insert Failed");
    }
    else{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive)
        {
            NSLog(@"Application Background State");
            // [[PCLogger sharedLogger] logToSave:@"Application Background State" ofType:PC_LOG_INFO];
            
        }
    }
    sqlite3_reset(addStmt);
    //[[NSNotificationCenter defaultCenter]postNotificationName:KFileUploadFinishFinalized object:nil];
}

-(void)insertChooseRequestData:(NSDictionary*)loginDict Query:(NSString *)query
{
    //    DLog(@"the activity feed is:%@",activityFeedDict);
    
    int dropdown_ID = [[loginDict objectForKey:kDropDownID] intValue];
    NSString *dropdown_type = [loginDict objectForKey:kDropDownType];
    NSString *dropdown_value = [loginDict objectForKey:kDropDownValue];
    
    NSLog(@"Table_Insert_Query:%@",query);
    const char *insertString = [query UTF8String];
    
    sqlite3_stmt *addStmt;
    if(sqlite3_prepare_v2(_subscriptionDB, insertString, -1, &addStmt, NULL) == SQLITE_OK)
    {
        
        if (dropdown_ID) {
            sqlite3_bind_int(addStmt, 1, dropdown_ID);
        }
        if (dropdown_type) {
            sqlite3_bind_text(addStmt, 2, [dropdown_type UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (dropdown_value)
        {
            sqlite3_bind_text(addStmt, 3, [dropdown_value UTF8String], -1, SQLITE_TRANSIENT);
        }
    }
    
    if(sqlite3_step(addStmt) != SQLITE_DONE){
        NSLog(@"Insert Failed");
    }
    else{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive)
        {
            NSLog(@"Application Background State");
            // [[PCLogger sharedLogger] logToSave:@"Application Background State" ofType:PC_LOG_INFO];
            
        }
    }
    sqlite3_reset(addStmt);
    //[[NSNotificationCenter defaultCenter]postNotificationName:KFileUploadFinishFinalized object:nil];
}


-(void)insertServiceProviderData:(NSDictionary*)spDict Query:(NSString *)query
{
    //    DLog(@"the activity feed is:%@",activityFeedDict);
    
    NSString *serviceProvider_ID = [spDict objectForKey:kServiceProviderID];
    NSString *serviceProvider_type = [spDict objectForKey:kServiceProviderType];
    NSString *serviceProvider_SpType = [spDict objectForKey:kServiceProviderSPType];
    NSString *serviceProvider_SP = [spDict objectForKey:kServiceProvider];
    
    NSLog(@"Table_Insert_Query:%@",query);
    const char *insertString = [query UTF8String];
    
    sqlite3_stmt *addStmt;
    if(sqlite3_prepare_v2(_subscriptionDB, insertString, -1, &addStmt, NULL) == SQLITE_OK)
    {
        
        if (serviceProvider_ID) {
            sqlite3_bind_text(addStmt, 1, [serviceProvider_ID UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (serviceProvider_type) {
            sqlite3_bind_text(addStmt, 2, [serviceProvider_type UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (serviceProvider_SpType)
        {
            sqlite3_bind_text(addStmt, 3, [serviceProvider_SpType UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (serviceProvider_SP)
        {
            sqlite3_bind_text(addStmt, 4, [serviceProvider_SP UTF8String], -1, SQLITE_TRANSIENT);
        }
        
    }
    
    if(sqlite3_step(addStmt) != SQLITE_DONE){
        NSLog(@"Insert Failed");
    }
    else{
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state != UIApplicationStateActive)
        {
            NSLog(@"Application Background State");
            // [[PCLogger sharedLogger] logToSave:@"Application Background State" ofType:PC_LOG_INFO];
            
        }
    }
    sqlite3_reset(addStmt);
    //[[NSNotificationCenter defaultCenter]postNotificationName:KFileUploadFinishFinalized object:nil];
}

-(NSArray *)geLoginArray:(NSString *)query
{
    //get DB path
    //    NSString *dbFilePath =[self getDbFilePath];
    
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledstmt;
    NSString *statement = query;
    const char *sqlstatement= [statement UTF8String];
    
    if(sqlite3_prepare_v2(_subscriptionDB, sqlstatement, -1, &compiledstmt, NULL)==SQLITE_OK)
    {
        while(sqlite3_step(compiledstmt)==SQLITE_ROW)
        {
            //            @property(nonatomic,strong)NSString * email_string;
            //            @property(nonatomic,strong)NSString * firstName_string;
            //            @property(nonatomic,strong)NSString * lastName_string;
            //            @property(nonatomic,strong)NSString * requestorID_string;
            //            @property(nonatomic,strong)NSString * token_string;
            
            NSString *value;
            GISLoginDetailsObject *loginObject = [GISLoginDetailsObject new];
            
            if ((char *)sqlite3_column_text(compiledstmt,0)) {
                value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,0)];
                loginObject.requestorID_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,1)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,1)];
                loginObject.email_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,2)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,2)];
                loginObject.firstName_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,3)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,3)];
                loginObject.lastName_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,4)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,4)];
                loginObject.token_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,5)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,5)];
                loginObject.userStatus_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,6)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,6)];
                loginObject.roles_string = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,7)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,7)];
                loginObject.role_ID_string = value;
            }
            
            [requestArray addObject:loginObject];
            
        }
    }
    //sqlite3_reset(compiledstmt);
    sqlite3_reset(compiledstmt);
    //    }
    //    sqlite3_close(_subscriptionDB);
    return requestArray;
}

-(NSArray *)getDropDownArray:(NSString *)query
{
    //get DB path
    //    NSString *dbFilePath =[self getDbFilePath];
    
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledstmt;
    NSString *statement = query;
    const char *sqlstatement= [statement UTF8String];
    
    if(sqlite3_prepare_v2(_subscriptionDB, sqlstatement, -1, &compiledstmt, NULL)==SQLITE_OK)
    {
        while(sqlite3_step(compiledstmt)==SQLITE_ROW)
        {
            
            GISDropDownsObject *dropdownObject = [GISDropDownsObject new];
            
            if ((char *)sqlite3_column_text(compiledstmt,0)) {
                NSString *commentDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,0)];
                dropdownObject.id_String = commentDate;
            }
            
            NSString *type,*value;
            if ((char *)sqlite3_column_text(compiledstmt,1)) {
                type =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,1)];
                dropdownObject.type_String = type;
            }
            if ((char *)sqlite3_column_text(compiledstmt,2)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,2)];
                dropdownObject.value_String = value;
            }
            [requestArray addObject:dropdownObject];
            
        }
    }
    //sqlite3_reset(compiledstmt);
    sqlite3_reset(compiledstmt);
    //    }
    //    sqlite3_close(_subscriptionDB);
    return requestArray;
}

-(NSArray *)getServiceProviderArray:(NSString *)query
{
    //get DB path
    //    NSString *dbFilePath =[self getDbFilePath];
    
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledstmt;
    NSString *statement = query;
    const char *sqlstatement= [statement UTF8String];
    
    if(sqlite3_prepare_v2(_subscriptionDB, sqlstatement, -1, &compiledstmt, NULL)==SQLITE_OK)
    {
        while(sqlite3_step(compiledstmt)==SQLITE_ROW)
        {
            
            GISServiceProviderObject *dropdownObject = [GISServiceProviderObject new];
            
            if ((char *)sqlite3_column_text(compiledstmt,0)) {
                NSString *service_ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,0)];
                dropdownObject.id_String = service_ID;
            }
            
            NSString *type,*serviceType,*serviceProvider;
            if ((char *)sqlite3_column_text(compiledstmt,1)) {
                type =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,1)];
                dropdownObject.type_String = type;
            }
            if ((char *)sqlite3_column_text(compiledstmt,2)) {
                serviceType =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,2)];
                dropdownObject.spType_String = serviceType;
            }
            if ((char *)sqlite3_column_text(compiledstmt,3)) {
                serviceProvider =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,3)];
                dropdownObject.service_Provider_String = serviceProvider;
            }
            [requestArray addObject:dropdownObject];
            
        }
    }
    //sqlite3_reset(compiledstmt);
    sqlite3_reset(compiledstmt);
    //    }
    //    sqlite3_close(_subscriptionDB);
    return requestArray;
}

-(NSArray *)getContactsArray:(NSString *)query
{
    //get DB path
    //    NSString *dbFilePath =[self getDbFilePath];
    
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *compiledstmt;
    NSString *statement = query;
    const char *sqlstatement= [statement UTF8String];
    
    if(sqlite3_prepare_v2(_subscriptionDB, sqlstatement, -1, &compiledstmt, NULL)==SQLITE_OK)
    {
        while(sqlite3_step(compiledstmt)==SQLITE_ROW)
        {
            NSString *value;
            GISContactsInfoObject *contactsObject = [GISContactsInfoObject new];
            
            if ((char *)sqlite3_column_text(compiledstmt,0)) {
                value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,0)];
                contactsObject.contactInfoId_String = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,1)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,1)];
                contactsObject.contactNo_String = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,2)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,2)];
                contactsObject.contactType_String = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,3)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,3)];
                contactsObject.contactTypeId_String = value;
            }
            if ((char *)sqlite3_column_text(compiledstmt,4)) {
                value =[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledstmt,4)];
                contactsObject.contactTypeNo_String = value;
            }
            [requestArray addObject:contactsObject];
            
        }
    }
    //sqlite3_reset(compiledstmt);
    sqlite3_reset(compiledstmt);
    //    }
    //    sqlite3_close(_subscriptionDB);
    return requestArray;
}

-(void)deleteRequestId:(NSString *)requestId
{
    NSString *query=[NSString stringWithFormat:@"DELETE FROM TBL_CHOOSE_REQUEST WHERE ID = '%@'",requestId];
    BOOL isdeleted = [self executeInsertQuery:query];
    if (isdeleted)
    {
        NSLog(@"Deleted Successfully");
    }
}


@end
