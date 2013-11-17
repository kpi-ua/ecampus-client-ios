//
//  LoginViewController.h
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusAPI.h"
#import "SubsystemViewController.h"

@interface LoginViewController : UIViewController {
    UITextField *login;
    UITextField *password;
    int keyboardHeight;
    BOOL keyboardIsShowing;
    
}

@property (nonatomic, strong) IBOutlet UITextField *login;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UIView *view;


- (IBAction)loginButton:(UIButton *)sender;


@end
