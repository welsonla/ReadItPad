//
//  ReadListObject.m
//  ReadItPad
//
//  Created by welsonla on 12-9-30.
//
//

#import "ReadListObject.h"

@implementation ReadListObject

@synthesize item_id;
@synthesize title;
@synthesize url;
@synthesize state;
@synthesize time_added;
@synthesize time_updated;

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return  self;
}


-(void)dealloc{
    [item_id release];
    [title release];
    [url release];
    [state release];
    [time_added release];
    [time_updated release];
    [super dealloc];
}

-(ReadListObject *)convertToReadObject:(NSDictionary *)dicObject{
   
    self.item_id = [dicObject objectForKey:@"item_id"];
    self.title = [dicObject objectForKey:@"title"];
    self.url = [dicObject objectForKey:@"url"];
    self.state = [dicObject objectForKey:state];
    self.time_added = [dicObject objectForKey:@"time_added"];
    self.time_updated = [dicObject objectForKey:@"time_updated"];

    return self;
}
@end
