//
//  CampusAPI.m
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "CampusAPI.h"



@implementation CampusAPI

static NSString *sessionID;

+(NSString*) sessionID {
    return sessionID;
}
+(void) setSessionID:(NSString*) value {
    sessionID = value;
}
/**
 * Returns user session id after successful authentication or nil if  authentication is failed.
 */
+(NSString*) getAuth:(NSString*)login withPassword:(NSString*)password {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/Auth?login=%@&password=%@", login, password]];
  //  NSLog(@"Result %@", result);
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSString *ar =[CampusAPI fetchedData:dataResult withKey:@"Data"];
        return ar;
    } else {
        return result;
    }
}

/**
 * Returns user permissions.
 */
+(NSArray*) getPermissions:(NSString*)sessionID {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/GetPermissions?sessionId=%@&", sessionID]];
  // NSLog(@"Result %@", result);
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *subsystems = [CampusAPI fetchedSubsystemData:dataResult];
        return subsystems;
    } else {
        return nil;
    }
}


/**
 * Get data from url by GET request
 */
+ (NSString *) getDataFromURL:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


/**
 * Parse JSON by key
 */
+ (NSArray*)fetchedData:(NSData *)responseData withKey:(NSString*)key {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestKeys = [json objectForKey:key];
    
 //   NSLog(@"%@: %@",key, latestKeys);
    return latestKeys;
}

/**
 * Parse JSON for subsystems
 */
+ (NSArray*)fetchedSubsystemData:(NSData *)responseData {
    //parse out the json data
    NSMutableArray *subsystem = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          
                          options:kNilOptions
                          error:&error];
    NSArray* data     = [json objectForKey:@"Data"];
    for (NSDictionary *s in data) {
        Profile *sp = [[Profile alloc] init];
        [sp setSubsystemName:  s[@"SubsystemName"]];
        [sp setIsCreate:       [s[@"IsCreate"] boolValue]];
        [sp setIsDelete:       [s[@"IsDelete"] boolValue]];
        [sp setIsRead:         [s[@"IsRead"] boolValue]];
        [sp setIsUpdate:       [s[@"IsUpdate"] boolValue]];
        [subsystem addObject:sp];
    }
    
  //  NSLog(@"%@: %@",key, latestKeys);
    return subsystem;
}

+(UserData*)fetchedUser:(NSData *) responseData {
    //parse out the json data
    UserData *userData = [[UserData alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          options:kNilOptions
                          error:&error];
    NSDictionary* data     = [json objectForKey:@"Data"];
    userData.userAccountID = [[data objectForKey:@"UserAccountId"] integerValue];
    NSLog(@"%@", [data objectForKey:@"Photo"]);
    userData.urlPhoto = [[NSURL alloc] initWithString:[data objectForKey:@"Photo"]];
    userData.fullName = [data objectForKey:@"FullName"];
    
    // parse personalities
    NSArray* person = [data objectForKey:@"Personalities"];
    NSMutableArray* personalities = [[NSMutableArray alloc] init];
    for (NSDictionary *s in person) {
        Personalities *p = [[Personalities alloc] init];
        [p setSubdivisionName:  s[@"SubdivisionName"]];
        [p setSubdivisionID:    [s[@"SubdivisionId"] integerValue]];
        [p setStudyGroupName:   s[@"StudyGroupName"]];
        [p setIsContract:       [s[@"IsContract"] boolValue]];
        [p setSpecialty:        s[@"Specialty"]];
        [personalities addObject:p];
        
    }
    userData.personalities = personalities;
    
    
    // parse employees
    NSArray* employee = [data objectForKey:@"Employees"];
    NSMutableArray* employees = [[NSMutableArray alloc] init];
    for (NSDictionary *e in employee) {
        Employee *em = [[Employee alloc] init];
        [em setSubdivisionID:    [e[@"SubdivisionId"] integerValue]];
        [em setSubdivisionName:  e[@"SubdivisionName"]];
        [em setPosition:         e[@"Position"]];
        [em setAcademicDegree:   e[@"AcademicDegree"]];
        [em setAcademicStatus:   e[@"AcademicStatus"]];
        [employees addObject:em];
        
    }
    userData.employees = employees;
    
    
    //parse profiles
    NSArray*  prof = [data objectForKey:@"Profiles"];
    NSMutableArray *profiles =[[NSMutableArray alloc] init];
    for (NSDictionary *s in prof) {
        Profile *sp = [[Profile alloc] init];
        [sp setSubsystemName:  s[@"SubsystemName"]];
        [sp setIsCreate:       [s[@"IsCreate"] boolValue]];
        [sp setIsDelete:       [s[@"IsDelete"] boolValue]];
        [sp setIsRead:         [s[@"IsRead"] boolValue]];
        [sp setIsUpdate:       [s[@"IsUpdate"] boolValue]];
        [profiles addObject:sp];
    }
    userData.profiles =  profiles;

    return userData;
}


/**
 * Returns user information
 */
+(UserData*) getCurrentUser:(NSString*)sessionID {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/GetCurrentUser?sessionId=%@&", sessionID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        UserData *userData = [CampusAPI fetchedUser:dataResult];
        return userData;
    } else {
        return nil;
    }
}


+(NSArray*)fetchedConversations:(NSData *) responseData {
    //parse out the json data
    NSMutableArray *userConversations = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          options:kNilOptions
                          error:&error];
    NSArray* conversations     = [json objectForKey:@"Data"];
    for (NSDictionary *message in conversations) {
        UserConversation *us = [[UserConversation alloc] init];
        [us setGroupID:  [message[@"GroupId"] integerValue]];
        [us setLastMessageDate: message[@"LastMessageDate"]];
        [us setLastMessageText: message[@"LastMessageText"]];
        [us setSubject:         message[@"Subject"]];
        [userConversations addObject:us];
        
    }
    return userConversations;
}

/**
 * Returns user conversation
 */
+ (NSArray *) getUserConversations:(NSString*)sessionID {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Message/GetUserConversations?sessionId=%@&", sessionID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *userData = [CampusAPI fetchedConversations:dataResult];
        return userData;
    } else {
        return nil;
    }
}
@end
