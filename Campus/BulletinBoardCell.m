//
//  BulletinBoardCell.m
//  Campus
//
//  Created by admin on 12.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "BulletinBoardCell.h"


@implementation BulletinBoardCell

@synthesize bulletinBoardMessageBody = _bulletinBoardMessageBody, bulletinBoardMessageDate = _bulletinBoardMessageDate, bulletinBoardMessageTitle = _bulletinBoardMessageTitle;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
