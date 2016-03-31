//
//  JRoundProfileImageView+Rank.h
//  Jappy Messenger
//
//  Created by Johannes Bauer on 20.05.14.
//  Copyright (c) 2014 Johannes Bauer. All rights reserved.
//

@interface JYRoundProfileImageRankView : UIView

@property (strong, nonatomic) UIColor *progressColor;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic, readonly) float progress;
@property (assign, nonatomic) NSUInteger rank;
@property (strong, nonatomic, readonly) UILabel* rankLabel;

- (id)initWithPosition:(CGPoint)position diameter:(CGFloat)diameter;

- (void)loadIfNeededAndDisplayProfileImageSOfUser:(CDUser *)user;

- (void)setProgressWithExperience:(NSUInteger)experience
											 lowerLimit:(NSUInteger)lowerLimit
											 upperLimit:(NSUInteger)upperLimit;

@end
