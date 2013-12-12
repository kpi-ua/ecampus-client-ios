//
//  BulletinBoardCell.h
//  Campus
//
//  Created by admin on 12.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BulletinBoardCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *bulletinBoardMessageTitle;
@property (strong, nonatomic) IBOutlet UILabel *bulletinBoardMessageBody;
@property (strong, nonatomic) IBOutlet UILabel *bulletinBoardMessageDate;


@end
