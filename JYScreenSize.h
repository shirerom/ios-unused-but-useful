//
//  JYScreenSizeType.h
//  Jappy Messenger
//
//  Created by Johannes Bauer on 11.09.14.
//  Copyright (c) 2014 Johannes Bauer. All rights reserved.
//

typedef enum {
	JYScreenSizeTypeUnknown,
	JYScreenSizeTypeIphone4,
	JYScreenSizeTypeIphone5,
	JYScreenSizeTypeIphone6,
	JYScreenSizeTypeIphone6Plus
} JYScreenSizeType;


@interface JYScreenSize : NSObject

+ (JYScreenSizeType)type;

@end
