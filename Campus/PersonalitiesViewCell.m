//
//  PersonalitiesViewCell.m
//  Campus
//
//  Created by admin on 01.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "PersonalitiesViewCell.h"

@implementation PersonalitiesViewCell

@synthesize subdivisionName = _subdivisionName, studyGroupName = _studyGroupName, isContract = _isContract, speciality = _speciality;
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
