//
//  FjListViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FjListViewController.h"
#import "ASIHTTPRequest.h"


@interface FjListViewController ()

@end

@implementation FjListViewController
@synthesize position_l;
@synthesize info_l;
@synthesize str_lat;
@synthesize str_log;
@synthesize str_info;
@synthesize str_position;
@synthesize allDates;
@synthesize list_table;

@synthesize select_price;
@synthesize current_num;
@synthesize totalnums;
@synthesize allPrices;






- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.position_l.text = str_position;
    
    
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
    
    
    self.info_l.text = str_info;
   
    [self.list_table setBackgroundColor: [UIColor clearColor]];
//    [self.list_table initWithStyle:UITableViewStyleGrouped];
    
  
    
    
    [self getDate];
    
    
}

- (void)getDate
{
//    NSURL *url = [NSURL URLWithString:@"http://api.che08.com/tdu/ws/0.1/petrol/selectByNearby?p_type=p93b&lng=116.230618&lat=39.936683&range=3"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];

    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    
    // 当以文本形式读取返回内容时用这个方法
    //NSString *responseString = [request responseString];
    
//    NSLog(@"%@",responseString);
    
   NSString *responseString=@"{\"北京\":{\"北京1\":1,\"北京2\":2,\"北京3\":3},\"上海\":{\"上海1\":4,\"上海2\":5,\"上海3\":6}}"; 
    
    
 //   NSDictionary *myClassDict = [temp JSONValue]; 
    
 
        NSError *error = nil;
//        id jsonObject = [NSJSONSerialization JSONObjectWithData:responseString options:NSJSONReadingAllowFragments error:&error];
//        if (jsonObject != nil && error == nil){
//            NSLog(@"Successfully deserialized...");
//            if ([jsonObject isKindOfClass:[NSDictionary class]]){
//                NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
//                NSLog(@"Dersialized JSON Dictionary = %@", deserializedDictionary);
//            } else if ([jsonObject isKindOfClass:[NSArray class]]){
//                NSArray *deserializedArray = (NSArray *)jsonObject;
//                NSLog(@"Dersialized JSON Array = %@", deserializedArray);
//            } else {
//                NSLog(@"An error happened while deserializing the JSON data.");
//            }
//        }
//       
//
    
    
//    NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
   // NSLog(@"%@",[resDic description]);
    
    
//    NSLog(@"%d",resDic.allKeys.count);
    
   // responseString = @"";
    
    
    allDates = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    
    
    [allDates description];
    
    
    
//    for (int i=0; i<allDates.allKeys.count; i++) {
//        NSString *text = [allDates.allKeys objectAtIndex:i];
//        if ([text isEqualToString:@"totalnums"]) {
//            
//            totalnums = [allDates.allValues objectAtIndex:i];
//            
//        }else if ([text isEqualToString:@"result"]) {
//           // allPrices = [allDates.allValues objectAtIndex:i];
//            
////            allPrices = [NSJSONSerialization JSONObjectWithData:[[allDates.allValues objectAtIndex:i] dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
//            
////             NSLog(@"%@",[allPrices description]);
//            
//        }
//    }
    
    
    
    
    
    
    
    
    
    [self.list_table reloadData];
    
//    NSDictionary *myClassDict = [responseString JSONValue];
 

       
    
    
    
    // 当以二进制形式读取返回内容时用这个方法
//    NSData *responseData = [request responseData];
}





- (void)requestFailed:(ASIHTTPRequest *)request
{
//    NSError *error = [request error];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"count :%d",allDates.allKeys.count);
    
    return allDates.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gaslistnear"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:style reuseIdentifier:@"gaslistnaea"];
    }
    
    NSArray *key = allDates.allKeys;
    NSString *text = [key objectAtIndex:indexPath.row];
//    NSArray *value = allDates.allValues;
    
//    NSString *detailText = [value objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
//    cell.detailTextLabel.text = detailText;
    
    UIImage *image = [UIImage imageNamed:@"fenzujiantou.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
    
	[button setBackgroundImage:image forState:UIControlStateNormal];

	cell.backgroundColor = [UIColor clearColor];
    
	cell.accessoryView = button;
    

    return cell;
    
}





- (void)viewDidUnload
{
    [self setPosition_l:nil];
    [self setInfo_l:nil];
    [self setList_table:nil];
    [super viewDidUnload];
    
}



@end
