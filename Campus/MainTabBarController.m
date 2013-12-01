//
//  MainTabBarController.m
//  Campus
//
//  Created by admin on 28.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "MainTabBarController.h"

@implementation MainTabBarController

@synthesize isLogin;
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
    isLogin = true;
    
	// Do any additional setup after loading the view.

  }
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isLogin) {
        LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginViewController.parent = self;
        [self presentModalViewController:loginViewController animated:NO];
        isLogin = FALSE;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
