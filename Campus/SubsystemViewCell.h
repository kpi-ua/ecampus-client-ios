//
//  SubsystemViewCell.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubsystemViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *subSystemName;
@property (strong, nonatomic) IBOutlet UILabel *isCreate;
@property (strong, nonatomic) IBOutlet UILabel *isRead;
@property (strong, nonatomic) IBOutlet UILabel *isUpdate;
@property (strong, nonatomic) IBOutlet UILabel *isDelete;

@end
