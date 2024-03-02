//
//  Utilties.m
//  Yoga
//
//  Created by Paul Wilkinson on 1/18/19.
//  Copyright © 2019 Paul Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Utilities.h"

static const size_t kBufSize = 1024;

const char* GetResourceFilePath(const char* resource, const char* type)
{
	static char buf[kBufSize];
	//NSString* filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"bin"];
	NSString* filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:resource] ofType:[NSString stringWithUTF8String:type]];
	const char* pc = [filePath UTF8String];
	strncpy(buf, pc, kBufSize);
	assert(strlen(buf) < kBufSize);
	return buf;
}
