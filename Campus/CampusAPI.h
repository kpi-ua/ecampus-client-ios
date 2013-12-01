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

@interface CampusAPI : NSObject

+ (NSString*) sessionID;
+ (void) setSessionID:(NSString*) value;
+ (NSString *) getAuth:(NSString*)login withPassword:(NSString*)password;
+ (NSArray  *) getPermissions:(NSString*)sessionID;
+ (NSString *) getDataFrom:(NSString *)url;
+ (NSString *) fetchedData:(NSData *)responseData withKey:(NSString*)key;
+ (NSArray  *) fetchedSubsystemData:(NSData *)responseData;
+ (UserData  *) fetchedUser:(NSData *) responseData;
+ (UserData*) getCurrentUser:(NSString*)sessionID;
@end
