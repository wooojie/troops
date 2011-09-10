//
//  MapPoint.m
//  Whereami
//
//  Created by Bing W on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
	[super init];
	coordinate = c;
	[self setTitle:t];
	return self;
}

- (void)dealloc
{
	[title release];
	[super dealloc];
}

@end
