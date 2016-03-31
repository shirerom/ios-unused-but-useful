//
//  JRoundProfileImageView+Rank.m
//  Jappy Messenger
//
//  Created by Johannes Bauer on 20.05.14.
//  Copyright (c) 2014 Johannes Bauer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ImageLoader.h"
#import "JYRoundProfileImageRankView.h"

@implementation JYRoundProfileImageRankView

@synthesize progressColor = _progressColor;

#pragma mark - Life cycle

- (id)initWithCoder:(NSCoder *)aDecoder {

	self = [super initWithCoder:aDecoder];

	if (self) {

		// Rundung
		self.layer.cornerRadius = self.frame.size.width / 2;
		self.layer.masksToBounds = YES;

		// Rank label
		_rankLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_rankLabel.backgroundColor = [UIColor clearColor];
		_rankLabel.font = [UIFont systemFontOfSize:ceilf(self.frame.size.width / 6)];
		_rankLabel.textColor = self.progressColor;

		_rankLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
		_rankLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
		_rankLabel.layer.shadowRadius = .7;
		_rankLabel.layer.shadowOpacity = .9;
		_rankLabel.layer.masksToBounds = NO;

		[self addSubview:_rankLabel];
	}

	return self;
}

- (id)initWithFrame:(CGRect)frame {

	self = [super initWithFrame:frame];
	
	// Rundung
	self.layer.cornerRadius = frame.size.width / 2;
	self.layer.masksToBounds = YES;
	
	// Rank label
	_rankLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_rankLabel.backgroundColor = [UIColor clearColor];
	_rankLabel.font = [UIFont systemFontOfSize:ceilf(frame.size.width / 6)];
	_rankLabel.textColor = self.progressColor;
	
	_rankLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
	_rankLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
	_rankLabel.layer.shadowRadius = .7;
	_rankLabel.layer.shadowOpacity = .9;
	_rankLabel.layer.masksToBounds = NO;
	
	[self addSubview:_rankLabel];
	
	return self;
}

- (id)initWithPosition:(CGPoint)position diameter:(CGFloat)diameter {

	self = [self initWithFrame:CGRectMake(position.x, position.y, diameter, diameter)];
	
	return self;
}


- (void)drawRect:(CGRect)rect {

	CGFloat height = self.bounds.size.height;
	CGFloat width = self.bounds.size.height;
	
	// Konfiguration
	CGFloat lineWidth = MAX(1.f, ceilf(MIN(width, height) / 40.f));
	CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	CGFloat radius = (self.bounds.size.width - lineWidth)/2;
	CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
	CGFloat endAngle = (2 * (float)M_PI) + startAngle;
	
	// Draw image
	[_image drawInRect:rect];
	
	// Draw progress runway
	UIBezierPath *processRunwayPath = [UIBezierPath bezierPath];
	processRunwayPath.lineCapStyle = kCGLineCapRound;
	processRunwayPath.lineWidth = lineWidth;
	endAngle = (_progress * 2 * (float)M_PI) + startAngle;
	[processRunwayPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:2 * (float)M_PI + startAngle clockwise:YES];
	[[JYColor colorWithWhite:1.f alpha:0.5f] set];
	[processRunwayPath stroke];

	// Draw progress
	UIBezierPath *processPath = [UIBezierPath bezierPath];
	processPath.lineCapStyle = kCGLineCapRound;
	processPath.lineWidth = lineWidth;
	endAngle = (_progress * 2 * (float)M_PI) + startAngle;
	[processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
	[self.progressColor set];
	[processPath stroke];
	
}

- (void)setRank:(NSUInteger)rank {

	_rank = rank;
	
	_rankLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_rank];
	[_rankLabel sizeToFit];
	
	_rankLabel.center = CGPointMake(ceilf(0.25 * self.bounds.size.width), floorf(0.75 * self.bounds.size.width));
}

- (void)setProgressWithExperience:(NSUInteger)experience
											 lowerLimit:(NSUInteger)lowerLimit
											 upperLimit:(NSUInteger)upperLimit {

	float relativeExperience = experience - lowerLimit;
	float relativeRankExperience = upperLimit - lowerLimit;
	
	_progress = relativeExperience / relativeRankExperience;
	
	[self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image {

	_image = image;
	
	[self setNeedsDisplay];
}

- (void)loadIfNeededAndDisplayProfileImageSOfUser:(CDUser *)user {

	if (user) {

		// profile image
		if (user.profileImageS) {

			if (user.profileImageS.data) {
				self.image = user.profileImageS.data;
			}

			else {

				self.image = user.placeholderImage;

				[ImageLoader imageWithImage:user.profileImageS completion:^{
					self.image = user.profileImageS.data;
				}];
			}
		}

		else {
			self.image = user.placeholderImage;
		}
	}

	else {
		self.image = [CDUser defaultPlaceholder];
	}
}

- (UIColor *)progressColor {

	if (_progressColor != nil) {
		return _progressColor;
	}

	_progressColor = [JYColor fruityOrange];

	return _progressColor;
}

- (void)setProgressColor:(UIColor *)progressColor {

	_progressColor = progressColor;

	_rankLabel.textColor = progressColor;

	[self setNeedsDisplay];
}

@end
