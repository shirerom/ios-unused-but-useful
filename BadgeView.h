//
//  BadgeView.h
//  Jappy Messenger
//
//  Created by Johannes Bauer on 06.11.13.
//  Copyright (c) 2013 Johannes Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCircle.h"


typedef enum {
	BadgeViewCounterNoNumber = NSNotFound
} BadgeViewCounter;


@interface BadgeView : UIView

@property (assign, nonatomic) NSUInteger badgeCounter;

- (id)initWithCircle:(JYCircle)circle;

@end
