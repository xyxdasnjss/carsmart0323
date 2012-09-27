//
//  SearchQyViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchQyViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *province_l;
@property (weak, nonatomic) IBOutlet UILabel *city_l;
@property (weak, nonatomic) IBOutlet UIButton *province_btn;

@property (weak, nonatomic) IBOutlet UIButton *city_btn;

@end
