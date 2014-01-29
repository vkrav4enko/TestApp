//
//  TAAnnotationView.m
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAAnnotation.h"

@interface TAAnnotation ()
@property (nonatomic, copy) NSString *theTitle;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;

@end

@implementation TAAnnotation

- (id)initWithTitle:(NSString *)title time:(NSDate *)time coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self)
    {
        self.theTitle = title;
        self.theCoordinate = coordinate;
        self.time = time;
    }
    return self;
}

- (NSString *)title
{
    return _theTitle;
}

- (NSString *)subtitle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:_time];
}

- (CLLocationCoordinate2D)coordinate
{
    return _theCoordinate;
}

@end
