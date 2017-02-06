//
//  ViewController.m
//  Copy Uber  Car Moving Animation
//
//  Created by xiaoliuTX on 2017/2/6.
//  Copyright © 2017年 xiaoliuTX. All rights reserved.
//

#import "ViewController.h"
#import "MapBusAnnotationView.h"
#import "NSTimer+Blocks.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ViewController () <BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong) BMKPointAnnotation *busAnnotation;
@property (nonatomic, strong) MapBusAnnotationView *busAnnotationView;
@property (nonatomic, strong) NSTimer *timer;
//_busLatitude;
//coor.longitude = _busLongitude;
@property (nonatomic, assign) CGFloat busLatitude;
@property (nonatomic, assign) CGFloat busLongitude;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) NSArray *busLocationsArray;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.title = @"车辆移动Demo";
    
    // Do any additional setup after loading the view, typically from a nib.
    self.busAnnotation = [[BMKPointAnnotation alloc] init];
    [self.mapView addAnnotation:self.busAnnotation];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.rotateEnabled = NO;
    self.mapView.overlookEnabled = NO;
    self.busLocationsArray = @[
                               @{@"longitude":@"113.945567",
                                 @"latitude":@"22.5453149",
                                 @"angle":@"181"
                                 },
                               @{@"longitude":@"113.947096",
                                 @"latitude":@"22.545055",
                                 @"angle":@"79"
                                 },
                               @{@"longitude":@"113.950056",
                                 @"latitude":@"22.5451769",
                                 @"angle":@"87"
                                 },
                               @{@"longitude":@"113.952322",
                                 @"latitude":@"22.545244",
                                 @"angle":@"88"
                                 },
                               @{@"longitude":@"113.954561",
                                 @"latitude":@"22.545362",
                                 @"angle":@"100"
                                 },
                               @{@"longitude":@"113.9563579",
                                 @"latitude":@"22.5428059",
                                 @"angle":@"184"
                                 },
                               @{@"longitude":@"113.956305",
                                 @"latitude":@"22.542166",
                                 @"angle":@"212"
                                 },
                               
                               @{@"longitude":@" 113.9527049",
                                 @"latitude":@"22.5419659",
                                 @"angle":@"269"
                                 },
                               @{@"longitude":@"113.952367",
                                 @"latitude":@"22.5419969",
                                 @"angle":@"265"
                                 },
                               @{@"longitude":@"113.952322",
                                 @"latitude":@"22.545244",
                                 @"angle":@"88"
                                 },
                               @{@"longitude":@" 113.952117",
                                 @"latitude":@"22.53966399",
                                 @"angle":@"179"
                                 },
                               @{@"longitude":@"113.952072",
                                 @"latitude":@"22.5389039",
                                 @"angle":@"200"
                                 },
                               ];
    
    BMKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake(22.5, 114);
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.5;
    span.longitudeDelta =0.5;
    region.span = span;
    [self.mapView setRegion:region];
    self.timer = [NSTimer customScheduledTimerWithTimeInterval:5 block:^{
        [self updateBusLocation];
    } repeats:YES];
    [self.timer fire];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    NSString *AnnotationViewID = @"renameMark";
    MapBusAnnotationView *annotationView = (MapBusAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil)
    {
        annotationView = [[MapBusAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        annotationView.image = [UIImage imageNamed:@"bus_backView"];
        
        annotationView.busImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(annotationView.frame), CGRectGetHeight(annotationView.frame))];
        annotationView.busImageView.image = [UIImage imageNamed:@"bus_location"];
        [annotationView addSubview:annotationView.busImageView];
        annotationView.canShowCallout = NO;
        
        [annotationView.superview bringSubviewToFront:annotationView];
    }
    
    self.busAnnotationView = annotationView;
    return annotationView;
}

- (void)updateBusLocation {
    if (self.count > 11) {
        self.count = 0;
    }
    NSDictionary *diction = self.busLocationsArray[self.count];
    _busLatitude = [[diction valueForKey:@"latitude"] floatValue];
    _busLongitude = [[diction valueForKey:@"longitude"] floatValue];
    _angle = [[diction valueForKey:@"angle"] floatValue];

    if (![_mapView.annotations containsObject:_busAnnotation]) {
        CLLocationCoordinate2D coor;
        coor.latitude = _busLatitude;
        coor.longitude = _busLongitude;
        _busAnnotation.coordinate = coor;
        [_mapView  addAnnotation:_busAnnotation];
    }

    
    CLLocationCoordinate2D coor;
    coor.latitude = _busLatitude;
    coor.longitude = _busLongitude;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.busAnnotationView.busImageView.transform = CGAffineTransformMakeRotation(self.angle*M_PI/180);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.5 animations:^{
            self.busAnnotation.coordinate = coor;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    self.count++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
