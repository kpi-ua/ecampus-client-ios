//
//  BulletinBoardViewController.h
//  Campus
//
//  Created by admin on 12.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BulletinBoardCell.h"
#import "PullRefreshTableViewController.h"
#import "CampusAPI.h"
#import "DetailViewController.h"

@interface BulletinBoardViewController : PullRefreshTableViewController {
    NSArray *messages;
    BOOL isNeedUpdate;
}


@end
