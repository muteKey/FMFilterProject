//
//  FMFilterCracks.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterCracks.h"

@interface FMFilterCracks ()

@property (nonatomic, strong) GPUImageVignetteFilter     *vignetteFilter;
@property (nonatomic, strong) GPUImageOverlayBlendFilter *overlay;
@property (nonatomic, strong) GPUImagePicture *overlayImage;
@property (nonatomic, strong) GPUImageOpacityFilter *opacityFilter;

@end

@implementation FMFilterCracks

- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"cracks"];
        
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                                            smoothlyScaleOutput: YES];
        
        self.overlay      = [[GPUImageOverlayBlendFilter alloc] init];

        [self.overlayImage addTarget: self.overlay
                   atTextureLocation: 1];

        self.vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        
        [self.vignetteFilter addTarget: self.overlay];
        
        self.opacityFilter         = [[GPUImageOpacityFilter alloc] init];
        self.opacityFilter.opacity = 0.5;
        
        [self.overlayImage addTarget: self.opacityFilter];
        [self.overlayImage processImage];
        
        [self.overlay addTarget: self.opacityFilter];

        [self setInitialFilters: @[self.vignetteFilter]];
        [self setTerminalFilter: self.opacityFilter];
        
    }
    
    return self;
}

#pragma mark - Adjusting protocol -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.opacityFilter.opacity = updateValue;
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    [self.vignetteFilter setVignetteEnd: updateValue];
    [self.overlayImage processImage];
}
@end
