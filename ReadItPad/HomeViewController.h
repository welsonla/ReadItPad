//
//  HomeViewController.h
//  ReadItPad
//
//  Created by 万业超 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ReadItLaterLite.h"
#import "ReadItLaterAddition.h"
#import "RegexKitLite.h"
#import "ReadListViewController.h"
#import "MBProgressHUD.h"

@interface HomeViewController : UIViewController<UITextFieldDelegate,ReadItLaterDelegate,MBProgressHUDDelegate>{
    UITextField *username;
    UITextField *password;
    MBProgressHUD *HUB ;
    UIActivityIndicatorView *activityView;
}

@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;
@property (nonatomic,retain) MBProgressHUD *HUB ;
@property (nonatomic,retain) UIActivityIndicatorView *activityView;

- (void)startAnimation;

- (void)stopAnimation;

- (void)doLogin:(id)sender;

- (BOOL)checkInput:(id)sender;

- (void)getErrorToShow:(NSString *)title withMessage:(NSString *)msg andCancelButton:(NSString *)cancel;

@end
