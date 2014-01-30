//
//  TAImageLoader.m
//  TestApp
//
//  Created by Владимир on 30.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "TAImageLoader.h"

@interface TAImageLoader ()
@property (nonatomic, strong) NSMutableArray *cachedImages;
@end

@implementation TAImageLoader

+ (TAImageLoader *)sharedInstance
{
    static TAImageLoader *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TAImageLoader alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _cachedImages = [NSMutableArray array];
    }
    return self;
}

- (void)showImageWithUrl:(NSString *)url inView:(UIImageView *)imageView
{
    imageView.image = [self getImage:[url lastPathComponent]];
    if (imageView.image == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [self saveImage:image filename:[url lastPathComponent]];
            });
        });
    }
}

- (void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    if(![_cachedImages containsObject:filename])
        [_cachedImages addObject:filename];
    filename = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    NSData * data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage *)getImage:(NSString *)filename
{
    filename = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
    NSData * data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

- (void)clearCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (int i = 0; i < _cachedImages.count; i++)
    {
        NSError *error;
        [fileManager removeItemAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:_cachedImages[i]] error:&error];
        if(error)
        {
            NSLog(@"Error when deleting cache for %@: %@", _cachedImages[i], [error localizedDescription]);
        }
        
    }
    
}

@end
