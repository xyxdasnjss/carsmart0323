//
//  TableDemoViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableDemoViewController.h"
#import <QuartzCore/CAAnimation.h>

@interface TableDemoViewController ()

@end

@implementation TableDemoViewController
@synthesize testView;


@synthesize items;
@synthesize delButton;
@synthesize editButton;
@synthesize cancelButton;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)resetUI{
    
    self.navigationItem.rightBarButtonItem = self.editButton;
//    self.navigationItem.backBarButtonItem 
    
    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.backBarButtonItem = backButton;
    
    [self.tableView setEditing:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    

    
    [self resetUI];
    
    items = [[NSMutableDictionary alloc]init];
    
    [items setObject:@"object1" forKey:@"key1"];
    [items setObject:@"object2" forKey:@"key2"];
    [items setObject:@"object3" forKey:@"key3"];
    [items setObject:@"object4" forKey:@"keyf1"];
    [items setObject:@"object5" forKey:@"kefsdy1"];
    [items setObject:@"object6" forKey:@"kesdfy1"];
    [items setObject:@"object7" forKey:@"kafsey1"];
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
//    self.tableView.delegate = self;
    
    
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc]initWithTitle:@"button1" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonClick1)];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonClick2)];
    UIBarButtonItem *button3 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"List.png"] landscapeImagePhone:[UIImage imageNamed:@"Location.png"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonClick1)];
    
    
    [buttons addObject:button1];
    [buttons addObject:button2];
    [buttons addObject:button3];
    
    UIToolbar *tools = [[UIToolbar alloc]init];
    [tools setItems:buttons animated:YES];
    
    self.navigationItem.titleView = tools;
    
    [tools sizeToFit];
    
}
-(void)buttonClick1{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.0f];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(resetUI)];
    //    [self.tableView setTransform:CGAffineTransformMakeScale(0.25f, 0.25f)];
    [self.tableView setTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations]; 
    
    
    

//    [UIView beginAnimations:@"Curl"context:nil];//动画开始   
//    [UIView setAnimationDuration:0.75];  
//    [UIView setAnimationDelegate:self];  
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp 
//                           forView:self.tableView cache:YES];  
////    [self.tableView removeFromSuperview];  
//    [UIView commitAnimations];  
    
    
    
    
}
-(void)buttonClick2{
    
    CATransition *animation = [CATransition animation];  
    [animation setDuration:1.25f];  
//    [animation setTimingFunction:UIViewAnimationCurveEaseIn];//???会报错 

    
//    [animation setType:kCATransitionReveal];  
//    [animation setSubtype: kCATransitionFromBottom];  

    [animation setType:@"rippleEffect"];
    
    [self.view.layer addAnimation:animation forKey:@"Reveal"];  
    
   
    
    
}

- (void)viewDidUnload
{
    [self setDelButton:nil];
    [self setEditButton:nil];
    [self setCancelButton:nil];

    [self setTestView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 76;
    
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CFShow(@"111");
//    [self.tableView setEditing:YES animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CFShow(@"111");
    
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    CFShow(@"111");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//    }
//    
//    
//    if (items.count>0) {
//        cell.textLabel.text = [items.allValues objectAtIndex:indexPath.row];
//    }
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil] lastObject];
    }
    

    
    
    [((UILabel *)[cell viewWithTag:101]) setText:[items.allValues objectAtIndex:indexPath.row]];
    [((UILabel *)[cell viewWithTag:102]) setText:@"地址地址地址地址地址地址地址地址"];
    [((UILabel *)[cell viewWithTag:103]) setText:@"$9.0"];
    [((UILabel *)[cell viewWithTag:104]) setText:@"100米"];
    
   
    
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView.isEditing) {
        
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        NSString *deleteButtonTitle = [NSString stringWithFormat:@"删除(%d)",selectedRows.count];
        
        
       
        
        if (selectedRows.count == self.items.count)
        {
            deleteButtonTitle = @"全部删除";
        }
        self.delButton.title = deleteButtonTitle;
        
    }else {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.isEditing) {
        NSArray *arrayRows = [tableView indexPathsForSelectedRows];
        NSString *delButtonTitle = [NSString stringWithFormat:@"删除(%d)",arrayRows.count];
        
        
        if (arrayRows.count==self.items.count) {
            delButtonTitle = @"全部删除";
        }
        
        
        self.delButton.title = delButtonTitle;
    }
}

- (IBAction)editAction:(id)sender {
    
    self.navigationItem.rightBarButtonItem = self.cancelButton;
    self.navigationItem.leftBarButtonItem = self.delButton;
    
    self.delButton.title = @"全部删除";
    [self.tableView setEditing:YES animated:YES];
    
    
    
}

- (IBAction)delAction:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil];
    
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    switch (buttonIndex) {
        case 0:{
            
            
            
            break;
            
        }
            
            
            
        default:
            break;
    }
    
    [self resetUI];
    
}

- (IBAction)cancelAction:(id)sender {
    
    [self resetUI];
    
}
@end
