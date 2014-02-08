//
//  FMFilterBlueScreenSplash.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterBlueScreenSplash.h"

@interface FMFilterBlueScreenSplash ()

@property (nonatomic, strong) GPUImagePicture *overlayImage;


@end

@implementation FMFilterBlueScreenSplash
- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"lookup_blue"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                                            smoothlyScaleOutput: YES];
        
        GPUImageLookupFilter *lookUpFilter = [[GPUImageLookupFilter alloc] init];
        [self.overlayImage addTarget: lookUpFilter
              atTextureLocation: 1];
        [self.overlayImage processImage];

        [self setInitialFilters: @[lookUpFilter]];
        [self setTerminalFilter: lookUpFilter];
    }
    
    return self;
}

@end
