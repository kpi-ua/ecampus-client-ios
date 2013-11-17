//
//  SubsystemProfile.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubsystemProfile : NSObject {
    
    NSString *subsystemName;
    BOOL isCreate;
    BOOL isRead;
    BOOL isUpdate;
    BOOL isDelete;
}

@property (nonatomic, retain) NSString *subsystemName;
@property (nonatomic) BOOL isCreate;
@property (nonatomic) BOOL isRead;
@property (nonatomic) BOOL isUpdate;
@property (nonatomic) BOOL isDelete;

@end
