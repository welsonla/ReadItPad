//
//  HomeViewController.m
//  ReadItPad
//
//  Created by 万业超 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@implementation UITextField(TextFieldRebuild)

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 10, 200, 20);
}


- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 10, self.bounds.size.width,self.bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(10, 10, self.bounds.size.width,self.bounds.size.height);
}


@end


@implementation HomeViewController

@synthesize username;
@synthesize password;
@synthesize activityView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)dealloc{
    [username release];
    [password release];
    [activityView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 150, 250, 40)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:30]];
    [nameLabel setText:@"Read It On iPad"];
    [nameLabel setCenter:CGPointMake(530, 150)];
    [self.view addSubview:nameLabel];
    [nameLabel release];
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(300, 200, 250, 40)];
    [username setBackgroundColor:[UIColor whiteColor]];
    [username setFont:[UIFont systemFontOfSize:18]];
    [username setPlaceholder:@"ReadItLater Username"];
    [username setTextAlignment:UITextAlignmentLeft];
    [username setCenter:CGPointMake(512, 200)];
    [username.placeholder setAccessibilityFrame:CGRectMake(10, 10, 150, 30)];
    [username.layer setCornerRadius:5];
    [self.view addSubview:username];
    
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(300, 250, 250, 40)];
    [password.layer setCornerRadius:5];
    [password setBackgroundColor:[UIColor whiteColor]];
    [password setPlaceholder:@"Password"];
    [password setFont:[UIFont systemFontOfSize:18]];
    [password setTextAlignment:UITextAlignmentLeft];
    [password setCenter:CGPointMake(512, 250)];
    [password setSecureTextEntry:YES];
    [self.view addSubview:password];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(300, 300, 250, 40)];
    [loginButton setBackgroundColor:[UIColor purpleColor]];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setCenter:CGPointMake(512, 300)];
    [loginButton.layer setCornerRadius:5];
    [self.view addSubview:loginButton];
    
    
    UIActivityIndicatorView *tempActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tempActivityView setFrame:CGRectMake(670, 290, 25, 25)];
    self.activityView = tempActivityView;
    [self.view addSubview:self.activityView];
    [tempActivityView release];
    
    [loginButton addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [super viewDidLoad];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark do login methods

- (void)doLogin:(id)sender{
    if(![self checkInput:sender]){
        return;
    }
    
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    [MBProgressHUD];
    
    HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.mode = MBProgressHUDModeAnnularDeterminate;
    HUB.labelText = @"Loading";
    
    [ReadItLater authWithUsername:username.text password:password.text delegate:self];
}

- (BOOL)checkInput:(id)sender{
    if(username.text.length==0||password.text.length==0){
        
        
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"Username or Password mustn't be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alter show];
        [alter release];
        return NO;
    }
    
    return YES;
}

- (void)readItLaterLoginFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
    if ([stringResponse rangeOfString:@"200"].location != NSNotFound) {
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        [ReadItLater saveUserData:username.text andPassword:password.text];
        ReadListViewController *listController = [[ReadListViewController alloc] initWithNibName:nil bundle:nil];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listController];
        [self presentModalViewController:nav animated:YES];
        [listController release];
        
    }else if([stringResponse rangeOfString:@"401"].location != NSNotFound){
        
        NSLog(@"Username and password do not match account");
        
    }else{
        
        NSLog(@"error");
        
    }
    
    [activityView stopAnimating];
}


- (void)readItLaterSignupFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
}

- (void)readItLaterSaveFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
}

@end
