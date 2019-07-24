//
//  RIButtonItem.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "RIButtonItem.h"

@implementation RIButtonItem
@synthesize label;
@synthesize style;
@synthesize action;

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel style:(UIAlertActionStyle)inStyle
{
    RIButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    [newItem setStyle:inStyle];
    return newItem;
}

+(id)itemWithLabel:(NSString *)inLabel style:(UIAlertActionStyle)inStyle action:(void(^)(void))action
{
  RIButtonItem *newItem = [self itemWithLabel:inLabel style:inStyle];
  [newItem setAction:action];
  return newItem;
}

@end

