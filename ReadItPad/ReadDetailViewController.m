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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [webView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:webView];
    [super viewDidLoad];
}

- (void)loadWebPageWithString:(NSString *)str{
    NSLog(@"urlString-------%@",str);
    NSURL *url  = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Start");
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Finished");
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
