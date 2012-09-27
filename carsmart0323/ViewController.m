//
//  ViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MainMenuViewController.h"
#import "RegisterViewController.h"

#import "SearchFjViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import "Utils.h"

#import "FjListViewController.h"
#import "GasViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize name_tf;
@synthesize psw_tf;

@synthesize str_name;
@synthesize str_psw;

@synthesize pic;
@synthesize t_iv;
@synthesize hh_l;

@synthesize managedObjectContext;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"车网互联";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(userRegister)];
    
//    self.pic = [UIImage imageNamed:@"background.jpg"];//初始化图片
//    
//    [NSTimer scheduledTimerWithTimeInterval:(0.2) target:self selector:@selector(ontime) userInfo:nil repeats:YES];
    
    t_iv.userInteractionEnabled= YES;
    
    
    
   
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [t_iv addGestureRecognizer:singleTap];
   
    
    NSLog(@"手机号码是,%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SBFormattedPhoneNumber"]); 
    
    
    
//    hh_l.lineBreakMode = UILineBreakModeWordWrap; 
//    hh_l.numberOfLines = 0;
    
    
    NSString * xstring=@"换行\ntest";
    hh_l.text = xstring;
    

    
}

-(void)onClickImage{
    
    NSLog(@"imageview is clicked!");
    
    
    GasViewController *gas = [[GasViewController alloc]initWithNibName:@"GasViewController" bundle:nil];
    
    [self.navigationController pushViewController:gas animated:YES];
    
} 






-(void)login{
    
//    NSLog(@"login");
    
//    FjListViewController *fj = [[FjListViewController alloc]initWithNibName:@"FjListViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:fj animated:YES];
    
    
     MainMenuViewController *main = [[MainMenuViewController alloc]initWithNibName:@"MainMenuViewController" bundle:nil];
    [self.navigationController pushViewController:main animated:YES];
    

    
    
    
//    if (name_tf.text.length==0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号不能为空,请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        
//        [alert show];
//        
//        return;
//        
//    }
//    
//    if (psw_tf.text.length==0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不能为空,请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        
//        [alert show];
//        
//        return;
//        
//    }
//
//    
//    if ([name_tf.text isEqualToString:@"xyxd"]&&[psw_tf.text isEqualToString:@"xyxd"]) {
//        
//        MainMenuViewController *main = [[MainMenuViewController alloc]initWithNibName:@"MainMenuViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:main animated:YES];
//    }else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        
//        [alert show];
//    }
    
    
//    NSURL *url = [NSURL URLWithString:[ NSString stringWithFormat:@"http://api.che08.com/uc/ws/0.1/login?username=%@&password=%@&provider=CARSMART",name_tf.text,psw_tf.text]];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        [request setDelegate:self];
//    [request startAsynchronous];    
    
    
//    NSString *urlString = [NSString stringWithFormat:@"http://api.che08.com/uc/ws/0.1/login"];
//    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    
    //设置需要POST的数据，这里提交两个数据，A=a&B=b
    
//    [requestForm setPostValue:name_tf.text forKey:@"username"];
//    [requestForm setPostValue:[Utils md5HexDigest:psw_tf.text] forKey:@"password"];
//    [requestForm setPostValue:@"CARSMART" forKey:@"provider"];
    
    
    NSString *psw = [Utils md5HexDigest:@"qqqqqq"];
    NSLog(@"%@",psw);
//    
//    NSString *body = [ NSString stringWithFormat:@"username=xyxd&password=%@&provider=CARSMART",@"xyxd",psw];
//    
//    //body = @"username=xyxd&password=xyxd&provider=CARSMART";
//    [requestForm appendPostData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [requestForm setDelegate:self];
//    [requestForm startAsynchronous];
    
    
    
}
-(void)userRegister{
    
    NSLog(@"register");
    
    RegisterViewController *view = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init ];
    backbutton.title = @"返回";
    
    self.navigationItem.backBarButtonItem = backbutton;
    
    
    [self.navigationController pushViewController:view animated:YES];
    
//    SearchFjViewController *view = [[SearchFjViewController alloc]initWithNibName:@"SearchFjViewController" bundle:nil];
//    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)grabURLInBackground:(id)sender
{
    
   

    
    NSURL *url = [NSURL URLWithString:[ NSString stringWithFormat:@"http://api.che08.com/uc/ws/0.1/login?username=%@&password=%@&provider=CARSMART",str_name,str_psw]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
       
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    //获取http协议执行代码
    NSLog(@"Code:%d",[request responseStatusCode]);
    
    // 当以文本形式读取返回内容时用这个方法
     NSString *responseString = [request responseString];
    // 当以二进制形式读取返回内容时用这个方法
     NSData *responseData = [request responseData];
    
     NSLog(@"%@\n",responseString);
    
      NSLog(@"-------------------------------\n");
     NSLog(@"%@\n",responseData);
    
     NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
      NSLog(@"%@\n",result);
    
    
    
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"-------------------------------\n");
    NSLog(@"error:%@",error);
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==name_tf) {
        if (name_tf.text.length==0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号不能为空,请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
            
        }
    }
    
    if (textField==psw_tf) {
        [self login];
    }
  //  [self login];
    
     
    [self resignFirstResponder];
    
    
    return YES;
}




//点击textField其他部分,键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [name_tf resignFirstResponder];
    
    [psw_tf resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
    
}



//- (IBAction)abc:(id)sender {
//    
//    NSURL *url = [NSURL URLWithString:@"http://api.che08.com/uc/ws/0.1/user/100027"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request startAsynchronous];
//    
//}
//
//- (IBAction)grabURLInBackground:(id)sender
//{
//    NSURL *url = [NSURL URLWithString:@"http://api.che08.com/uc/ws/0.1/user/100027"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request startAsynchronous];
//}
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    // 当以文本形式读取返回内容时用这个方法
//    NSString *responseString = [request responseString];
//    
//    
//    // responseString = [[NSString alloc] responseString encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"string,%@",responseString);
//    
//    
//    
//    // 当以二进制形式读取返回内容时用这个方法
//    NSData *responseData = [request responseData];
//    
//    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"data,%@",responseString);
//}
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    NSError *error = [request error];
//    
//    NSLog(@"error,%@",error);
//}




- (void)viewDidUnload
{
    [self setName_tf:nil];
    [self setPsw_tf:nil];
    [self setT_iv:nil];
    [self setHh_l:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



@end
