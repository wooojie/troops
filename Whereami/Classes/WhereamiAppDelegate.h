//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Bing W on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    UIWindow *window;
	CLLocationManager *locationManager;
	
	IBOutlet MKMapView *mapView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UITextField *locationTitleField;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)findLocation;
- (void)foundLocation;

@end

