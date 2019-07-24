//
//  RIButtonItem.h
//  Shibui
//
//  Created by Jiva DeVoe on 1/12/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RIButtonItem : NSObject
{
    NSString *label;
    UIAlertActionStyle style;
    void (^action)();
}
@property (retain, nonatomic) NSString *label;
@property (assign, nonatomic) UIAlertActionStyle style; // Custom addition
@property (copy, nonatomic) void (^action)();

+(id)item;
+(id)itemWithLabel:(NSString *)inLabel style:(UIAlertActionStyle)inStyle;
+(id)itemWithLabel:(NSString *)inLabel style:(UIAlertActionStyle)inStyle action:(void(^)(void))action;
@end

