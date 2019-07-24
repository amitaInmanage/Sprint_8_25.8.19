//
//  Animator.h
//  Aroma - iOS
//
//  Created by Yonatan Benami on 6/7/16.
//  Copyright © 2016 Idan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animator : NSObject

@end

@interface PushAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface PopAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end


