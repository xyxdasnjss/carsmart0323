//
//  SearchFjViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchFjViewController.h"
#import "FjListViewController.h"

@interface SearchFjViewController ()

@end

@implementation SearchFjViewController
@synthesize position_l;
@synthesize yh_btn;
@synthesize fw_btn;
@synthesize locManager;
@synthesize str_log;
@synthesize str_lat;

@synthesize yhArray;
@synthesize fwArray;
@synthesize yhIndex;
@synthesize fwIndex;
@synthesize yhvArray;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
 	
    
    
    self.yhArray = [[NSMutableArray alloc]init];
    
    [self.yhArray addObject:@"请选择油号"];
    [self.yhArray addObject:@"90号汽油"];
    [self.yhArray addObject:@"93号汽油"];
    [self.yhArray addObject:@"97号汽油"];
    [self.yhArray addObject:@"98号汽油"];
    [self.yhArray addObject:@"0号柴油"];
    [self.yhArray addObject:@"5号柴油"];
    [self.yhArray addObject:@"-10号柴油"];
    [self.yhArray addObject:@"-20号柴油"];
    [self.yhArray addObject:@"-30号柴油"];
    [self.yhArray addObject:@"-35号柴油"];
    [self.yhArray addObject:@"cng天然气"];
    [self.yhArray addObject:@"90#乙醇"];
    [self.yhArray addObject:@"93#乙醇"];
    [self.yhArray addObject:@"95#乙醇"];
    [self.yhArray addObject:@"97#乙醇"];
    [self.yhArray addObject:@"M30甲醇"];
    
    

    
    self.yhvArray = [[NSMutableArray alloc]init];
    
    [self.yhvArray addObject:@""];
    [self.yhvArray addObject:@"p90b"];
    [self.yhvArray addObject:@"p93b"];
    [self.yhvArray addObject:@"p97b"];
    [self.yhvArray addObject:@"p98b"];
    [self.yhvArray addObject:@"p0b"];
    [self.yhvArray addObject:@"p5b"];
    [self.yhvArray addObject:@"pa10b"];
    [self.yhvArray addObject:@"pa20b"];
    [self.yhvArray addObject:@"pa30b"];
    [self.yhvArray addObject:@"pa35b"];
    [self.yhvArray addObject:@"pcng"];
    [self.yhvArray addObject:@"pe90b"];
    [self.yhvArray addObject:@"pe93b"];
    [self.yhvArray addObject:@"pe95b"];
    [self.yhvArray addObject:@"pe97b"];
    [self.yhvArray addObject:@"pm30"];
	    
    self.fwArray = [[NSMutableArray alloc]init];
    [self.fwArray addObject:@"请选择范围"];
    [self.fwArray addObject:@"1 千米"];
    [self.fwArray addObject:@"3 千米"];
    [self.fwArray addObject:@"5 千米"];
    [self.fwArray addObject:@"9 千米"];
    [self.fwArray addObject:@"12 千米"];
    [self.fwArray addObject:@"15 千米"];
    [self.fwArray addObject:@"30 千米"];
    [self.fwArray addObject:@"50 千米"];
    [self.fwArray addObject:@"100 千米"];
    
    
    
    
    
    
    self.locManager = [[CLLocationManager alloc] init] ;
//	if (!self.locManager.locationServicesEnabled)
//	{
//		NSLog(@"User has opted out of location services");
//		return;
//	}
	
	self.locManager.delegate = self;
	self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    
	self.locManager.distanceFilter = 5.0f; // in meters
	[self.locManager startUpdatingLocation];

}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"接收到新的位置");
    //NSLog(@"%@",newLocation);
    
    NSLog(@"纬度: %f",newLocation.coordinate.latitude);
    NSLog(@"经度: %f",newLocation.coordinate.longitude);
    
    str_lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    str_log = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    
    //    NSString *str_lat = 
    //    NSString *str_log = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    //(getNameByLat:([NSString stringWithFormat:@"%f",newLocation.coordinate.latitude]) Log:([NSString stringWithFormat:@"%f",newLocation.coordinate.longitude]) withObject:nil waitUntilDone:NO])
    
    
    //    [self performSelectorOnMainThread:@selector([getNameByLat:str_lat Log:str_log]:) withObject:nil waitUntilDone:NO]; 
    
    [self performSelectorOnMainThread:@selector(getNameByGps) withObject:nil waitUntilDone:NO]; 
    
    
    
    
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"位置失败");
}

-(void)get{
    NSLog(@"eee");
}

//-(void)getNameByLat:(NSString *)lat Log:(NSString *)log {
 -(void)getNameByGps {    
    NSString *baseurl = @"http://gis.beta.che08.cn:8080/sisserver?config=POSDES";
    baseurl = [baseurl stringByAppendingFormat:@"&x1=%@",str_log];
    baseurl = [baseurl stringByAppendingFormat:@"&y1=%@",str_lat];
    baseurl = [baseurl stringByAppendingFormat:@"&a_k=0287c65abfcc462837e07a89c4897c0ff6ca8b6a8cd7e22f28f7d48bbd0622f4a765ddbe9a9b989f"];
    
    //baseurl = @"http://api.che08.com/uc/ws/0.1/user/100027";
    
    NSLog(@"%@",baseurl);
    
	NSURL *url = [NSURL URLWithString:baseurl];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
	
	
    
	[urlRequest setHTTPMethod: @"GET"];
	
	[urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
	NSError *error;
	NSURLResponse *response;
	NSData *tw_result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
    
    NSString *result = nil;
    if(error){
        NSLog(@"something is wrong: %@", [error description]);
    }else{
        if(tw_result){
            
            
            //gbk
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            result = [[NSString alloc] initWithData:tw_result encoding:enc];
            //utf-8
            //            result = [[NSString alloc] initWithData:tw_result encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",tw_result);
        }
    }
    
//    NSLog(@"%@",result);
    
    
    if (result) {
        self.position_l.text = [NSString stringWithFormat:@"当前位置:%@",result];

    }else {
        self.position_l.text = [NSString stringWithFormat:@"网络连接失败"];

    }
        
    [position_l sizeToFit];   
    CGRect frame = position_l.frame;  
    frame.origin.x = 320;  
    position_l.frame = frame;  
    
    
    [UIView beginAnimations:@"testAnimation" context:NULL];  
    (frame.size.width/position_l.frame.origin.x)>1?[UIView setAnimationDuration:(frame.size.width/position_l.frame.origin.x)*8.8f]:[UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];    
    [UIView setAnimationDelegate:self];    
    [UIView setAnimationRepeatAutoreverses:NO];    
    [UIView setAnimationRepeatCount:999999];   
    
    frame = position_l.frame;  
    frame.origin.x = -frame.size.width;
    
    position_l.frame = frame;  
    [UIView commitAnimations];  
    
    
}

- (IBAction)yhAction:(id)sender {
    
    UIActionSheet *yh = [[UIActionSheet alloc]initWithTitle:@"请选择油号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    yh.tag = 101;
    for (int i=0; i<yhArray.count; i++) {
        [yh addButtonWithTitle:[yhArray objectAtIndex:i]];
        yhIndex = i;
        
    }
  
    [yh showInView:self.view];
    
}
- (IBAction)fwAction:(id)sender {
    
    UIActionSheet *fw = [[UIActionSheet alloc]initWithTitle:@"请选择范围" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    fw.tag = 102;
    for (int i=0; i<fwArray.count; i++) {
        [fw addButtonWithTitle:[fwArray objectAtIndex:i]];
        fwIndex = i;
        
    }
    
    [fw showInView:self.view];
    
    
}

- (IBAction)searchAction:(id)sender {
    
    if(yhIndex==0||fwIndex==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"油号或范围不能为空,请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }else {
       
        FjListViewController *fjList= [[FjListViewController alloc]initWithNibName:@"FjListViewController" bundle:nil];
        
   
        fjList.str_log = self.str_log;

        fjList.str_lat = self.str_lat;
        
     
        
        fjList.str_position = self.position_l.text;
        fjList.str_info = [ NSString stringWithFormat:@"查找范围:据此地点%@ %@",[self.fw_btn titleForState:UIControlStateNormal ],[self.yh_btn titleForState:UIControlStateNormal ]];
     
        [self.navigationController pushViewController:fjList animated:YES];
        
        
        
    }
    
    
}




-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"%d",buttonIndex);
    
    if (actionSheet.tag==101) {
        [self.yh_btn setTitle:[yhArray objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }else if(actionSheet.tag==102){
        [self.fw_btn setTitle:[fwArray objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    }
    
    
    
}

- (void)viewDidUnload
{
    [self setPosition_l:nil];
    [self setYh_btn:nil];
    [self setFw_btn:nil];
    [super viewDidUnload];
    
}



@end
