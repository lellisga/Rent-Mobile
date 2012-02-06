//
//  OptionViewController.h
//  RentMobile
//
//  Created by Li Ellis on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OptionViewController : UIViewController {

	 UITableView *tableView;
	 UITextField *txtfield;
	UIPickerView *pickerView;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextField *txtfield;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@end
