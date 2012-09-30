//
//  ReadDetailViewController.m
//  ReadItPad
//
//  Created by 万 业超 on 12-6-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadDetailViewController.h"

@interface ReadDetailViewController ()

@end

@implementation ReadDetailViewController

@synthesize webView;

@synthesize HUB;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [self.view setFrame:CGRectMake(0, 0, 1024, 768)];

    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, 1024, 708)];
    [webView setBackgroundColor:[UIColor yellowColor]];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [super viewDidLoad];
}


//Load the content  to the web view
- (void)loadWebPageWithString:(NSString *)str{
    NSURL *url  = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.mode = MBProgressHUDModeAnnularDeterminate;
    HUB.labelText = @"Loading";

    NSLog(@"Start");
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
