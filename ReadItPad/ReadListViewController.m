//
//  ReadListViewController.m
//  ReadItPad
//
//  Created by 万业超 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadListViewController.h"

@implementation ReadListViewController

@synthesize readListArray;
@synthesize readTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Delegate methods

- (void)readitLaterGetFinished:(NSString *)stringResponse error:(NSString *)errorString{

    NSDictionary *dic  = [[stringResponse objectFromJSONString] objectForKey:@"list"];
    readListArray = [[NSMutableArray alloc] initWithArray:[dic allValues]];
    [readListArray setArray:[dic allValues]];
    [readTable reloadData];
}


#pragma mark -
#pragma mark table delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [readListArray count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    
    cell.textLabel.text = [[readListArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [ReadItLater getReadList:self];
    
//    readListArray = [[NSMutableArray alloc] init];
    
    
    readTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) style:UITableViewStylePlain];
    [readTable setDataSource:self];
    [readTable setDelegate:self];
    [self.view addSubview:readTable];
    [super viewDidLoad];
}

- (void)dealloc{
    [super dealloc];
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
