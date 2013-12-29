//
//  DetailViewController.m
//  Campus
//
//  Created by admin on 22.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize subject = _subject, text = _text, message, author = _author, date = _date;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.subject.text = message.subject;
    self.text.text = message.text;
    self.title = message.subject;
    if (message.creatorFullname == (id)[NSNull null]) { /* еб*ная наркомания тут просто!!! Сделайте, бл*дь, это рабочее поле, е*та!!*/
       self.author.text = @"Порожнє поле";
    } else {
        self.author.text = message.creatorFullname;
    }
    
    
    NSDateFormatter *isoFormat = [[NSDateFormatter alloc] init];
    [isoFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *formattedDate = [isoFormat dateFromString:message.date];
    
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"dd.MM.yyyy"];
    self.date.text = [shortFormat stringFromDate:formattedDate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
