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
static UserConversation *conversation;
static int userID;
static UIImage *avatar;
static NSArray *users;
static NSString *fullName;


// Properties
+(NSString*) sessionID {
    return sessionID;
}

+(void) setSessionID:(NSString*) value {
    sessionID = value;
}

+(UserConversation*) conversation {
    return conversation;
}

+(void) setConversation:(UserConversation*)value {
    conversation = value;
}

+(int) userID {
    return userID;
}

+(void) setUserID:(int) value {
    userID = value;
}

+ (UIImage *) avatar {
    return avatar;
}
+ (void) setAvatar:(UIImage*) value {
    avatar = value;
}

+ (NSArray *) users {
    return users;
}

+ (void) setUsers:(NSArray*) value {
    users = value;
}

+(NSString*) fullName {
    return  fullName;
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
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/GetPermissions?sessionId=%@", sessionID]];
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
 * Get data from url by POST request
 */
+ (NSString *) getDataFromURL:(NSString *)url withPOST:(NSString*) post {
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request =[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSLog(@"Request %@",request);
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
    [CampusAPI setUserID:userData.userAccountID];
    NSLog(@"%@", [data objectForKey:@"Photo"]);
    userData.urlPhoto = [[NSURL alloc] initWithString:[data objectForKey:@"Photo"]];
    userData.fullName = [data objectForKey:@"FullName"];
    fullName = userData.fullName;
    
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
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/GetCurrentUser?sessionId=%@", sessionID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        UserData *userData = [CampusAPI fetchedUser:dataResult];
        return userData;
    } else {
        return nil;
    }
}

/**
 * Parse user conversation
 */
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
        [us setGroupID:                 [message[@"GroupId"] integerValue]];
        [us setLastMessageDate:         message[@"LastMessageDate"]];
        [us setLastMessageText:         message[@"LastMessageText"]];
        [us setSubject:                 message[@"Subject"]];
        [us setLastSenderUserAccountId: [message[@"LastSenderUserAccountId"] integerValue]];
        [us setImage: [CampusAPI getImageFromURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Storage/GetUserProfileImage?userId=%d",
                                                                                us.lastSenderUserAccountId]]]];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSArray *users = [message objectForKey:@"Users"];
        for (NSDictionary *user in users) {
            if([CampusAPI userID] != [user[@"UserAccountId"] integerValue]) {
                [arr addObject:user[@"UserAccountId"]];
            }
        }
        [us setUsers:[[NSArray alloc] initWithArray:arr]];
        [userConversations addObject:us];
        
    }
    return userConversations;
}

/**
 * Returns user messages
 */
+ (NSArray *) getUserConversations:(NSString*)sessionID withGroupID:(int)groupID{
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Message/GetUserConversation?sessionID=%@&groupId=%d&size=1000", sessionID, groupID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *userData = [CampusAPI fetchedMessages:dataResult];
        return userData;
    } else {
        return nil;
    }
}




/**
 * Returns user conversations
 */
+ (NSArray *) getUserConversations:(NSString*)sessionID {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Message/GetUserConversations?sessionID=%@", sessionID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *userData = [CampusAPI fetchedConversations:dataResult];
        userData = [[userData reverseObjectEnumerator] allObjects];
        return userData;
    } else {
        return nil;
    }
}

/**
 * Parse user messages
 */
+(NSArray*)fetchedMessages:(NSData *) responseData {
    //parse out the json data
    NSMutableArray *userConversations = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          options:kNilOptions
                          error:&error];
    NSArray* messages     = [json objectForKey:@"Data"];
    for (NSDictionary *m in messages) {
        Message *message = [[Message alloc] init];
        [message setSenderUserAccountID: [m[@"SenderUserAccountId"] integerValue]];
        [message setText:                 m[@"Text"]];
        [message setSentDate:             m[@"DateSent"]];
        [message setMessageID:           [m[@"MessageId"] integerValue]];
        
        [userConversations addObject:message];
        
    }
    return userConversations;
}

/**
 * Send Message
 */
+ (Boolean) sendMessage:(NSString*)message forGroup:(int)groupID withSession:(NSString*) sessionID{
    NSString *text = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Message/SendMessage?sessionID=%@&groupID=%d&text=%@", sessionID, groupID, text]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        return YES;
    } else {
        return NO;
    }
}


/**
 * Send Message
 */
+ (Boolean) sendMessage:(NSString*)message forGroup:(int)groupID withSession:(NSString*) sessionID withUsers:(NSString*) users fromUserName:(NSString*) username {
    NSString *text = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    users = [users stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    username = [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Message/SendMessage?sessionID=%@&groupID=%d&text=%@", sessionID, groupID, text]];
    [CampusAPI getDataFromURL:[NSString stringWithFormat:@"https://campuspush.azure-mobile.net/api/sendpush?userid=%@&text=%@&fullname=%@", users,text, username] withPOST:[NSString stringWithFormat:@"?userid=%@&text=%@&fullname=%@", users,text, username]];
    NSLog(@"?userid=%@&text=%@&fullname=%@", users,text, username);
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        return YES;
    } else {
        return NO;
    }
}



/**
 * Get image from url with cache
 */
+(UIImage*)getImageFromURL:(NSURL *)url {
    UIImage *image;
    // 1. Check the image cache to see if the image already exists. If so, then use it. If not, then download it.
    
    if ([[ImageCache sharedImageCache] DoesExist: url] == true)
    {
        image = [[ImageCache sharedImageCache] GetImage:url];
        NSLog(@"Image %@ in cache", url);
    }
    else
    {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: url];
        image = [[UIImage alloc] initWithData:imageData];
        NSLog(@"Image %@ isn't in cache", url);
        // Add the image to the cache
        [[ImageCache sharedImageCache] AddImage:url :image];
    }
    return image;
}

/**
 * Get actual messages from Bulletin Board
 */
+(NSArray*)getActualBulletinBoardMessages:(NSString *)sessionID {
    NSString * result = [CampusAPI getDataFromURL:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/BulletinBoard/GetActual?sessionID=%@", sessionID]];
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *userData = [CampusAPI fetchedBbMessages:dataResult];
        userData = [[userData reverseObjectEnumerator] allObjects];
        return userData;
    } else {
        return nil;
    }
}

/**
 * Parse Bulletin Board messages
 */
+(NSArray*)fetchedBbMessages:(NSData *) responseData {
    //parse out the json data
    NSMutableArray *bbMessages = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          options:kNilOptions
                          error:&error];
    NSArray* messages     = [json objectForKey:@"Data"];
    for (NSDictionary *m in messages) {
        BbMessage *message = [[BbMessage alloc] init];
        [message setCreatorUserAccountID: [m[@"CreatorUserAccountId"] integerValue]];
        [message setText:                  m[@"Text"]];
        [message setSubject:               m[@"Subject"]];
        [message setCreatorFullname:       m[@"CreatorUserFullName"]];
        [message setDate:                  m[@"DateCreate"]];
        [bbMessages addObject:message];
        
    }
    return bbMessages;
}
@end
