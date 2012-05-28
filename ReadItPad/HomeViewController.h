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

@interface HomeViewController : UIViewController<ReadItLaterDelegate,MBProgressHUDDelegate>{
    UITextField *username;
    UITextField *password;
    UIActivityIndicatorView *activityView;
}

@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;
@property (nonatomic,retain)  UIActivityIndicatorView *activityView;

- (void)doLogin:(id)sender;

- (BOOL)checkInput:(id)sender;

@end
