//
//  MapAnnotation.m
//  carsmart0323
//
//  Created by xyxd on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize headImage;

- (id) initWithCoords: (CLLocationCoordinate2D) aCoordinate
{
	if (self = [super init]) {
        coordinate = aCoordinate;
    }
        
	return self;
}


-(void)dealloc{
    self.title = nil;
    self.subtitle = nil;
}

@end
