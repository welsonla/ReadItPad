//
//  ReadItLaterAddition.m
//  ReadItPad
//
//  Created by 万业超 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadItLaterAddition.h"

@implementation ReadItLater (addition)

+ (void)getReadList:(id)delegate{

    ReadItLater *readlater = [[ReadItLater alloc] init];
    readlater.delegate = delegate;
    
    NSUserDefaults *ud = [ReadItLater getUserData];
    [readlater sendRequest:@"get" username:[ud objectForKey:@"username"] password:[ud objectForKey:@"password"] params:nil];
    [readlater release];
}

+ (NSString *)getPlistPath{

    return  [[NSBundle mainBundle] pathForResource:@"read" ofType:@"plist"];
}

+ (void)saveUserData:(NSString *)username andPassword:(NSString *)password{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:username forKey:@"username"];
    [ud setObject:password forKey:@"password"];
}


+ (NSUserDefaults *)getUserData{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return ud;
}

@end
