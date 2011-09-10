//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Bing W on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

@implementation WhereamiAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	locationManager = [[CLLocationManager alloc] init];
	
	[locationManager setDelegate:self];
	[locationManager setDistanceFilter:kCLDistanceFilterNone];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//	[locationManager startUpdatingLocation];
	[mapView setShowsUserLocation:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"%@", newLocation);
	
	NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
	
	if (t < -180) {
		return;
	}
	NSString *str = [[NSString alloc] initWithString: [locationTitleField text]];
	NSLog(@"here: %@", str);
	MapPoint *mp = [[MapPoint alloc] initWithCoordinate:[newLocation coordinate] title:[locationTitleField text]];
	[mapView addAnnotation:mp];
	[mp release];
	[mapView setCenterCoordinate:[mp coordinate] animated:YES];
	[self foundLocation];
}

- (void)locationManager:(CLLocationManager *)manager 
	   didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location: %@", error);
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 100, 100);
	[mv setRegion:region animated:YES];
	[mv setCenterCoordinate:[mp coordinate] animated:YES];		
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf
{
	NSLog(@"%@", [tf text]);
	[self findLocation];
	[tf resignFirstResponder];
	return YES;
}

- (void)findLocation
{
	[locationManager startUpdatingLocation];
	[activityIndicator startAnimating];
	[locationTitleField setHidden:YES];
}

- (void)foundLocation
{
	[locationTitleField setText:@"cool"];
	[activityIndicator stopAnimating];
	[locationTitleField setHighlighted:NO];
	[locationManager stopUpdatingLocation];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
