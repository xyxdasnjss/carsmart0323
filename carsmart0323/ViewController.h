//
//  ViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    
    NSManagedObjectContext *managedObjectContext;
    
}

@property (nonatomic, retain)NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UITextField *psw_tf;

@property (weak,nonatomic) NSString *str_name;
@property (weak,nonatomic) NSString *str_psw;

@property UIImage *pic;


@property (weak, nonatomic) IBOutlet UIImageView *t_iv;

@property (weak, nonatomic) IBOutlet UILabel *hh_l;


@end
