//
//  Person.h
//  carsmart0323
//
//  Created by xyxd on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Person : NSManagedObject{
    
}

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *sex;

@end
