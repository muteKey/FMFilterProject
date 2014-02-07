//
//  FMFilterStripes.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterStripes.h"

@interface FMFilterStripes ()
@property (nonatomic, strong) GPUImagePicture *overlayImage;
@property (nonatomic, strong) GPUImageSaturationFilter *saturationFilter;
@end

@implementation FMFilterStripes
- (id)init
{
    if (self = [super init])
    {
        UIImage *image                 = [UIImage imageNamed:@"rasta"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                               smoothlyScaleOutput: YES];
        
        GPUImageOverlayBlendFilter *overlay = [[GPUImageOverlayBlendFilter alloc] init];
        [self.overlayImage addTarget: overlay
                   atTextureLocation: 1];
        
        [self.overlayImage processImage];
        
        self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
        [self.saturationFilter setSaturation: 0.5];
        
        [self addFilter: overlay];
        [self addFilter: self.saturationFilter];
        
        [self setInitialFilters:@[overlay, self.saturationFilter]];
        [self setTerminalFilter: overlay];
    }
    
    return self;
}

#pragma mark - Filter adjusting -

- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    self.saturationFilter.saturation = 1.0 - updateValue;
    [self.overlayImage processImage];
}

@end
