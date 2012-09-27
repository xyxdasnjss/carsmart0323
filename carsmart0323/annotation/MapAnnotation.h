//
//  MapAnnotation.h
//  carsmart0323
//
//  Created by xyxd on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
    

    CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
    NSString *headImage;
}

-(id) initWithCoords:(CLLocationCoordinate2D) coords;

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *headImage; 

@end
