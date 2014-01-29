//
//  TAMapViewController.m
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAMapViewController.h"
#import "TAAnnotation.h"

@interface TAMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *stopTime;
@property (nonatomic, assign) CLLocationDistance distance;
@property (nonatomic, assign) CLLocationSpeed speed;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation TAMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_mapView setShowsUserLocation:YES];
	_points = [NSMutableArray array];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleBordered target:self action:@selector(startButtonPressed:)]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLLocationDistance) calculateDistance
{
    CLLocationDistance distance = 0.0;
    for(int i = 0; i < _points.count - 1; i++)
    {
         distance += [_points[i] distanceFromLocation:_points[i+1]];
    }
    return distance;
}

#pragma mark - MapView delegate

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_locationManager.location.coordinate, 1000, 1000);
    [_mapView setRegion:region animated:YES];
    id<MKAnnotation> annotation = [views[0] annotation];
    if([annotation isKindOfClass:[TAAnnotation class]])
    {
        [_mapView selectAnnotation:annotation animated:YES];
    }
   
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:MKPolyline.class])
    {
        MKPolylineView *lineView = [[MKPolylineView alloc] initWithOverlay:overlay];
        lineView.strokeColor = [UIColor greenColor];
        
        return lineView;
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[TAAnnotation class]])
    {
        NSString *identifier = [annotation title];
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
        }
        else
        {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - CLLocation delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    _distance += [newLocation distanceFromLocation:oldLocation];
    NSTimeInterval timeInterval = [NSDate date].timeIntervalSinceReferenceDate - _startTime.timeIntervalSinceReferenceDate;
    _infoLabel.text = [NSString stringWithFormat:@"Time: %.0f s \nDistance: %.0f m \nSpeed: %.1f m/s", timeInterval, _distance, newLocation.speed];
    [_points addObject:newLocation];
    CLLocationCoordinate2D points[] = {oldLocation.coordinate, newLocation.coordinate};
    MKPolyline *trace = [MKPolyline polylineWithCoordinates:points count:2];
    [_mapView addOverlay:trace];
}

#pragma mark - Actions

- (void) startButtonPressed: (id) sender
{
    _distance = 0.0;
    _startTime = [NSDate date];
    [_mapView removeAnnotations:[_mapView annotations]];
    [_mapView removeOverlays:[_mapView overlays]];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStyleBordered target:self action:@selector(stopButtonPressed:)]];
    [_points addObject:_locationManager.location];
    TAAnnotation *annotation = [[TAAnnotation alloc] initWithTitle:@"Start" time:_startTime coordinate:_locationManager.location.coordinate];
    [_mapView addAnnotation:annotation];
    [_locationManager startUpdatingLocation];
}

- (void) stopButtonPressed: (id) sender
{
    _stopTime = [NSDate date];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleBordered target:self action:@selector(startButtonPressed:)]];
    TAAnnotation *annotation = [[TAAnnotation alloc] initWithTitle:@"Finish" time:_stopTime coordinate:_locationManager.location.coordinate];
    [_mapView addAnnotation:annotation];
    NSTimeInterval timeInterval = _stopTime.timeIntervalSinceReferenceDate - _startTime.timeIntervalSinceReferenceDate;
    _speed = _distance / timeInterval;
    [_locationManager stopUpdatingLocation];
    
    _infoLabel.text = [NSString stringWithFormat:@"Time: %.0f s \nDistance: %.0f m \nSpeed: %.1f m/s", timeInterval, _distance, _speed];
    
}

@end
