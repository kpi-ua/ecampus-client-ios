//
//  EmployeeViewCell.h
//  Campus
//
//  Created by admin on 01.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *subdivisionName;
@property (strong, nonatomic) IBOutlet UILabel *position;
@property (strong, nonatomic) IBOutlet UILabel *academicDegree;
@property (strong, nonatomic) IBOutlet UILabel *academicStatus;

@end
