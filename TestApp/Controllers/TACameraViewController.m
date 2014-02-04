//
//  TACameraViewController.m
//  TestApp
//
//  Created by Владимир on 04.02.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TACameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TACameraOverlayView.h"

@interface TACameraViewController () <UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation TACameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Camera unavailable"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if (!_picker)
        {
            _picker = [[UIImagePickerController alloc] init];
            _picker.delegate = self;
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            _picker.showsCameraControls = NO;
            _picker.cameraOverlayView = [self customViewForImagePicker:_picker];
        }
        [self presentViewController:_picker animated:YES completion:nil];
    }       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if(CFStringCompare((__bridge CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *pathToVideo = [(NSURL *)[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToVideo))
        {
            UISaveVideoAtPathToSavedPhotosAlbum(pathToVideo, nil, nil, nil);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _imageView.image = image;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIView *) customViewForImagePicker: (UIImagePickerController *) imagePicker
{
    TACameraOverlayView *view = [[TACameraOverlayView alloc] initWithFrame:imagePicker.view.frame];
    view.backgroundColor = [UIColor clearColor];
    
    [view.flashButton addTarget:self action:@selector(toggleFlash:) forControlEvents:UIControlEventTouchUpInside];
    [view.changeCameraButton addTarget:self action:@selector(toggleCamera:) forControlEvents:UIControlEventTouchUpInside];
    [view.changeCameraModeButton addTarget:self action:@selector(toggleCameraMode:) forControlEvents:UIControlEventTouchUpInside];
    [view.takePictureButton addTarget:imagePicker action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Actions

- (void) toggleFlash: (UIButton *) sender
{
    if (_picker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff)
    {
        _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [sender setTitle:@"Flash on" forState:UIControlStateNormal];
    }
    else
    {
        _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [sender setTitle:@"Flash off" forState:UIControlStateNormal];
    }
}

- (void) toggleCamera: (UIButton *) sender
{
    if (_picker.cameraDevice == UIImagePickerControllerCameraDeviceRear)
    {
        _picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [sender setTitle:@"Front Camera" forState:UIControlStateNormal];
    }
    else
    {
        _picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [sender setTitle:@"Rear Camera" forState:UIControlStateNormal];
    }
}

- (void) toggleCameraMode: (UIButton *) sender
{
    if (_picker.cameraCaptureMode == UIImagePickerControllerCameraCaptureModePhoto)
    {
        _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        [sender setTitle:@"Video" forState:UIControlStateNormal];
    }
    else
    {
        _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [sender setTitle:@"Photo" forState:UIControlStateNormal];
    }
}

@end
