//
//  FjListViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FjListViewController : UIViewController{
    NSMutableDictionary *allDates;
    NSString *totalnums;
    NSString *current_num;
    NSMutableDictionary *allPrices;
    NSString *select_price;
    
}

@property (weak, nonatomic) IBOutlet UILabel *position_l;
@property (weak, nonatomic) IBOutlet UILabel *info_l;

@property (retain,nonatomic) NSString *str_log;
@property (retain,nonatomic) NSString *str_lat;

@property (weak,nonatomic) NSString *str_position;
@property (weak,nonatomic) NSString *str_info;

@property (retain,nonatomic) NSMutableDictionary *allDates;

@property (weak, nonatomic) IBOutlet UITableView *list_table;


@property (retain,nonatomic) NSString *totalnums;
@property (retain,nonatomic) NSString *current_num;
@property (retain,nonatomic) NSMutableDictionary *allPrices;
@property (retain,nonatomic) NSString *select_price;


@end
