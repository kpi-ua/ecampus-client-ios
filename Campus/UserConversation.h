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
    NSString   *lastMessageText;
    NSString   *lastMessageDate;
    NSString   *subject;

}
@property (nonatomic)           int groupID;
@property (nonatomic, retain)   NSString *lastMessageText;
@property (nonatomic, retain)   NSString *lastMessageDate;
@property (nonatomic, retain)   NSString *subject;

@end
