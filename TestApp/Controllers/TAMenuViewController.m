//
//  TAMenuViewController.m
//  TestApp
//
//  Created by Владимир on 04.02.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAMenuViewController.h"
#import "TACameraViewController.h"

@interface TAMenuViewController ()

@end

@implementation TAMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonPressed:(UIButton *)sender
{
    TACameraViewController *cameraController = [[TACameraViewController alloc] initWithNibName:@"TACameraViewController" bundle:nil];
    [self.navigationController pushViewController:cameraController animated:YES];
}

@end
