//
//  MapPoint.m
//  Whereami
//
//  Created by Bing W on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize coordinate, title, tagDate, subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
	[super init];
	coordinate = c;

	[self setTagDate:[NSDate dateWithTimeIntervalSinceNow:0]];
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"dd/MM/yy HH:mm:ss"];
	NSString *dateStr = [dateformatter stringFromDate:tagDate];
	
	[self setTitle:t];
	[self setSubtitle:[NSString stringWithFormat:@"tag date: %@",dateStr]];
	[dateformatter release];
	return self;
}

- (void)dealloc
{
	[tagDate release];
	[subtitle release];
	[title release];
	[super dealloc];
}

@end
