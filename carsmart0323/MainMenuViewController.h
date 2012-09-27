//
//  MainMenuViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photo_iv;
@end
