//
//  TAImageLoader.h
//  TestApp
//
//  Created by Владимир on 30.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAImageLoader : NSObject
+ (TAImageLoader *) sharedInstance;

- (void) clearCache;
- (void) showImageWithUrl: (NSString *) fileName inView: (UIImageView *) imageView;
@end
