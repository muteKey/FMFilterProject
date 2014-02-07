//
//  FMFilterBlueScreenSplash.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterBlueScreenSplash.h"

@implementation FMFilterBlueScreenSplash
- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"lookup_blue"];
        GPUImagePicture * overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                                            smoothlyScaleOutput: YES];
        
        GPUImageLookupFilter *lookUpFilter = [[GPUImageLookupFilter alloc] init];
        [overlayImage addTarget: lookUpFilter
              atTextureLocation: 1];
        
        [self setInitialFilters: @[lookUpFilter]];
        [self setTerminalFilter: lookUpFilter];
        
        [overlayImage processImage];
    }
    
    return self;
}

@end
