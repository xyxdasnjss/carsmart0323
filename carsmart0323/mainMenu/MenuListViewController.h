//
//  MenuListViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListViewController : UITableViewController{
    
 
    NSMutableDictionary *menus;
}

@property (nonatomic,retain) NSMutableDictionary *menus;
@end
