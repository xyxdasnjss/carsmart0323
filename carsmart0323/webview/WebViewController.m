//
//  WebViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize web_v;
@synthesize url_tf;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    web_v.delegate = self;
    
    self.web_v.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    NSURL * url=[NSURL URLWithString:@"http://www.che08.com"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.web_v loadRequest:request];
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"default",@"BlackTranslucent",@"BlackOpaque", nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:array];
    seg.selectedSegmentIndex = 0;
      
    //添加事件
    [seg addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    self.navigationItem.titleView = seg;


    
    
   
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    UIApplication *myApp = [UIApplication sharedApplication];
    
    switch (Seg.selectedSegmentIndex) {
        case 0:{
            [myApp setStatusBarStyle:UIStatusBarStyleDefault];
            break;
        }
        case 1:{
            [myApp setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
            break;
        }
        case 2:{
            [myApp setStatusBarStyle:UIStatusBarStyleBlackOpaque];
            break;
        }
            
        default:
            
            [myApp setStatusBarStyle:UIStatusBarStyleDefault];
            break;
    }
    
   
    
    
}

- (void)viewDidUnload
{
    [self setWeb_v:nil];
    [self setUrl_tf:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    NSURL * url=[NSURL URLWithString:@"http://www.che08.com"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.web_v loadRequest:request];
    
    
    [textField resignFirstResponder];
    return YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = !app.networkActivityIndicatorVisible;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = !app.networkActivityIndicatorVisible;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
