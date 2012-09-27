//
//  AppDelegate.m
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize naviController;

//@synthesize managedObjectModel;
//@synthesize managedObjectContext;
//@synthesize persistentStoreCoordinator;



-(void)applicationDidFinishLaunching:(UIApplication *)application{
  
    
    window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    naviController = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
       
    [window addSubview:naviController.view];
    [window makeKeyAndVisible];

//    window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
//    ViewController *viewController = [[ViewController alloc]init];
//    
//    NSManagedObjectContext *context = [self managedObjectContext];
//	if (!context) {
//		// Handle the error.
//		NSLog(@"Unresolved error (no context)");
//		exit(-1);  // Fail
//	}
//	viewController.managedObjectContext = context;
//    
//    naviController = [[UINavigationController alloc]initWithRootViewController:viewController];
//    
//    [window addSubview:naviController.view];
//    [window makeKeyAndVisible];
    
    
    
}




@end
