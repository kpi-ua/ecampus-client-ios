//
//  MessageCell.m
//  Campus
//
//  Created by admin on 15.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
@synthesize messageDate = _messageDate, messageText = _messageText, subject = _subject, image = _image;

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
