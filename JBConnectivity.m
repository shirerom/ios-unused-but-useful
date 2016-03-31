//
//  JBConnectivity.m
//  Jappy Messenger
//
//  Created by Johannes Bauer on 16.09.15.
//  Copyright (c) 2015 Johannes Bauer. All rights reserved.
//

#import <Reachability/Reachability.h>
#import "JBConnectivity.h"


NSString* const kJBConnectivityChangedNotification = @"kJBConnectivityChangedNotification";


@implementation JBConnectivity

#pragma mark - Life cycle

- (instancetype)init {

	self = [super init];

	if (self) {
		_state = JBConnectivityStateDisconnected;
	}

	return self;
}

#pragma mark - Logging

+ (DDLogLevel)ddLogLevel {
	return ddLogLevel;
}

+ (void)ddSetLogLevel:(DDLogLevel)level {
	ddLogLevel = level;
}

#pragma mark - Helper

- (BOOL)hasConnectivity {

	@synchronized(self.stateMutexLock) {
		return (_state & JBConnectivityStateConnectivity);
	}
}

- (BOOL)hasReachability {

	@synchronized(self.stateMutexLock) {
		return (_state & JBConnectivityStateReachability);
	}
}

#pragma mark - State

- (void)addStateFlag:(JBConnectivityState)stateFlag {

	DDLogInfo(@"state = %li, flag = %li", (long)_state, (long)stateFlag);

	if (stateFlag > JBConnectivityStateConnected) {
		return;
	}

	self.state = _state | (JBConnectivityStateConnected & stateFlag);
}

- (void)removeStateFlage:(JBConnectivityState)stateFlag {

	DDLogInfo(@"state = %li, flag = %li", (long)_state, (long)stateFlag);

	if (stateFlag > JBConnectivityStateConnected) {
		return;
	}

	self.state = _state & (JBConnectivityStateConnected & ~stateFlag);
}

- (void)setState:(JBConnectivityState)state {

	@synchronized(self.stateMutexLock) {

		if (_state == state) {
			DDLogInfo(@"state unchanged = %li", (long)_state);
			return;
		}

		[self exitState:_state];

		// _state muss zwischen exit und enter gesetzt werden, weil in enter
		// Methoden ausgeführt werden können, die auf State referenzieren.
		_state = state;

		[self enterState:state];
	}
}

- (void)exitState:(JBConnectivityState)state {

	switch (state) {

		case JBConnectivityStateReachability:
			break;

		default:
			break;
	}
}

- (void)enterState:(JBConnectivityState)state {

	switch (state) {

		case JBConnectivityStateReachability:
			break;

		case JBConnectivityStateConnected:
//			[self sendQueuedRequests];
			break;

		default:
			break;
	}
}

- (void)reenterState {

	DDLogDebug(@"");

	[self exitState:_state];
	[self enterState:_state];
}


#pragma mark - Notification

- (void)reachabilityChanged:(NSNotification*)notification {

	dispatch_async(dispatch_get_main_queue(), ^{

		Reachability *reachability = notification.object;

		DDLogInfo(@"isReachable = %d", reachability.isReachable);

		if (reachability.isReachable) {
			[self addStateFlag:JBConnectivityStateReachability];
		}

		else {
			[self removeStateFlage:JBConnectivityStateReachability];
		}
	});
}

- (void)connectivityChanged:(NSNotification*)notification {

	dispatch_async(dispatch_get_main_queue(), ^{

		BOOL connectable = ((NSNumber*)notification.object).boolValue;

		DDLogInfo(@"isConnectable = %d", connectable);

		if (connectable) {
			[self addStateFlag:JBConnectivityStateConnectivity];
		}

		else {
			[self removeStateFlage:JBConnectivityStateConnectivity];
		}
	});
}

- (void)watchConnection {

	DDLogDebug(@"");

	//
	// Reachability
	//

	// Allocate a reachability object
	Reachability* reach = [Reachability reachabilityWithHostname:@"www.jappy.de"];

	// Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
	//	reach.reachableOnWWAN = NO;

	// Here we set up a NSNotification observer. The Reachability that caused the notification
	// is passed in the object parameter
	[[NSNotificationCenter defaultCenter] addObserver:self
																					 selector:@selector(reachabilityChanged:)
																							 name:kReachabilityChangedNotification
																						 object:nil];

	[reach startNotifier];

	//
	// Connectivity
	//

	[[NSNotificationCenter defaultCenter] addObserver:self
																					 selector:@selector(connectivityChanged:)
																							 name:kJBConnectivityChangedNotification
																						 object:nil];
}

#pragma mark - Singleton

+ (instancetype)sharedInstance {

	static JBConnectivity *instance = nil;
	static dispatch_once_t pred;

	dispatch_once(&pred, ^{
		instance = [[JBConnectivity alloc] init];
		[instance addStateFlag:JBConnectivityStateReachability];
		[instance addStateFlag:JBConnectivityStateConnectivity];
	});

	return instance;
}

@end
