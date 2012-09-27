//
//  CoreDataViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "CoreDataViewController.h"
#import "Person.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;

@synthesize fetchedResultsController;
@synthesize result_tv;

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
    

    [self initCoreData];
    
}

-(void)initCoreData{
    
    NSError *error;
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/person_00.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:path];
//    BOOL needsBuilding = ![[NSFileManager defaultManager] fileExistsAtPath:path];
    
    
    
    // Init the model, coordinator, context
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        NSLog(@"Error %@",[error localizedDescription]);
    }else {
        self.managedObjectContext = [[NSManagedObjectContext alloc]init];
        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    
    
}


- (IBAction)addAction:(id)sender {
    
    Person *person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    person.name = @"xyxd1";
    person.sex = @"man1";
    

    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"error %@",[error localizedDescription]);
        
        result_tv.text = [NSString stringWithFormat:@"error %@",[error localizedDescription]];
        
    }else {
        result_tv.text = @"添加数据成功";
    }
    
}

-(void)fetchObjects{
    
    result_tv.text = @"进入查询";
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
    [fetchRequest setSortDescriptors:descriptors];
    
    
    NSError *error;
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"error %@",[error localizedDescription]);
        result_tv.text = [NSString stringWithFormat:@"error %@",[error localizedDescription]];

        
    }else {
        
        for(Person *person in self.fetchedResultsController.fetchedObjects){
            NSLog(@"name is :%@",[person name]);
            
            result_tv.text = [NSString stringWithFormat:@"name is :",[person name]];
        }
   
    }
    
    self.fetchedResultsController.delegate = self;
    
    
   
//    NSFetchRequest *request=[[NSFetchRequest alloc] init];
//    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:[self managedObjectContext]];
//    [request setEntity:entity];
//    NSArray *results=[[[self managedObjectContext] executeFetchRequest:request error:&error] copy];
//    for (Person *p in results) {
//        NSLog(@">> p.name: %@",p.name);
//    }
   
	
//	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
//	if (mutableFetchResults == nil) {
//		// Handle the error.
//	}
//	
//    NSLog(@"111,%@",mutableFetchResults);
	

}

- (IBAction)showAction:(id)sender {
    
    [self fetchObjects];   
    
    
//    NSLog(@"222,%@",[self.fetchRequestController.fetchedObjects objectAtIndex:0]);
//    
//    Person *person = (Person *)[self.fetchRequestController.fetchedObjects objectAtIndex:0];
//    
////    person.name = @"111";
//    NSLog(@"%@",[person name]);
//    
////    NSLog(@"-----------");
    
//    for(Person *person in self.fetchedResultsController.fetchedObjects){
////        person.sex = @"333";
//        NSLog(@"%@ : %@ : %@ : %@",person.name,person.sex,[person name],person);
//       
//    }
    

    
}

- (IBAction)delAction:(id)sender {
    
    [self fetchObjects];
    if (!self.fetchedResultsController.fetchedObjects.count) {
        NSLog(@"No data");
        
        result_tv.text = @"no data!";
        
        return;
    }
    
    for (Person *person in self.fetchedResultsController.fetchedObjects) {
        [self.managedObjectContext deleteObject:person];
    }
    
    result_tv.text = @"del success!";
}

- (IBAction)updateAction:(id)sender {
    
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:@"ddd"];
    [array addObject:@"333"];
    
    NSLog(@"%@",[array description]);
    
}




- (void)viewDidUnload
{
    [self setResult_tv:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
