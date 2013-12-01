//
//  SubsystemViewController.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
#import "SubsystemViewCell.h"
#import "InfoViewCell.h"
#import "PersonalitiesViewCell.h"
#import "EmployeeViewCell.h"
#import "Employee.h"
#import "Personalities.h"
#import "UserData.h"
#import "CampusAPI.h"

@interface SubsystemViewController : UITableViewController {
    NSArray *subsystems;
    UserData *userData;
    UIImage *photo;
    BOOL isNeedUpdate;
}

@property (strong, nonatomic) NSArray *subsystems;
@end
