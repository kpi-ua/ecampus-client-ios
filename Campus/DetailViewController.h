//
//  DetailViewController.h
//  Campus
//
//  Created by admin on 22.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BbMessage.h"
@interface DetailViewController : UIViewController {
    BbMessage *message;
    UILabel *subject;
    UITextView  *text;
}
@property (nonatomic, strong) IBOutlet UILabel *subject;
@property (nonatomic, strong) IBOutlet UITextView  *text;
@property (nonatomic, strong) BbMessage *message;
@end
