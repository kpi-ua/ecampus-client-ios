//
//  DialogViewController.m
//  Campus
//
//  Created by admin on 15.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "DialogViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "Message.h"

@interface DialogViewController ()
{
    IBOutlet UIBubbleTableView *bubbleTable;
    IBOutlet UIView *textInputView;
    IBOutlet UITextField *textField;
    NSMutableArray *messages;
    NSMutableArray *bubbleData;
}

@end

@implementation DialogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([CampusAPI conversation].groupID!=0) {
        messages = [CampusAPI getUserConversations:[CampusAPI sessionID] withGroupID:[CampusAPI conversation].groupID];
        self.title = [CampusAPI conversation].subject;
    }
    
    bubbleData = [[NSMutableArray alloc] init];
    NSMutableSet *userIDs = [[NSMutableSet alloc] init];
    for (Message *message in messages) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:message.sentDate];
        NSBubbleData *heyBubble;
        NSTimeInterval intervalBetween =   [[NSDate date] timeIntervalSinceDate:dateFromString];
        if (message.senderUserAccountID == [CampusAPI userID]) {
            heyBubble = [NSBubbleData dataWithText: message.text date:dateFromString/*[NSDate dateWithTimeIntervalSinceNow:intervalBetween]*/ type:BubbleTypeMine];
         //   [heyBubble date
            heyBubble.avatar = [CampusAPI avatar];
            
            
        } else {
            heyBubble = [NSBubbleData dataWithText: message.text date:dateFromString/*[NSDate dateWithTimeIntervalSinceNow:intervalBetween]*/ type:BubbleTypeSomeoneElse];
            heyBubble.avatar = [CampusAPI getImageFromURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/Storage/GetUserProfileImage?userId=%d",
                                                                                         message.senderUserAccountID]]];
            [userIDs addObject: [[NSNumber alloc] initWithInt:message.senderUserAccountID]];
        }
        
        [bubbleData addObject:heyBubble];
    }

    bubbleTable.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    bubbleTable.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    bubbleTable.showAvatars = YES;
    
    [bubbleTable reloadData];
    [bubbleTable setContentOffset:CGPointMake(0, bubbleTable.contentSize.height)];
    // Keyboard events
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

#pragma mark - Keyboard events

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = textInputView.frame;
        frame.origin.y -= kbSize.height;
        textInputView.frame = frame;
        
        frame = bubbleTable.frame;
        frame.size.height -= kbSize.height;
        bubbleTable.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = textInputView.frame;
        frame.origin.y += kbSize.height;
        textInputView.frame = frame;
        
        frame = bubbleTable.frame;
        frame.size.height += kbSize.height;
        bubbleTable.frame = frame;
    }];
   [bubbleTable setContentOffset:CGPointMake(0, bubbleTable.contentSize.height - bubbleTable.frame.size.height) animated:YES];
}

#pragma mark - Actions

- (IBAction)sayPressed:(id)sender
{
    bubbleTable.typingBubble = NSBubbleTypingTypeNobody;
    
    if ([textField.text length]==0) {
        return;
    }
    NSMutableString *temp =[[NSMutableString alloc] init];

    for (int i=0; i<[[CampusAPI users] count]; i++) {
        NSString *value = [[CampusAPI users] objectAtIndex:i];
        if(i==[[CampusAPI users] count]-1) {
            [temp appendString:[NSString stringWithFormat:@"%@",value]];
        } else {
            [temp appendString:[NSString stringWithFormat:@"%@,",value]];
        }
    }

    NSBubbleData *sayBubble = [NSBubbleData dataWithText:textField.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeMine];
    sayBubble.avatar = [CampusAPI avatar];
    [CampusAPI sendMessage:textField.text forGroup:[CampusAPI conversation].groupID withSession:[CampusAPI sessionID]];
    [bubbleData addObject:sayBubble];
    [bubbleTable reloadData];
    
    textField.text = @"";
    [textField resignFirstResponder];
    
}

@end
