//
//  CoreDataViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataViewController : UIViewController<NSFetchedResultsControllerDelegate>{
    
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    
}

@property (nonatomic, retain)NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain)NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain)NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITextView *result_tv;


@end
