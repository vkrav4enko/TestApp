//
//  TAImagesViewController.m
//  TestApp
//
//  Created by Владимир on 30.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAImagesViewController.h"
#import "TAImageCell.h"
#import "TAImageLoader.h"

@interface TAImagesViewController ()
@property (nonatomic, strong) NSArray *images;
@end

@implementation TAImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear Cache"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(clearCache)];
    
    _images = @[@"http://www.petitcolas.net/fabien/watermarking/image_database/wildflowers.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/waterfall.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/water.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/alu.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/bandon.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/terraux.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/brandyrose.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/fourviere.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/bear.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/kid.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/skyline_arch.jpg",
                @"http://www.petitcolas.net/fabien/watermarking/image_database/z1x25.jpg"];
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
    return _images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
    
    // Configure the cell...
    NSString *imageUrl = [_images objectAtIndex:indexPath.row];
    cell.nameLabel.text = [imageUrl lastPathComponent];
    [[TAImageLoader sharedInstance] showImageWithUrl:imageUrl inView:cell.preview];
    
    return cell;
}

- (void) clearCache
{
    [[TAImageLoader sharedInstance] clearCache];
    [self.tableView reloadData];
}


@end
