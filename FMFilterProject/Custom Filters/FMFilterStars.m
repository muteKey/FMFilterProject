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
@property (nonatomic, strong) GPUImageMonochromeFilter *monochromeFilter;

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

        self.monochromeFilter = [[GPUImageMonochromeFilter alloc] init];
        [self.monochromeFilter setIntensity: 0.8];
        
        [self addFilter: overlay];
        [self addFilter: self.monochromeFilter];
        
        [self setInitialFilters: @[overlay, self.monochromeFilter]];
        [self setTerminalFilter: overlay];
        
        [self.overlayImage processImage];
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
    NSArray *hsbArray = @[@(updateValue),@(100),@(82)];
    NSArray *rgbArray = [MCColorConversions hsv2rgb:hsbArray];
    self.monochromeFilter.color = (GPUVector4){
                                                [rgbArray[0] floatValue],
                                                [rgbArray[1] floatValue],
                                                [rgbArray[2] floatValue],
                                                1.0f};
}

@end
