//
//  TableDemoViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDemoViewController : UITableViewController<UIActionSheetDelegate>

@property (nonatomic, retain) NSMutableDictionary *items;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *delButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;



- (IBAction)editAction:(id)sender;

- (IBAction)delAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *testView;


@end
