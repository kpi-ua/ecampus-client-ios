//
//  MessageBoardViewController.h
//  Campus
//
//  Created by admin on 15.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusAPI.h"
#import "MessageCell.h"
#import "CampusAPI.h"
#import "DialogViewController.h"
#import "PullRefreshTableViewController.h"

@interface MessageBoardViewController : PullRefreshTableViewController {
    NSArray *conversation;
    BOOL isNeedUpdate;
}
@property (strong, nonatomic) NSArray *conversation;
@end
