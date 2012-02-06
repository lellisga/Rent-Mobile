//
//  MapViewController.h
//  RentMobile
//
//  Created by Li Ellis on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>

@interface MapViewController : UIViewController <MKReverseGeocoderDelegate,MKMapViewDelegate>{	
	IBOutlet MKMapView *mapView;
	MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
	IBOutlet UISegmentedControl *mapType;

}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
-(IBAction)showInfo;
- (IBAction)changeType:(id) sender;

@end
