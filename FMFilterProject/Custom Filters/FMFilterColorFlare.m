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
@property (nonatomic, strong) GPUImagePicture *overlayImage;


@end

@implementation FMFilterColorFlare

- (id)init
{
    if (self = [super init])
    {
        UIImage *image          = [UIImage imageNamed:@"colorflare"];
        self.overlayImage       = [[GPUImagePicture alloc] initWithImage: image
                                                     smoothlyScaleOutput: YES];
        
        GPUImageOverlayBlendFilter * overlay = [[GPUImageOverlayBlendFilter alloc] init];
        [self.overlayImage addTarget: overlay
                   atTextureLocation: 1];
        [self.overlayImage processImage];

        self.vignetteFilter = [[GPUImageVignetteFilter alloc] init];
        
        [self.vignetteFilter addTarget: overlay];
        
        [self setInitialFilters: @[self.vignetteFilter]];
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
    [self.overlayImage processImage];
}

@end
