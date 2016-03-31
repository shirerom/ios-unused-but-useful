//
//  JBConnectivity.h
//  Jappy Messenger
//
//  Created by Johannes Bauer on 16.09.15.
//  Copyright (c) 2015 Johannes Bauer. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString* const kJBConnectivityChangedNotification;

typedef NS_ENUM(NSInteger, JBConnectivityState) {

	JBConnectivityStateDisconnected = 0,
	JBConnectivityStateConnectivity = 1,
	JBConnectivityStateReachability = 2,
	JBConnectivityStateConnected    = 3
};


@interface JBConnectivity : NSObject

@property (assign, nonatomic, readonly) JBConnectivityState state;
@property (strong, nonatomic) NSString *stateMutexLock;

- (void)watchConnection;

- (void)addStateFlag:(JBConnectivityState)stateFlag;
- (void)removeStateFlage:(JBConnectivityState)stateFlag;

- (BOOL)hasConnectivity;
- (BOOL)hasReachability;

- (void)connectivityChanged:(NSNotification*)notification;
- (void)reachabilityChanged:(NSNotification*)notification;

+ (instancetype)sharedInstance;

@end
