//
//  Message.h
//  Campus
//
//  Created by admin on 17.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    int        messageID;
    int        senderUserAccountID;
    NSString   *sentDate;
    NSString   *text;
    
}
@property (nonatomic)           int messageID;
@property (nonatomic)           int senderUserAccountID;
@property (nonatomic, retain)   NSString *sentDate;
@property (nonatomic, retain)   NSString *text;

@end
