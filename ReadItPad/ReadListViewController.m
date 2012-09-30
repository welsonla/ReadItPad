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
@synthesize readDetailController;

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

//    NSLog(@"StringResponse----------%@",stringResponse);
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
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    cell.textLabel.text = [[readListArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    {
//        "item_id": "163882275",
//        "state": "0",
//        "time_added": "1336638269",
//        "time_updated": "1336638269",
//        "title": "\u91cd\u6784\uff1a\u4ee3\u7801\u5f02\u5473",
//        "url": "http://www.google.com"
//    }
    NSDictionary *readDict = [readListArray objectAtIndex:indexPath.row];
    ReadListObject *readObject = [[ReadListObject alloc] init];
    readObject = [readObject convertToReadObject:readDict];
   
    readDetailController  = [[ReadDetailViewController alloc] initWithNibName:nil bundle:nil];
    [readDetailController loadWebPageWithString:readObject.url];
    [self.navigationController pushViewController:readDetailController animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [ReadItLater getReadList:self];
    
//    readListArray = [[NSMutableArray alloc] init];
    
    self.title = @"Reading List";
    readTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768) style:UITableViewStylePlain];
    [readTable setDataSource:self];
    [readTable setDelegate:self];
    [self.view addSubview:readTable];
    [super viewDidLoad];
}

- (void)dealloc{
    [readDetailController release];
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
