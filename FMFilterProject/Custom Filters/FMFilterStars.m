//
//  FMFilterStars.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterStars.h"
#import "MCColorConversions.h"

@interface FMFilterStars ()

@property (nonatomic, strong)GPUImagePicture *overlayImage;
@property (nonatomic, strong)GPUImageMonochromeFilter *monochromeFilter;
@property (nonatomic, strong) GPUImageOpacityFilter *opacityFilter;

@end

@implementation FMFilterStars

- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"stars.png"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                               smoothlyScaleOutput: YES];
        
        GPUImageOverlayBlendFilter * overlay = [[GPUImageOverlayBlendFilter alloc] init];
        
        [self.overlayImage addTarget: overlay
                   atTextureLocation: 1];
        [self.overlayImage processImage];

        self.monochromeFilter           = [[GPUImageMonochromeFilter alloc] init];
        self.monochromeFilter.intensity = 0.8;
        [self.monochromeFilter addTarget: overlay];
        
        self.opacityFilter         = [[GPUImageOpacityFilter alloc] init];
        self.opacityFilter.opacity = 0.5;
        
        [self.overlayImage addTarget: self.opacityFilter];
        [self.overlayImage processImage];
        
        [overlay addTarget: self.opacityFilter];
        
        [self setInitialFilters: @[self.monochromeFilter]];
        [self setTerminalFilter: self.opacityFilter];
    }

    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.opacityFilter.opacity = updateValue;
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    NSArray *hsbArray = @[@(updateValue),@(100),@(82)];
    NSArray *rgbArray = [MCColorConversions hsv2rgb:hsbArray];
    self.monochromeFilter.color = (GPUVector4){
                                                [rgbArray[0] floatValue],
                                                [rgbArray[1] floatValue],
                                                [rgbArray[2] floatValue],
                                                1.0f};
    [self.monochromeFilter setIntensity: 0.8];
    [self.overlayImage processImage];
}

@end
