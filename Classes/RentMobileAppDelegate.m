//
//  RentMobileAppDelegate.m
//  RentMobile
//
//  Created by Li Ellis on 11/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RentMobileAppDelegate.h"

@implementation RentMobileAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
	
	
	[window addSubview:tabBarController.view];
			
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
