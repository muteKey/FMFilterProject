//
//  FMFilterGrunge.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterGrunge.h"

@interface FMFilterGrunge ()

@property (nonatomic, strong) GPUImagePicture *overlayImage;
@property (nonatomic, strong) GPUImageOverlayBlendFilter *overlay;
@property (nonatomic, strong) GPUImageOpacityFilter *opacityFilter;

@end

@implementation FMFilterGrunge

- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"grunge.png"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                               smoothlyScaleOutput: YES];
        
        self.overlay = [[GPUImageOverlayBlendFilter alloc] init];
        [self.overlayImage addTarget: self.overlay
                   atTextureLocation: 1];
        
        self.opacityFilter         = [[GPUImageOpacityFilter alloc] init];
        self.opacityFilter.opacity = 0.5;
        
        [self.overlayImage addTarget: self.opacityFilter];
        [self.overlayImage processImage];
        
        [self setInitialFilters: @[self.overlay]];
        [self setTerminalFilter: self.opacityFilter];

    }
    
    return self;
}

#pragma mark - adjust -

- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    self.opacityFilter.opacity = updateValue;
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    // no adjusting for this parameter
}

@end
