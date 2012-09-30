//
//  ReadListViewController.h
//  ReadItPad
//
//  Created by 万业超 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "ReadItLaterLite.h"
#import "ReadItLaterAddition.h"
#import "ReadListObject.h"
#import "ReadDetailViewController.h"

@interface ReadListViewController : UIViewController<ReadItLaterDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *readListArray;
    UITableView *readTable;
    ReadDetailViewController *readDetailController;
}

@property (nonatomic,retain) NSMutableArray *readListArray;
@property (nonatomic,retain) UITableView *readTable;
@property (nonatomic,retain) ReadDetailViewController *readDetailController;


@end
