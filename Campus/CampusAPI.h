//
//  CampusAPI.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubsystemProfile.h"

@interface CampusAPI : NSObject

+ (NSString *) getAuth:(NSString*)login withPassword:(NSString*)password;
+ (NSArray  *) getPermissions:(NSString*)sessionID;
+ (NSString *) getDataFrom:(NSString *)url;
+ (NSString *) fetchedData:(NSData *)responseData withKey:(NSString*)key;
+ (NSArray  *) fetchedSubsystemData:(NSData *)responseData;
@end
