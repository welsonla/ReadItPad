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

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)dealloc{
    [username release];
    [password release];
    [activityView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:56.0f/255.0f green:169.0f/255.0f blue:195.0f/255.0f alpha:1.0f]];
    
    
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
    [username setDelegate:self];
    [username setTextAlignment:UITextAlignmentLeft];
    [username setCenter:CGPointMake(512, 200)];
    [username.placeholder setAccessibilityFrame:CGRectMake(10, 10, 150, 30)];
    [username.layer setCornerRadius:5];
    [self.view addSubview:username];
    
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(300, 250, 250, 40)];
    [password.layer setCornerRadius:5];
    [password setBackgroundColor:[UIColor whiteColor]];
    [password setPlaceholder:@"Password"];
    [password setDelegate:self];
    [password setFont:[UIFont systemFontOfSize:18]];
    [password setTextAlignment:UITextAlignmentLeft];
    [password setCenter:CGPointMake(512, 250)];
    [password setSecureTextEntry:YES];
    [self.view addSubview:password];
    
    
    UIActivityIndicatorView *tempActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tempActivityView setFrame:CGRectMake(670, 290, 25, 25)];
    self.activityView = tempActivityView;
    [self.view addSubview:self.activityView];
    [tempActivityView release];
      
    
    [super viewDidLoad];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight)||(interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


#pragma mark -
#pragma mark TextField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(![self checkInput:textField]){
        return NO;
    }
    
    [self startAnimation];

    
    [ReadItLater authWithUsername:username.text password:password.text delegate:self];
    
    [username resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark Animation methods

- (void)startAnimation{
    HUB = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUB.mode = MBProgressHUDAnimationZoom;
    HUB.labelText = @"Loading";
}

- (void)stopAnimation{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)getErrorToShow:(NSString *)title withMessage:(NSString *)msg andCancelButton:(NSString *)cancel{
    title = (title==nil)?@"":title;
    cancel = (cancel==nil)?@"OK":cancel;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark do login methods

- (void)doLogin:(id)sender{
   
}

- (BOOL)checkInput:(id)sender{
    if(username.text.length==0||password.text.length==0){
        
        [self getErrorToShow:nil withMessage:@"username or Password mustn't be empty" andCancelButton:@"OK"];
        return NO;
    }
    
    return YES;
}

- (void)readItLaterLoginFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
    if ([stringResponse rangeOfString:@"200"].location != NSNotFound) {
        //验证成功
        [ReadItLater saveUserData:username.text andPassword:password.text];
        ReadListViewController *listController = [[ReadListViewController alloc] initWithNibName:nil bundle:nil];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listController];
        [self presentModalViewController:nav animated:YES];
        [listController release];
        
    }else if([stringResponse rangeOfString:@"401"].location != NSNotFound){
        //密码错误
        [self getErrorToShow:nil withMessage:@"Username and password do not match account" andCancelButton:@"OK"];
        [password becomeFirstResponder];
        
    }else{
        //未知错误
        NSLog(@"error");
        
    }
    [self stopAnimation];

}




- (void)readItLaterSignupFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
}

- (void)readItLaterSaveFinished:(NSString *)stringResponse error:(NSString *)errorString{
    
}

@end
