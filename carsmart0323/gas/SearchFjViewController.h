//
//  SearchFjViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchFjViewController : UIViewController<CLLocationManagerDelegate,UIActionSheetDelegate>{
    CLLocationManager *locManager;
    
    NSMutableArray *yhArray;
    NSMutableArray *fwArray;
    NSMutableArray *yhvArray;
    NSInteger yhIndex;
    NSInteger fwIndex;
}

@property (retain) CLLocationManager *locManager;
@property (weak, nonatomic) IBOutlet UILabel *position_l;
@property (weak, nonatomic) IBOutlet UIButton *yh_btn;
@property (weak, nonatomic) IBOutlet UIButton *fw_btn;

@property (retain,nonatomic) NSString *str_log;
@property (retain,nonatomic) NSString *str_lat;

@property (retain) NSMutableArray *yhArray;
@property (retain) NSMutableArray *fwArray;
@property (retain) NSMutableArray *yhvArray;
@property (nonatomic) NSInteger yhIndex;
@property (nonatomic) NSInteger fwIndex;
@end
