//
//  GasViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface GasViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>{
    
    CLLocationManager *locManager;
    CLLocation *bestLocation;
    CLGeocoder *geocoder;
   
	int timespent;
    
    MKPolyline *routeLine;
    MKPolylineView *routeLineView;
    
    //采集的数据,主要是从google地图中得到路线的坐标
    NSArray *routes;
    //线路使用的颜色
    UIColor *line_color;
    //路线,绘制为一张图片加载在这个view上
    UIImageView* route_view;
   
}

@property (retain) MKPolyline *routeLine;
@property (retain) MKPolylineView *routeLineView;



@property (weak, nonatomic) IBOutlet UILabel *position_l;
@property (weak, nonatomic) IBOutlet UILabel *position1_l;

@property (retain)CLLocationManager *locManager;

@property (retain) CLGeocoder *geocoder;

@property (weak, nonatomic) IBOutlet MKMapView *map_v;



@property(retain)CLLocation *bestLocation;
@property int timespent;

@property (weak,nonatomic) NSString *str_log;
@property (weak,nonatomic) NSString *str_lat;

@property (nonatomic) BOOL isNetWork;




@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIView *setView;
@property (nonatomic,retain) UIView *containerView;

@property (weak, nonatomic) IBOutlet UISwitch *trackSwitch;


@end
