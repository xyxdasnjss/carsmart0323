//
//  MenuListViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MenuListViewController.h"
#import "CoreDataViewController.h"
#import "TableDemoViewController.h"
#import "WebViewController.h"
#import "PlayerViewController.h"

@interface MenuListViewController ()

@end

@implementation MenuListViewController
@synthesize menus;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"功能列表";
    
    CoreDataViewController *coredata = [[CoreDataViewController alloc]initWithNibName:@"CoreDataViewController" bundle:nil];
    
    TableDemoViewController *table = [[TableDemoViewController alloc]initWithNibName:@"TableDemoViewController" bundle:nil];
    
    WebViewController *web = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    
    
    PlayerViewController *av = [[PlayerViewController alloc]initWithNibName:@"PlayerViewController" bundle:nil];
    
    
    
    
    
    self.menus = [NSMutableDictionary dictionary];

    [self.menus setObject:coredata forKey:@"CoreData"];
    [self.menus setObject:table forKey:@"Table Demo"];
    [self.menus setObject:web forKey:@"跳转到网页"];
    [self.menus setObject:av forKey:@"播放音乐"];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    if (menus.count>0) {
        NSArray *array = menus.allKeys;
        
       
        
        
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CFShow(@"000");
    //    [self.tableView setEditing:YES animated:YES];
    
}

//滑动删除,,,
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CFShow(@"111");
//     [self.tableView setEditing:YES animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    CFShow(@"222");
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = menus.allValues;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]init];
    
    button.title = @"返回";
    
    self.navigationItem.backBarButtonItem = button;
    
    
    [self.navigationController pushViewController:[array objectAtIndex:indexPath.row] animated:YES];
    
    
    //点击后非选中状态,
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
}

@end
