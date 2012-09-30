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

#pragma mark -
#pragma mark class methods

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

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


//Load the content  to the web view
- (void)loadWebPageWithString:(NSString *)str{
    NSURL *url  = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [webView loadRequest:request];

}


#pragma mark -
#pragma mark webView methods
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.mode = MBProgressHUDModeAnnularDeterminate;
    HUB.labelText = @"Loading";
    
    [HUB hide:YES afterDelay:1.5];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

}


@end
