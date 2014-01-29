//
//  TAAudioViewController.m
//  TestApp
//
//  Created by Владимир on 29.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAAudioViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TAAudioFileCell.h"

@interface TAAudioViewController () <UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *files;
@end

@implementation TAAudioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _files = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    NSError *error = nil;
    NSArray *directory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:@"Music"] error:&error];
    if(error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[error localizedDescription]
                                   delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil]
         show];
    }
    else
    {
        for (NSString *file in directory)
        {
            CFStringRef fileExtension = (__bridge CFStringRef) [file pathExtension];
            CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
            if (UTTypeConformsTo(fileUTI, kUTTypeAudio))
            {
                NSString *filePath = [[documentsDirectory stringByAppendingPathComponent:@"Music"] stringByAppendingPathComponent:file];
                [_files addObject:filePath];
            }
            CFRelease(fileUTI);
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TAAudioFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AudioCell"];
    
    // Configure the cell...
    NSString *file = [_files objectAtIndex:indexPath.row];
    cell.nameLabel.text = [file lastPathComponent];
    [cell.playButton setTitle:@"Start" forState:UIControlStateNormal];
    [cell.playButton setTag:indexPath.row];
    [cell.playButton addTarget:self action:@selector(playFile:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) playFile: (UIButton *) sender
{
    if([[TAAudioPlayer sharedPlayer] isPlaying])
    {
        [[TAAudioPlayer sharedPlayer] stopPlaing];
        [self.tableView reloadData];
    }
    else
    {
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [[TAAudioPlayer sharedPlayer] playFile:_files[sender.tag]];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
