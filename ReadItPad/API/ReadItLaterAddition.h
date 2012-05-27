//
//  ReadItLaterAddition.h
//  ReadItPad
//
//  Created by 万业超 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadItLaterLite.h"


@interface ReadItLater (addition){

}

+ (void)getReadList:(id)delegate;

+ (NSString *)getPlistPath;

+ (void)saveUserData:(NSString *)username andPassword:(NSString *)password;

+ (NSUserDefaults *)getUserData;


@end
