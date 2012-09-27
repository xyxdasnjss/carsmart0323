//
//  RegisterViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UITextField *psw_tf;
@property (weak, nonatomic) IBOutlet UITextField *repsw_tf;

@property(weak,nonatomic) NSString *str_name;
@property(weak,nonatomic) NSString *str_password;

@end
