//
//  OptionViewController.m
//  RentMobile
//
//  Created by Li Ellis on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"
#import "/usr/include/sqlite3.h"

@implementation OptionViewController
@synthesize tableView;
@synthesize txtfield;
@synthesize pickerView;

NSString *latitude;
NSString *longitude;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	NSMutableArray *arrayColors;
	arrayColors = [[NSMutableArray alloc] init];
	[arrayColors addObject:@"Red"];
	[arrayColors addObject:@"Orange"];
	[arrayColors addObject:@"Yellow"];
	[arrayColors addObject:@"Green"];
	[arrayColors addObject:@"Blue"];
	[arrayColors addObject:@"Indigo"];
	[arrayColors addObject:@"Violet"];
	
	
	
	
	UIAlertView *view;
	
	sqlite3 *database;
	
	int result = sqlite3_open("/Users/liellis/input/rental", &database);	
	if(result != SQLITE_OK)
	{
		sqlite3_close(database);
		view = [[UIAlertView alloc]
				initWithTitle: @"Database Error"
				message: @"Failed to open database."
				delegate: self
				cancelButtonTitle: @"Hrm." otherButtonTitles: nil];
		[view show];
		[view autorelease];
		return;
	}
	
	sqlite3_exec(database,
				 "CREATE TABLE IF NOT EXISTS Messages (ID INTEGER PRIMARY KEY AUTOINCREMENT, Message TEXT)",
				 NULL, NULL, NULL);
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY h:mm a, zzz"];
	
	sqlite3_stmt *statement;	
	sqlite3_prepare_v2(database, "SELECT id FROM Messages", -1, &statement, nil);
	NSString *id;
	
	if(sqlite3_step(statement) == SQLITE_ROW){
		
		id = [[NSString alloc] initWithUTF8String:
			  (char *)sqlite3_column_text(statement, 0)];
		
		sqlite3_exec(database,
					 [[NSString stringWithFormat:@"update Messages set  Message = 'You ran the app at %@' where id = %@",[dateFormat stringFromDate:today] ,id] UTF8String],NULL, NULL, NULL);
	}else{
		
		sqlite3_exec(database, [[NSString stringWithFormat:
								 @"INSERT INTO Messages VALUES(NULL, 'You ran the app at %@')",
								 [dateFormat stringFromDate:today]]
								UTF8String], NULL, NULL, NULL);   				
	}
					
	[dateFormat release];	
		
	sqlite3_prepare_v2(database, "SELECT * FROM GeoCoding", -1, &statement, nil);
	
	while(sqlite3_step(statement) == SQLITE_ROW){
		
		NSString *message = [[NSString alloc] initWithUTF8String:
							 (char *)sqlite3_column_text(statement, 2)];
		
		longitude = [[NSString alloc] initWithUTF8String:
							   (char *)sqlite3_column_text(statement, 3)];
		latitude = message;
		
		NSLog(@"Latitude: %@",latitude);
		NSLog(@"Longitude: %@",longitude);
						
		
		NSLog(message);		
		
		
		view = [[UIAlertView alloc]
				initWithTitle: @"A Message"
				message: message
				delegate: self
				cancelButtonTitle: @"Woot!" otherButtonTitles: nil];
		[view show];
		[view autorelease];
		[message release];
	}
	
	sqlite3_finalize(statement);
	
	sqlite3_close(database);
	
	
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
	NSLog(@"viewDidUnload option");

}


- (void)dealloc {
	[tableView dealloc];
	[txtfield dealloc];
    [super dealloc];
}


@end
