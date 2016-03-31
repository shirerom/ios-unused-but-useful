//
//  UINavigationController+PreviousViewController.m
//  Jappy Messenger
//
//  Created by Johannes Bauer on 23.09.13.
//  Copyright (c) 2013 Johannes Bauer. All rights reserved.
//

#import "UINavigationController+PreviousViewController.h"

@implementation UINavigationController (PreviousViewController)


- (UIViewController *)previousViewController {

	NSUInteger numberOfViewControllers = self.viewControllers.count;
	
	for (NSUInteger i = 0; i < numberOfViewControllers; i++) {
		NSLog(@"%s vc.class = %@", __PRETTY_FUNCTION__, [[self.viewControllers objectAtIndex:i] class]);
	}
	
	if (numberOfViewControllers < 2) {
		return nil;
	}

	else {
		return [self.viewControllers objectAtIndex:numberOfViewControllers - 2];
	}
}

@end
