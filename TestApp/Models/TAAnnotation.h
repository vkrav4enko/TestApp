//
//  TAAnnotationView.h
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface TAAnnotation : NSObject <MKAnnotation>
@property (nonatomic, strong) NSDate *time;

- (id) initWithTitle: (NSString *) title time: (NSDate *) time coordinate: (CLLocationCoordinate2D)coordinate;

@end
