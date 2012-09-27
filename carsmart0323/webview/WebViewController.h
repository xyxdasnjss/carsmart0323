//
//  WebViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *web_v;
@property (weak, nonatomic) IBOutlet UITextField *url_tf;

@end
