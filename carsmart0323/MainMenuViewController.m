//
//  MainMenuViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GasViewController.h"

#import "SearchFjViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "MenuListViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize photo_iv;


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
    
    self.navigationItem.title = @"车网互联";
    
    photo_iv.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [photo_iv addGestureRecognizer:singleTap];

    
}


- (IBAction)gasAction:(id)sender {
    

    
    SearchFjViewController *fj = [[SearchFjViewController alloc ] initWithNibName:@"SearchFjViewController" bundle:nil];
    
    [self.navigationController pushViewController:fj animated:YES];
    
    
}

- (IBAction)takePicAction:(id)sender {
    
    [self openCamera];
    
}
- (IBAction)posAction:(id)sender {
    
    GasViewController *gas = [[GasViewController alloc]initWithNibName:@"GasViewController" bundle:nil];
    
    [self.navigationController pushViewController:gas animated:YES];
    
}

-(void) openCamera{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } 
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.sourceType = sourceType;
    
    [self presentModalViewController:picker animated:YES];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"000");
    [picker dismissModalViewControllerAnimated:YES];
    
    photo_iv.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //
    //UIImageWriteToSavedPhotosAlbum(photo_iv.image,self,nil,nil);
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    CFShow(@"111");
    [picker dismissModalViewControllerAnimated:YES];
}



- (IBAction)album:(id)sender {
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
   // picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:picker animated:YES];
    

    
    
    
}

- (IBAction)jpAction:(id)sender {
    
    //创建一个基于位图的图形上下文
    //将整个self.view大小的图层形式创建一张图片image 
    UIGraphicsBeginImageContext(self.view.bounds.size);
    //renderInContext 呈现接受者及其子范围到指定的上下文
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //返回一个基于当前图形上下文的图片
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    
	
    //以png格式返回指定图片的数据
    //imageData = UIImagePNGRepresentation(aImage);
    
   
    UIGraphicsEndImageContext();
    //然后将该图片保存到图片图
    UIImageWriteToSavedPhotosAlbum(image,self,nil,nil);
}

- (IBAction)tzAction:(id)sender {
      
    [NSThread detachNewThreadSelector:@selector(myMethod) toTarget:self withObject:nil]; 
    
    
}

-(void)myMethod{
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.che08.com"]];
}


- (IBAction)saveAction:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if (!documentsDirectory) {
        NSLog(@"directiory not found!");
    }else {
        NSString *appfile = [documentsDirectory stringByAppendingPathComponent:@"text"];
        
        NSData *aData = [appfile dataUsingEncoding: NSUTF8StringEncoding];
        
        NSLog(@"%d",[aData writeToFile:appfile atomically:YES]);
    }
    
    

    
}

- (IBAction)readAction:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"text"];
    NSData *myData = [[NSData alloc] initWithContentsOfFile:appFile];
    
    NSString *str = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    
}


-(void)onClickImage{
    
    NSLog(@"imageview is clicked!");
    GasViewController *gas = [[GasViewController alloc]initWithNibName:@"GasViewController" bundle:nil];
    [self.navigationController pushViewController:gas animated:YES];
}

- (IBAction)listAction:(id)sender {
    
    
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init ];
    backbutton.title = @"返回";
    
    self.navigationItem.backBarButtonItem = backbutton;
    
    
    MenuListViewController *list = [[MenuListViewController alloc]initWithNibName:@"MenuListViewController" bundle:nil];
    
    [self.navigationController pushViewController:list animated:YES];
    
}

- (void)viewDidUnload
{
    [self setPhoto_iv:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
