//
//  SubsystemViewController.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubsystemProfile.h"
#import "SubsystemViewCell.h"

@interface SubsystemViewController : UITableViewController {
    NSArray *subsystems;
}

@property (strong, nonatomic) NSArray *subsystems;
@end
