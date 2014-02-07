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
@property (nonatomic, strong) GPUImageOpacityFilter *opacityFilter;
@property (nonatomic, strong) GPUImagePicture * overlayImage;
@end

@implementation FMFilterCracks

- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"cracks"];
        
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                                            smoothlyScaleOutput: YES];
        
        self.opacityFilter  = [[GPUImageOpacityFilter alloc] init];
        self.vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        self.overlay        = [[GPUImageOverlayBlendFilter alloc] init];
        
        self.opacityFilter.opacity = 1.0;

        [self.overlayImage addTarget: self.overlay
                   atTextureLocation: 1];
        
        [self.overlayImage addTarget: self.opacityFilter];
        
        
        [self addFilter: self.overlay];
        [self addFilter: self.vignetteFilter];
        [self addFilter: self.opacityFilter];
        
        [self setInitialFilters: @[self.overlay, self.vignetteFilter,self.opacityFilter]];
        [self setTerminalFilter: self.vignetteFilter];
        
        [self.overlayImage processImage];
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
