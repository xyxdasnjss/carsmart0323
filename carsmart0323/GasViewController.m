//
//  GasViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GasViewController.h"
#import "SearchFjViewController.h"
#import "SearchQyViewController.h"

#import "Reachability.h"
#import "ASIHTTPRequest.h"

#import <QuartzCore/QuartzCore.h>
#import "MapAnnotation.h"


@interface GasViewController ()
-(void)reachabilityChanged:(NSNotification*)note;
@end

@implementation GasViewController

@synthesize position_l;
@synthesize position1_l;

@synthesize locManager;

@synthesize map_v;



@synthesize str_lat;
@synthesize str_log;

@synthesize isNetWork;

@synthesize bestLocation;
@synthesize timespent;

@synthesize geocoder;





@synthesize mapView;
@synthesize setView;
@synthesize containerView;
@synthesize trackSwitch;

@synthesize routeLine;
@synthesize routeLineView;




#define MAX_TIME 3

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    
    if (mode==MKUserTrackingModeNone) {
        trackSwitch.on = NO;
    }
    
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    containerView = [[UIView alloc]initWithFrame:self.view.bounds];
    [containerView addSubview:self.mapView];
    
    [self.view addSubview:containerView];
    
    
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog( @"Block Says Reachable");
            
            isNetWork = YES;
            self.position_l.text = @"";
            self.title = @"";
            [self findme];
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog( @"Block Says Unreachable");
            isNetWork = NO;
            
            self.position_l.textColor = [UIColor redColor];
            self.position_l.text = @"网络连接失败,请打开网络,,,";
            
            
            
            //paoma
            [position_l sizeToFit];   
            CGRect frame = position_l.frame;  
            frame.origin.x = 320;  
            position_l.frame = frame;  
            
            
            [UIView beginAnimations:@"testAnimation" context:NULL];  
            (frame.size.width/position_l.frame.origin.x)>1?[UIView setAnimationDuration:(frame.size.width/position_l.frame.origin.x)*8.8f]:[UIView setAnimationDuration:8.8f];
            //    [UIView setAnimationDuration:(frame.size.width/320)*8.8f];    
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];    
            [UIView setAnimationDelegate:self];    
            [UIView setAnimationRepeatAutoreverses:NO];    
            [UIView setAnimationRepeatCount:999999];   
            
            frame = position_l.frame;  
            
            NSLog(@"%f",frame.size.width/320);
            frame.origin.x = -frame.size.width;
            
            position_l.frame = frame;  
            [UIView commitAnimations];  
            
            
            
            
            self.title = @"网络连接失败,请打开网络,,,";
            self.navigationItem.rightBarButtonItem = nil;
        });
    };
    
    
    
    [reach startNotifier];
    
    
    
    self.locManager = [[CLLocationManager alloc] init] ;
	self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locManager.distanceFilter = 5.0f; // in meters
	
    self.geocoder = [[CLGeocoder alloc] init];
    
    
    map_v.delegate = self;
    [map_v setMapType:MKMapTypeStandard];//MKMapTypeHybrid MKMapTypeStandard MKMapTypeSatellite
    
    if (isNetWork==YES) {
        [self findme];
        
        
        
    }
    
    
    
    //    [self loadRoute];
    //    [self.map_v addOverlay:self.routeLine];
    
    CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(39.92303400876581,116.33440017700195);
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(39.95449073417355,116.27603530883789);
    //    MKMapPoint* points;
    //    points[0] = MKMapPointForCoordinate(coord1);
    //    points[1] = MKMapPointForCoordinate(coord2);
    //    MKPolyline *line = [MKPolyline polylineWithPoints:points count:2];
    //    [map_v addOverlay: line];
    
    line_color = [UIColor redColor];
    
    route_view = [[UIImageView alloc]initWithFrame:map_v.frame];
    
    routes = [self calculate_routes_form:coord1 to:coord2];
    
    [self loadRoute];
    [self.map_v addOverlay:self.routeLine];
    
    
    
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoords:coord1];  
    annotation.title = @"起点";    
    //    annotation.subtitle = @"Subtitle";   
    [map_v addAnnotation:annotation];
    
    
    
    MapAnnotation *annotation1 = [[MapAnnotation alloc] initWithCoords:coord2];
    annotation1.title = @"终点";
    [map_v addAnnotation:annotation1];
    
    
    
    
    
    
    
    //    [self update_route_view];
    //    [self center_map];
    
    //    [map_v addSubview:route_view];
    
    
    //    route_view = [UIImageView alloc]initWithImage:[UIImage imageNamed:@""]]
}





-(void)findme{
    
    if (timespent==MAX_TIME||!timespent) {
        self.navigationItem.rightBarButtonItem = nil;
        
        timespent = 0;
        self.bestLocation = nil;
        self.locManager.delegate = self;
        [self.locManager startUpdatingLocation];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    }
    
    
    
    
    
}
-(void)tick:(NSTimer *)timer{
    
    //    NSLog(@"%d",timespent);
    
    if (++timespent>=MAX_TIME) {
        
        
        
        [timer invalidate];
        
        [self.locManager stopUpdatingLocation];
        self.locManager.delegate = nil;
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"定位" style:UIBarButtonItemStylePlain target:self action:@selector(findme)];
        
        
        self.title = [NSString stringWithFormat:@"精确度:%0.1f 米",self.bestLocation.horizontalAccuracy];
        
        //        
        //        [map_v setRegion:MKCoordinateRegionMakeWithDistance(self.bestLocation.coordinate, 800,800) animated:YES];
        
        
        //没什么太大的效果,想把自己的位置居中,,,//其实是UserLocation的位置是实时变化的,
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.map_v.userLocation.coordinate, 500,500);
        //        viewRegion.center = self.bestLocation.coordinate;
        viewRegion.center = map_v.userLocation.coordinate;
        MKCoordinateRegion adjustedRegion = [map_v regionThatFits:viewRegion];
        [map_v setRegion:adjustedRegion animated:YES];
        
        
        
		map_v.showsUserLocation = YES;
		map_v.zoomEnabled = YES;
        
        map_v.userLocation.title=@"实时位置";
        map_v.userLocation.subtitle = [NSString stringWithFormat:@"%f,%f",self.map_v.userLocation.coordinate.longitude,self.map_v.userLocation.coordinate.latitude];
        
        
        NSLog(@"%f:%f",self.bestLocation.coordinate.latitude,self.map_v.userLocation.coordinate.latitude);
        NSLog(@"%f:%f",self.bestLocation.coordinate.longitude,self.map_v.userLocation.coordinate.longitude);
        
        
        //        self.str_lat = [NSString stringWithFormat:@"%f",self.bestLocation.coordinate.latitude];
        //        self.str_log = [NSString stringWithFormat:@"%f",self.bestLocation.coordinate.longitude];
        
        self.str_lat = [NSString stringWithFormat:@"%f",self.map_v.userLocation.coordinate.latitude];
        self.str_log = [NSString stringWithFormat:@"%f",self.map_v.userLocation.coordinate.longitude];
        
        
        
        [NSThread detachNewThreadSelector:@selector(getNameByGps) toTarget:self withObject:nil];
        [NSThread detachNewThreadSelector:@selector(get:) toTarget:self withObject:nil];
        
        
    }else {
        
        
        self.title = [NSString stringWithFormat:@"剩余%d秒",MAX_TIME-timespent];
        
    }
}

-(void)get:(id)sender{
    NSLog(@"eee");
    
    [self.geocoder reverseGeocodeLocation:bestLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        
        NSString *str = [NSString stringWithFormat:@"%@",placemark.name];
        self.position1_l.text = [NSString stringWithFormat:@"%@",str];
        
        
        [position1_l sizeToFit];   
        CGRect frame = position1_l.frame;  
        frame.origin.x = 320;  
        position1_l.frame = frame;  
        
        
        [UIView beginAnimations:@"testAnimation" context:NULL];  
        (frame.size.width/position1_l.frame.origin.x)>1?[UIView setAnimationDuration:(frame.size.width/position1_l.frame.origin.x)*8.8f]:[UIView setAnimationDuration:8.8f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];    
        [UIView setAnimationDelegate:self];    
        [UIView setAnimationRepeatAutoreverses:NO];    
        [UIView setAnimationRepeatCount:999999];   
        
        frame = position1_l.frame;  
        frame.origin.x = -frame.size.width;
        
        position1_l.frame = frame;  
        [UIView commitAnimations];  
        
        //        MapAnnotation *ann = [[MapAnnotation alloc]initWithCoords:placemark.location.coordinate];
        //        ann.title = @"实际位置";
        //        ann.subtitle= [NSString stringWithFormat:@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
        //        ann.headImage = @"List.png"; 
        //        [map_v addAnnotation:ann];
        
        
        
    }];
}

-(void)getNameByGps {    
    
    
    NSString *baseurl = @"http://gis.beta.che08.cn:8080/sisserver?config=POSDES";
    baseurl = [baseurl stringByAppendingFormat:@"&x1=%@",[NSString stringWithFormat:@"%f",self.map_v.userLocation.coordinate.longitude]];
    baseurl = [baseurl stringByAppendingFormat:@"&y1=%@",[NSString stringWithFormat:@"%f",self.map_v.userLocation.coordinate.latitude]];
    baseurl = [baseurl stringByAppendingFormat:@"&a_k=0287c65abfcc462837e07a89c4897c0ff6ca8b6a8cd7e22f28f7d48bbd0622f4a765ddbe9a9b989f"];
    
    //    baseurl = @"http://api.che08.com/uc/ws/0.1/user/100027";
    
    //    NSLog(@"%@",baseurl);
    
	NSURL *url = [NSURL URLWithString:baseurl];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
	
	
    
	[urlRequest setHTTPMethod: @"GET"];
	
	[urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
	NSError *error;
	NSURLResponse *response;
	NSData *tw_result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
    
    NSString *result = nil;
    if(error){
        NSLog(@"something is wrong: %@", [error description]);
    }else{
        if(tw_result){
            
            
            //gbk
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            result = [[NSString alloc] initWithData:tw_result encoding:enc];
            //utf-8
            //            result = [[NSString alloc] initWithData:tw_result encoding:NSUTF8StringEncoding];
            //            NSLog(@"%@",tw_result);
        }
    }
    
    //    NSLog(@"%@",result);
    
    
    if (result) {
        self.position_l.text = [NSString stringWithFormat:@"当前位置:%@",result];
        
    }else {
        self.position_l.text = [NSString stringWithFormat:@"网络连接失败"];
        
    }
    
    [position_l sizeToFit];   
    CGRect frame = position_l.frame;  
    frame.origin.x = 320;  
    position_l.frame = frame;  
    
    
    [UIView beginAnimations:@"testAnimation" context:NULL];  
    (frame.size.width/position_l.frame.origin.x)>1?[UIView setAnimationDuration:(frame.size.width/position_l.frame.origin.x)*8.8f]:[UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];    
    [UIView setAnimationDelegate:self];    
    [UIView setAnimationRepeatAutoreverses:NO];    
    [UIView setAnimationRepeatCount:999999];   
    
    frame = position_l.frame;  
    frame.origin.x = -frame.size.width;
    
    position_l.frame = frame;  
    [UIView commitAnimations];  
    
    
}



- (IBAction)doZoomIn:(id)sender {
    if (isNetWork) {
        MKCoordinateRegion region = map_v.region;
        region.span.latitudeDelta=region.span.latitudeDelta * 1.3;
        region.span.longitudeDelta=region.span.longitudeDelta * 1.3;
        [map_v setRegion:region animated:YES];
    }
    
}

- (IBAction)doZoomOut:(id)sender {
    if (isNetWork) {
        MKCoordinateRegion region = map_v.region;
        region.span.latitudeDelta=region.span.latitudeDelta * 0.4;
        region.span.longitudeDelta=region.span.longitudeDelta * 0.4;
        [map_v setRegion:region animated:YES];
    }
    
    
    
}

- (IBAction)getPositionAction:(id)sender {
    if (isNetWork) {
        if (self.bestLocation) {
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.map_v.userLocation.coordinate, 500,500);
            viewRegion.center = self.map_v.userLocation.coordinate;
            MKCoordinateRegion adjustedRegion = [map_v regionThatFits:viewRegion];
            [map_v setRegion:adjustedRegion animated:YES];
        }else {
            [self findme];
        }
    }
    
    
}

- (IBAction)listAction:(id)sender {
    
    //    CLLocationCoordinate2D coords;   
    //    coords.latitude = 37.331689;    
    //    coords.longitude = 122.030731;   
    //    float zoomLevel = 1000;   
    
    
    //    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));  
    //    [map_v setRegion:[map_v regionThatFits:region] animated:YES];     
    //    MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoords:coords];  
    //    annotation.title = @"Apple";    
    //    annotation.subtitle = @"Subtitle";   
    //    [map_v addAnnotation:annotation]; 
    
}

- (IBAction)trackAction:(id)sender {
    
    
    if (self.navigationItem.rightBarButtonItem) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.75];
        
        
        
        [UIView setAnimationTransition:([self.mapView superview] ?
                                        UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
                               forView:containerView cache:YES];
        if ([setView superview])
        {
            [setView removeFromSuperview];
            [containerView addSubview:self.mapView];
            
            if (trackSwitch.on) {
                [map_v setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
            }else {
                [map_v setUserTrackingMode:MKUserTrackingModeNone animated:YES];
            }
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"定位" style:UIBarButtonItemStylePlain target:self action:@selector(findme)];
            
        }
        else
        {
            [self.mapView removeFromSuperview];
            [containerView addSubview:setView];
            
            
            
            self.title = @"CarSmart";
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(trackAction:)];
        }
        
        [UIView commitAnimations];
    }
    
	
    
    
	
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    
    //私有api
//    newLocation = [[MKLocationManager sharedLocationManager] _applyChinaLocationShift:newLocation]; 
    
    
//    NSLog(@"1111111");
    
    //    if (!self.bestLocation) 
    //        self.bestLocation = newLocation;
    //	else if (newLocation.horizontalAccuracy >  bestLocation.horizontalAccuracy) 
    self.bestLocation = newLocation;
	
	map_v.region = MKCoordinateRegionMake(self.bestLocation.coordinate, MKCoordinateSpanMake(0.1f, 0.1f));
	map_v.showsUserLocation = YES;
	map_v.zoomEnabled = NO;
    
    
    
    str_lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    str_log = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    
    //    self.map_v removeAnnotations:<#(NSArray *)#>
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    [ann setCoordinate:newLocation.coordinate];

//    MapAnnotation *ann = [[MapAnnotation alloc]initWithCoords:newLocation.coordinate];
//    
//    
//    
    ann.title = @"裸gps";
    ann.subtitle= [NSString stringWithFormat:@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
//    ann.headImage = @"Location.png"; 
    [map_v addAnnotation:ann];
//    
//    MKPointAnnotation *ann1 = [[MKPointAnnotation alloc] init];
//    [ann1 setCoordinate:newLocation.coordinate];
//    [map_v addAnnotation:ann1];
    
    
    [NSThread detachNewThreadSelector:@selector(get:) toTarget:self withObject:nil];
    
}



- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation {  
    if ([annotation isKindOfClass:[MKUserLocation class]])  
        return nil;  
    if ([annotation isKindOfClass:[MapAnnotation class]]) {     
        static NSString* travellerAnnotationIdentifier = @"TravellerAnnotationIdentifier";  
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)  
        [map_v dequeueReusableAnnotationViewWithIdentifier:travellerAnnotationIdentifier];  
        if (!pinView)  
        {  
            // if an existing pin view was not available, create one  
            MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]  
                                                  initWithAnnotation:annotation reuseIdentifier:travellerAnnotationIdentifier];  
            
            customPinView.animatesDrop = YES;//从天而降的效果
            customPinView.pinColor = MKPinAnnotationColorPurple;
            
            
            
            //            UIImage *image = [UIImage imageNamed:@"icon.png"];  
            //            customPinView.image = image;  //将图钉变成笑脸。 
            
            //注,自定义pin图片会被animatesDrop/pinColor覆盖
            
            
            customPinView.canShowCallout = YES;  //很重要，运行点击弹出标签  
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];  
            [rightButton addTarget:self  
                            action:@selector(showDetails:)  //点击右边的按钮之后，显示另外一个页面  
                  forControlEvents:UIControlEventTouchUpInside];  
            customPinView.rightCalloutAccessoryView = rightButton;  
            
            MapAnnotation *travellerAnnotation = (MapAnnotation *)annotation;  
            UIImageView *headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:travellerAnnotation.headImage]];  
            customPinView.leftCalloutAccessoryView = headImage; //设置最左边的头像  
            //            [headImage release];  
            
            customPinView.opaque = YES;
            
            return customPinView;  
        }  
        else  
        {  
            pinView.annotation = annotation;  
        }  
        return pinView;  
    }  
    return nil;  
} 

-(void)showDetails:(id)sender{
    NSLog(@"click");
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"位置失败 ,原因:%@",error);
}



-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        CFShow(@"Notification Says Reachable");
        isNetWork = YES;
    }
    else
    {
        
        CFShow(@"Notification Says Unreachable");
        isNetWork = NO;
        
    }
}






-(void) loadRoute
{
    //    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"csv"];
    //    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSArray* pointStrings = routes;
    
//    NSLog(@"111%@",pointStrings);
    
    // while we create the route points, we will also be calculating the bounding box of our route
    // so we can easily zoom in on it.
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint; 
    
    // create a c array of points.
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    
    for(int idx = 0; idx < pointStrings.count; idx++)
    {
        // break the string down even further to latitude and longitude fields.
        NSString* currentPointString = [pointStrings objectAtIndex:idx];
        NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        CLLocationDegrees latitude = [[latLonArr objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
        // create our coordinate and add it to the correct spot in the array
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        //
        // adjust the bounding box
        //
        
        // if it is the first point, just use them, since we have nothing to compare to yet.
        if (idx == 0) {
            northEastPoint = point;
            southWestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if(point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southWestPoint.x)
                southWestPoint.x = point.x;
            if (point.y < southWestPoint.y)
                southWestPoint.y = point.y;
        }
        
        pointArr[idx] = point;
        
    }
    
    // create the polyline based on the array of points.
    routeLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
    
    
    ////    _routeRect =
    
    
    [self.map_v setVisibleMapRect:MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y)];
    
    //    
    //    // clear the memory allocated earlier for the points
    free(pointArr);
    
} 
//将这个路径MKPolyline对象添加到地图上
//[self.map_v addOverlay:self.routeLine]; 
//显示在地图上：
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay
{
    
    //    if ([overlay isKindOfClass:[MKPolyline class]]) 
    //    {
    //        MKPolylineView *lineview=[[MKPolylineView alloc] initWithOverlay:overlay];
    //        lineview.strokeColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
    //        lineview.lineWidth=2.0;
    //      
    //        return lineview;
    //    }
    
    
    MKOverlayView* overlayView = nil;
    
    if(overlay == routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == routeLineView)
        {
            routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            routeLineView.fillColor = [UIColor blueColor];
            routeLineView.strokeColor = [UIColor blueColor];
            routeLineView.lineWidth = 3;
        }
        
        overlayView = self.routeLineView;
        
    }
    
    return overlayView;
    
} 


-(NSArray *)calculate_routes_form:(CLLocationCoordinate2D)f to:(CLLocationCoordinate2D)t{
    
    NSString* saddr = [NSString stringWithFormat:@"%f,%f",f.latitude,f.longitude];
    NSString* daddr = [NSString stringWithFormat:@"%f,%f",t.latitude,t.longitude];
    
    
    //    http://maps.google.com/maps/api/directions/json?origin=39.940145,116.408471&destination=39.899431,116.384267&sensor=true
    
    //&waypoints=39.940556,116.408739%7C39.933218,116.417108%7C39.932839,116.406250%7C39.907052,116.374364
    
    
    CLLocationCoordinate2D coords;   
    
    
    
    coords.latitude = 39.93244621864724;    
    coords.longitude = 116.31036758422852;   
    MapAnnotation *annotation3 = [[MapAnnotation alloc] initWithCoords:coords];
    annotation3.title = @"途经点1";
    [map_v addAnnotation:annotation3];
    
    coords.latitude = 39.94751622278565;    
    coords.longitude = 116.24736785888672;  
    MapAnnotation *annotation4 = [[MapAnnotation alloc] initWithCoords:coords];
    annotation4.title = @"途经点2";
    [map_v addAnnotation:annotation4];
    
    
    
    
    NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/api/directions/json?origin=%@&destination=%@&waypoints=39.93244621864724,116.31036758422852|39.94751622278565,116.24736785888672&sensor=true&mode=driving",saddr,daddr];
    
    apiUrlStr = [apiUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"%@",apiUrlStr);
    
    NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
    
    NSLog(@"url==%@",apiUrl);
    
    
    
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:apiUrl];
    [request startSynchronous];
    NSString *apiResponse = [request responseString];
    
//    NSLog(@"%@",apiResponse);
    
    NSError *error;
    NSDictionary *dic_data = [NSJSONSerialization JSONObjectWithData:[apiResponse dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    
    
    NSArray *dic_routes = [dic_data objectForKey:@"routes"];
    
    NSDictionary *legs = [dic_routes objectAtIndex:0];
    
    NSDictionary *temp = [legs objectForKey:@"overview_polyline"];
    NSString *end_points = [temp objectForKey:@"points"];
    
//    NSLog(@"===:%@",end_points);
    
    return [self decodePolyLine:[end_points mutableCopy]];
    
    
}

-(NSMutableArray *)decodePolyLine:(NSMutableString *)encoded{
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSInteger lat = 0 ;
    NSInteger lng = 0;
    while (index<len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b =[ encoded characterAtIndex:index++]-63;
            result |= (b&0x1f)<<shift;
            shift+=5;
            
        } while (b>=0x20);
        NSInteger dlat = ((result&1)?~(result>>1):(result>>1));
        lat +=dlat;
        shift = 0;
        result = 0;
        do {
            b =[ encoded characterAtIndex:index++]-63;
            result |= (b&0x1f)<<shift;
            shift+=5;
            
        } while (b>=0x20);
        NSInteger dlng = ((result &1)?~(result>>1):(result>>1));
        lng +=dlng;
        NSNumber *latitude = [[NSNumber alloc]initWithFloat:lat *1e-5];
        NSNumber *longitude = [[NSNumber alloc]initWithFloat:lng *1e-5];
        
//        NSLog(@"%@",latitude);
//        NSLog(@"%@",longitude);
        
        //        CLLocation *loc = [[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        
        
        //        [array addObject:loc];
        
        //        NSLog(@"aaa:%@",array);
        NSString *str = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
        [array addObject:str];
        
    }
    return array;
    
}


//没用到，

-(void)update_route_view{
    CGContextRef context = CGBitmapContextCreate(nil, route_view.frame.size.width, 
                                                 route_view.frame.size.height, 
                                                 8, 
                                                 4*route_view.frame.size.width, 
                                                 CGColorSpaceCreateDeviceRGB(), 
                                                 kCGImageAlphaPremultipliedLast);
    
//    NSLog(@"\n%f,%f",route_view.frame.size.width,route_view.frame.size.height);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 4.0);
    
    for (int i =0; i<routes.count; i++) {
        CLLocation* location_ = [routes objectAtIndex:i];
        CGPoint point = [map_v convertCoordinate:location_.coordinate toPointToView:route_view];
        
        if (i==0) {
            CGContextMoveToPoint(context, point.x, route_view.frame.size.height-point.y);
        }else {
            CGContextAddLineToPoint(context, point.x, route_view.frame.size.height -point.y);
        }
    }
    
    CGContextStrokePath(context);
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage* img = [UIImage imageWithCGImage:image];
    
    route_view.image = img;
    CGContextRelease(context);
    
}
-(void)center_map{
    
    MKCoordinateRegion region;
    
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    
    for (int idx=0; idx<routes.count; idx++) {
        CLLocation *currentLocation = [routes objectAtIndex:idx];
        if (currentLocation.coordinate.latitude>maxLat) {
            maxLat = currentLocation.coordinate.latitude;
        }
        if (currentLocation.coordinate.latitude<minLat) {
            minLat = currentLocation.coordinate.latitude;
        }
        if(currentLocation.coordinate.longitude>maxLon){
            maxLon = currentLocation.coordinate.longitude;
        }
        if(currentLocation.coordinate.longitude<minLon){
            minLon = currentLocation.coordinate.longitude;
        }
    }
    
    region.center.latitude = (maxLat+minLat)/2;
    region.center.longitude = (maxLon + minLon)/2;
    region.span.latitudeDelta = maxLat-minLat;
    region.span.longitudeDelta = maxLon - minLon;
    
    [map_v setRegion:region animated:YES ];
    
    
}


- (void)viewDidUnload {
    [self setMap_v:nil];
    
    [self setPosition1_l:nil];
    
    [self setMapView:nil];
    [self setSetView:nil];
    [self setTrackSwitch:nil];
    [super viewDidUnload];
}
@end



