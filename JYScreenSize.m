//
//  JYScreenSizeType.m
//  Jappy Messenger
//
//  Created by Johannes Bauer on 11.09.14.
//  Copyright (c) 2014 Johannes Bauer. All rights reserved.
//

#import "JYScreenSize.h"

@implementation JYScreenSize

+ (JYScreenSizeType)type {

	CGFloat mainScreenHeight = [UIScreen mainScreen].bounds.size.height;

	// iPhone 6+
	if (mainScreenHeight == 736.f) {
		return JYScreenSizeTypeIphone6Plus;
	}
	
	// iPhone 6
	else if (mainScreenHeight == 667.f) {
		return JYScreenSizeTypeIphone6;
	}
	
	// iPhone 5
	else if (mainScreenHeight == 568.f) {
		return JYScreenSizeTypeIphone5;
	}
	
	// iPhone 4
	else if (mainScreenHeight == 480.f) {
		return JYScreenSizeTypeIphone4;
	}
	
	else {
		return JYScreenSizeTypeUnknown;
	}
}
@end
