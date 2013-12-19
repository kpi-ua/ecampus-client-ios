//
//  CampusAPI.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
#import "Personalities.h"
#import "UserData.h"
#import "Employee.h"
#import "UserConversation.h"
#import "Message.h"

@interface CampusAPI : NSObject

+ (NSString*) sessionID;
+ (int) groupID;
+ (int) userID;
+ (void) setSessionID:(NSString*) value;
+ (void) setGroupID:(int) value;
+ (UIImage *) avatar;
+ (void) setAvatar:(UIImage*) value;
+ (NSString *) getAuth:(NSString*)login withPassword:(NSString*)password;
+ (NSArray  *) getPermissions:(NSString*)sessionID;
+ (NSString *) getDataFromURL:(NSString *)url;
+ (NSString *) fetchedData:(NSData *)responseData withKey:(NSString*)key;
+ (NSArray  *) fetchedSubsystemData:(NSData *)responseData;
+ (UserData *) fetchedUser:(NSData *) responseData;
+ (UserData *) getCurrentUser:(NSString*)sessionID;
+ (NSArray  *) getUserConversations:(NSString*)sessionID;
+ (NSArray  *) getUserConversations:(NSString*)sessionID withGroupID:(int)groupID;
+ (Boolean) sendMessage:(NSString*)message forGroup:(int)groupID withSession:(NSString*) sessionID;
@end
