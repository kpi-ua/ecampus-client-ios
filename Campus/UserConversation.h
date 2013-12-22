//
//  UserConversation.h
//  Campus
//
//  Created by admin on 15.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConversation : NSObject{
    int        groupID;
    int        lastSenderUserAccountId;
    NSArray    *users;
    NSString   *lastMessageText;
    NSString   *lastMessageDate;
    NSString   *subject;
    UIImage    *image;

}
@property (nonatomic)           int groupID;
@property (nonatomic)           int lastSenderUserAccountId;
@property (nonatomic, retain)   NSString *lastMessageText;
@property (nonatomic, retain)   NSString *lastMessageDate;
@property (nonatomic, retain)   NSString *subject;
@property (nonatomic, retain)   NSArray *users;
@property (nonatomic, retain)   UIImage *image;

@end
