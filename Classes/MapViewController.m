//
//  MapViewController.m
//  RentMobile
//
//  Created by Li Ellis on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "/usr/include/sqlite3.h"


@implementation MapViewController
@synthesize mapView;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"viewDidLoad MapViewController");
	[super viewDidLoad];

	mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
	//mapView.showsUserLocation=TRUE;
	//mapView.mapType=MKMapTypeHybrid;
	
	mapView.showsUserLocation=TRUE;
	mapView.mapType=MKMapTypeStandard;
	mapView.delegate=self;
	
	/*Region and Zoom*/
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	CLLocationCoordinate2D location=mapView.userLocation.coordinate;
	
	location.latitude=40.814849;
	location.longitude=-73.622732;
	region.span=span;
	region.center=location;
	
	/*Geocoder Stuff*/
	
	geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:location];
	geoCoder.delegate=self;
	[geoCoder start];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
	[self.view insertSubview:mapView atIndex:0];

	
}

- (IBAction)changeType:(id)sender{
	
	NSLog(@"log %@",sender);
	
	if(mapType.selectedSegmentIndex==0){
		mapView.mapType=MKMapTypeStandard;
	}
	else if (mapType.selectedSegmentIndex==1){
		mapView.mapType=MKMapTypeSatellite;
	}
	else if (mapType.selectedSegmentIndex==2){
		mapView.mapType=MKMapTypeHybrid;
	}
}


- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	annView.animatesDrop=TRUE;
	return annView;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	NSLog(@"viewDidUnload MapViewController");
}


- (void)dealloc {
	[mapView release];
    [super dealloc];
}


@end
