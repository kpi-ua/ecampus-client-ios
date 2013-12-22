//
//  BbMessage.h
//  Campus
//
//  Created by admin on 22.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BbMessage : NSObject{
    int        bulletinBoardID;
    int        creatorUserAccountID;
    NSString   *creatorFullname;
    NSString   *subject;
    NSString   *text;
    NSString   *date;
    
}
@property (nonatomic)           int bulletinBoardID;
@property (nonatomic)           int creatorUserAccountID;
@property (nonatomic, retain)   NSString *creatorFullname;
@property (nonatomic, retain)   NSString *text;
@property (nonatomic, retain)   NSString *subject;
@property (nonatomic, retain)   NSString *date;
@end
