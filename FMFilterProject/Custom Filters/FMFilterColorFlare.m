//
//  FMFilterColorFlare.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterColorFlare.h"

@interface FMFilterColorFlare ()

@property (nonatomic, strong) GPUImageVignetteFilter *vignetteFilter;

@end

@implementation FMFilterColorFlare

- (id)init
{
    if (self = [super init])
    {
        UIImage *image                       = [UIImage imageNamed:@"colorflare"];
        GPUImagePicture * overlayImage       = [[GPUImagePicture alloc] initWithImage: image
                                                                  smoothlyScaleOutput: YES];
        
        GPUImageOverlayBlendFilter * overlay = [[GPUImageOverlayBlendFilter alloc] init];
        [overlayImage addTarget: overlay
              atTextureLocation: 1];
        [overlayImage processImage];
        
        self.vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        
        [self addFilter: overlay];
        [self addFilter: self.vignetteFilter];

        [self setInitialFilters: @[overlay, self.vignetteFilter]];
        [self setTerminalFilter: overlay];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    // opacity
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    self.vignetteFilter.vignetteEnd = updateValue;
}

@end
