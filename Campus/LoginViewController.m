//
//  LoginViewController.m
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController
@synthesize login;
@synthesize password;
@synthesize parent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self.view setUserInteractionEnabled:YES];
    self.login.delegate = self;                       /* for closing keyboard on Done button in login field */
    self.password.delegate = self;                    /* for closing keyboard on Done button in password field */

}
/**
 * For closing keyboard on Done button
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)loginButton:(UIButton *)sender {

    if (login.text.length != 0 && password.text.length != 0) {                               /* check for empty fields */
    
        NSString *result = [CampusAPI getAuth:login.text withPassword:password.text];        /* result of authentification */
        if( result != nil) {
            // switch to new view
            [CampusAPI setSessionID:result];
            [parent dismissModalViewControllerAnimated:YES];
         //   SubsystemViewController *subsystemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SubsystemViewController"];
         //   subsystemViewController.subsystems = [CampusAPI getPermissions:result];
         //[self presentModalViewController:subsystemViewController animated:YES];
            
           // MainTabBarController *mainTabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
           // [mainTabBarController setSelectedIndex:0];
           // [mainTabBarController setSelectedViewController:[mainTabBarController.viewControllers objectAtIndex:0]];
          // [self presentModalViewController:mainTabBarController animated:YES];
        } else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Помилка входу!"
                                                              message:@"Виникла помилка з'єднання с сервером. Перевірте налаштування інтернету"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Увага!"
                                                          message:@"Усі поля повинні бути заповнені."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}

-(void)dismissKeyboard {
    [login resignFirstResponder];
    [password resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
