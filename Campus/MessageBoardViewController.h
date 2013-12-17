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

@interface MessageBoardViewController : UITableViewController {
    NSArray *conversation;
}
@property (strong, nonatomic) NSArray *conversation;
@end
