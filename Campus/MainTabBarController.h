//
//  MainTabBarController.h
//  Campus
//
//  Created by admin on 28.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MainTabBarController : UITabBarController {
    BOOL isLogin;
}
@property (nonatomic) BOOL isLogin;
@end
