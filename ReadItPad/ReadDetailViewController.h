//
//  ReadDetailViewController.h
//  ReadItPad
//
//  Created by 万 业超 on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ReadDetailViewController : UIViewController<UIWebViewDelegate>{
    UIWebView *webView;
    MBProgressHUD *HUB;
}

@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) MBProgressHUD *HUB;

- (void)loadWebPageWithString:(NSString *)str;

@end
