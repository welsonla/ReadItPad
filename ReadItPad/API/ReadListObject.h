//
//  ReadListObject.h
//  ReadItPad
//
//  Created by welsonla on 12-9-30.
//
//

#import <Foundation/Foundation.h>

@interface ReadListObject : NSObject{
    NSString *item_id;
    NSString *state;
    NSString *time_added;
    NSString *time_updated;
    NSString *title;
    NSString *url;
}

@property(nonatomic,retain) NSString *item_id;
@property(nonatomic,retain) NSString *state;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *url;
@property(nonatomic,retain) NSString *time_added;
@property(nonatomic,retain) NSString *time_updated;

-(ReadListObject *)convertToReadObject:(NSDictionary *)dicObject;

@end
