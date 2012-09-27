//
//  RegisterViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"

#import "Utils.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize name_tf;
@synthesize psw_tf;
@synthesize repsw_tf;

@synthesize str_name;
@synthesize str_password;

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
    
//    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init ];
//    backbutton.title = @"返回";
//    
//    self.navigationItem.backBarButtonItem = backbutton;
    
    
    
}

- (void)viewDidUnload
{
    [self setName_tf:nil];
    [self setPsw_tf:nil];
    [self setRepsw_tf:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)grabURLInBackground:(id)sender
{
    
    str_name = name_tf.text;
    str_password = psw_tf.text;
    
   
    
    //开启iphone网络开关
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://api.che08.com/uc/ws/0.1/registry/alias"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    
    //超时时间
    request.timeOutSeconds = 30;
    
    
   // ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
   
    
    
    
    NSString *str_json = [NSString stringWithFormat:@"{\"alias\"=\"%@\",\"password\"=\"%@\"}",@"dfdsfsd",@"dfsdfdsdf"];
    
    NSLog(@"%@",str_json);
    
    [request appendPostData:[str_json dataUsingEncoding:NSUTF8StringEncoding]];
    
  
    
    //415
//    [request setPostValue:@"alias" forKey:@"dafdsfdsf"];
//    
//    [request setPostValue:@"password" forKey:@"fdfdsfdsfds"];

    
    
    [request setDelegate:self];
    [request startAsynchronous];
    
//    [request setDelegate:self];
//    [request setDidFailSelector:@selector(requestDidFailed:)];
//    [request setDidFinishSelector:@selector(requestDidSuccess:)];
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    //获取http协议执行代码
    NSLog(@"Code:%d",[request responseStatusCode]);
    
    // 当以文本形式读取返回内容时用这个方法
   // NSString *responseString = [request responseString];
    // 当以二进制形式读取返回内容时用这个方法
   // NSData *responseData = [request responseData];
    
   // NSLog(@"%@\n",responseString);
   
  //  NSLog(@"-------------------------------\n");
   // NSLog(@"%@\n",responseData);
    
  // NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
   //  NSLog(@"%@\n",result);
    
//    NSDictionary *headers = [request responseHeaders];
//    NSLog(@"%@",headers);
   
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"-------------------------------\n");
    NSLog(@"error:%@",error);
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField  
//{ //当点触textField内部，开始编辑都会调用这个方法。textField将成为first responder   
//    NSTimeInterval animationDuration = 0.30f;      
//    CGRect frame = self.view.frame;  
//    frame.origin.y -=216;  
//    frame.size.height +=216;  
//    self.view.frame = frame;  
//    [UIView beginAnimations:@"ResizeView" context:nil];  
//    [UIView setAnimationDuration:animationDuration];  
//    self.view.frame = frame;                  
//    [UIView commitAnimations];                  
//}  
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    NSTimeInterval animationDuration = 0.30f;  
//    CGRect frame = self.view.frame;      
//    frame.origin.y +=216;        
//    frame.size. height -=216;     
//    self.view.frame = frame;  
//    //self.view移回原位置    
//    [UIView beginAnimations:@"ResizeView" context:nil];  
//    [UIView setAnimationDuration:animationDuration];  
//    self.view.frame = frame;                  
//    [UIView commitAnimations];
    
    if (textField==name_tf) {
        if (name_tf.text.length==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    }
    
    
    [textField resignFirstResponder];
    
    return YES;
}



@end
