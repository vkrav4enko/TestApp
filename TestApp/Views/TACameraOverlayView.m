//
//  TACameraOverlayView.m
//  TestApp
//
//  Created by Владимир on 04.02.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TACameraOverlayView.h"

@implementation TACameraOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _flashButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 120, 44)];
        _flashButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [_flashButton setTitle:@"FlashAuto" forState:UIControlStateNormal];
        [_flashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _flashButton.layer.cornerRadius = 10.0;
        
        _changeCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 64, 120, 44)];
        _changeCameraButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [_changeCameraButton setTitle:@"Rear Camera" forState:UIControlStateNormal];
        [_changeCameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changeCameraButton.layer.cornerRadius = 10.0;
        
        _changeCameraModeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 118, 120, 44)];
        _changeCameraModeButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [_changeCameraModeButton setTitle:@"Photo" forState:UIControlStateNormal];
        [_changeCameraModeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changeCameraModeButton.layer.cornerRadius = 10.0;
        
        _takePictureButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.frame.size.height - 54, 120, 44)];
        _takePictureButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [_takePictureButton setTitle:@"Take picture" forState:UIControlStateNormal];
        [_takePictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _takePictureButton.layer.cornerRadius = 10.0;
        
        [self addSubview:_flashButton];
        [self addSubview:_changeCameraButton];
        [self addSubview:_changeCameraModeButton];
        [self addSubview:_takePictureButton];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if(CGRectContainsPoint(_flashButton.frame, point) || CGRectContainsPoint(_changeCameraButton.frame, point)|| CGRectContainsPoint(_changeCameraModeButton.frame, point)|| CGRectContainsPoint(_takePictureButton.frame, point)) {
        // touched button
        return YES;
    }
    
    return NO;
}

@end
