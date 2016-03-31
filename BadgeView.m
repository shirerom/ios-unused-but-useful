//
//  BadgeView.m
//  Jappy Messenger
//
//  Created by Johannes Bauer on 06.11.13.
//  Copyright (c) 2013 Johannes Bauer. All rights reserved.
//

#import "BadgeView.h"


@interface BadgeView ()

@property (strong, nonatomic) UILabel* badgeLabel;

@end


@implementation BadgeView

- (id)initWithCoder:(NSCoder *)aDecoder {

	self = [super initWithCoder:aDecoder];
	
	if (self) {
		
		CGFloat cornerRadius = 0.f;
		CGFloat height = self.frame.size.height;
		CGFloat width = self.frame.size.height;
		
		if (width > 0 && height > 0) {
			
			if (width > height) {
				cornerRadius = height / 2;
			}
			
			else {
				cornerRadius = width / 2;
			}
		}
		
		self.backgroundColor = [JYColor redColor];
		self.layer.cornerRadius = cornerRadius;
		self.layer.masksToBounds = YES;
	}
	
	return self;
}

- (id)initWithCircle:(JYCircle)circle {

	self = [super initWithFrame:CGRectMake(circle.center.x - circle.diameter / 2,
																				 circle.center.y - circle.diameter / 2,
																				 circle.diameter,
																				 circle.diameter)];
	
	if (self) {
		
		self.backgroundColor = [JYColor redColor];
		self.layer.cornerRadius = circle.diameter / 2;
		self.layer.masksToBounds = YES;
	}
	
	return self;
}

#pragma mark - Counter

- (void)setBadgeCounter:(NSUInteger)badgeCounter {

	_badgeCounter = badgeCounter;

	if (_badgeLabel == nil) {
		
		_badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_badgeLabel.backgroundColor = [JYColor clearColor];
		_badgeLabel.textColor = [JYColor white];
		_badgeLabel.font = [UIFont systemFontOfSize:JYFONT_BADGE_SIZE];
		
		[self addSubview:_badgeLabel];
	}
	
	if (_badgeCounter == BadgeViewCounterNoNumber) {
		
		_badgeLabel.text = [NSString stringWithFormat:@" "];
		[_badgeLabel sizeToFit];
		
		_badgeLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
		
		self.hidden = NO;
	}
	
	else if (_badgeCounter > 0) {

		_badgeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_badgeCounter];
		[_badgeLabel sizeToFit];

		_badgeLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
				
		self.hidden = NO;
	}
	
	else {
		self.hidden = YES;
	}
}

@end
