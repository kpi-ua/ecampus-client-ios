//
//  UserData.h
//  Campus
//
//  Created by admin on 01.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject {
    int       userAccountID;
    NSURL     *urlPhoto;
    NSString  *fullName;
    NSArray   *personalities;
    NSArray   *employees;
    NSArray   *profiles;
    
}
@property (nonatomic)         int       userAccountID;
@property (nonatomic, retain) NSURL     *urlPhoto;
@property (nonatomic, retain) NSString  *fullName;
@property (nonatomic, retain) NSArray   *personalities;
@property (nonatomic, retain) NSArray   *employees;
@property (nonatomic, retain) NSArray   *profiles;

@end
