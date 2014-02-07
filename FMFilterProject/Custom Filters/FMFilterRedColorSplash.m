//
//  FMFilterRedColorSplash.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterRedColorSplash.h"

@implementation FMFilterRedColorSplash
- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"lookup_red"];
        GPUImagePicture * overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                                            smoothlyScaleOutput: YES];
        
        GPUImageLookupFilter *lookUpFilter = [[GPUImageLookupFilter alloc] init];
        [overlayImage addTarget: lookUpFilter
              atTextureLocation: 1];
        [overlayImage processImage];
        
        [self setInitialFilters: @[lookUpFilter]];
        [self setTerminalFilter: lookUpFilter];
    }
    
    return self;
}
@end
