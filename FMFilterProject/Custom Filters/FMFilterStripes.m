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
@property (nonatomic, strong) GPUImageOpacityFilter *opacityFilter;

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
        
        self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
        [self.saturationFilter setSaturation: 0.5];
        
        [self.saturationFilter addTarget: overlay];
        
        self.opacityFilter         = [[GPUImageOpacityFilter alloc] init];
        self.opacityFilter.opacity = 0.5;
        
        [self.overlayImage addTarget: self.opacityFilter];
        [self.overlayImage processImage];
        
        [overlay addTarget: self.opacityFilter];
        
        [self setInitialFilters: @[self.saturationFilter]];
        [self setTerminalFilter: self.opacityFilter];
    }
    
    return self;
}

#pragma mark - Filter adjusting -

- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    self.opacityFilter.opacity = updateValue;
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    self.saturationFilter.saturation = 1.0 - updateValue;
    [self.overlayImage processImage];
}

@end
