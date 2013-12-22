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
#import "ImageCache.h"
#import "BbMessage.h"

@interface CampusAPI : NSObject


+ (int) userID;
+ (NSString*) sessionID;
+ (void) setSessionID:(NSString*) value;
+ (UserConversation*) conversation;
+ (void) setConversation:(UserConversation*) value;
+ (UIImage *) avatar;
+ (void) setAvatar:(UIImage*) value;
+ (NSArray*) users;
+ (void) setUsers:(NSArray*) value;
+ (NSString*) fullName;

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
+ (Boolean) sendMessage:(NSString*)message forGroup:(int)groupID withSession:(NSString*) sessionID withUsers:(NSString*) users fromUserName:(NSString*) username;
+ (UIImage*) getImageFromURL : (NSURL*) url;
+ (NSArray  *) getActualBulletinBoardMessages:(NSString*)sessionID;
@end
