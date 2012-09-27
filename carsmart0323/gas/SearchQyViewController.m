//
//  SearchQyViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchQyViewController.h"

@interface SearchQyViewController ()

@end

@implementation SearchQyViewController
@synthesize province_l;
@synthesize city_l;
@synthesize province_btn;
@synthesize city_btn;

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
    NSArray *items = [NSArray arrayWithObjects:@"附近查找",@"区域查找", nil];
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:items];
    seg.selectedSegmentIndex = 1;
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    
    
    
    self.navigationItem.titleView = seg;
    
    
}

- (IBAction)provinceAction:(id)sender {
    
    CFShow(@"click");
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"确定", nil];
    [sheet showInView:self.view];
    
    UIPickerView *pick = [[UIPickerView alloc]init];
    pick.dataSource = self;
    pick.delegate = self;
    pick.tag = 101;
    pick.showsSelectionIndicator = YES;
//    [sheet addSubview:sheet];
    [sheet addSubview:pick];
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set Combo", nil];
//	[actionSheet showInView:self.view];
//    
//	UIPickerView *pickerView = [[UIPickerView alloc] init];
//	pickerView.tag = 101;
//	pickerView.delegate = self;
//	pickerView.dataSource = self;
//	pickerView.showsSelectionIndicator = YES;
//    
//	[actionSheet addSubview:pickerView];
	
	
    
    
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 20;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"test%d",row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"你选择的是,%d",row);
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"index:%d",buttonIndex);
    
//    UIPickerView *pickerView = (UIPickerView *)[actionSheet viewWithTag:101];
//    
//	self.title = [NSString stringWithFormat:@"%d", [pickerView selectedRowInComponent:0]];
	
}



- (IBAction)cityAction:(id)sender {
}




- (void)viewDidUnload
{
    [self setProvince_l:nil];
    [self setCity_l:nil];
    [self setProvince_btn:nil];
    [self setCity_btn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
