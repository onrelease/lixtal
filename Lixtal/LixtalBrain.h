//
//  LixtalBrain.h
//  Lixtal
//
//  Created by Michael Jensen on 10/01/14.
//  Copyright (c) 2014 Michael Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>

// Pass in objects one by one with collect:
// and the Collector will report statistics about those objects.

@interface LixtalBrain: NSObject
{
	NSMutableDictionary *counts;
}

// Pass in an object here

- (void)collect:(id)anObject;
- (NSString *)lix:(id)anObject;
- (NSString *)trim:(id)anObject;


@property (readonly) int totalStringCount;			// how many times an NSString object was passed in
@property (readonly) int totalNumberCount;			// how many times an NSNumber object was passed in
@property (readonly) int capitalizedStringCount;	// how many times a capitalized NSString was passed in

@property (readonly) NSSet *strings;		// all the unique NSString objects that were ever passed in
@property (readonly) NSSet *numbers;		// all the unique NSNumber objects that were ever passed in

@property (readonly) void clearCounts;
@property (nonatomic, retain) NSString *showList;

@end
