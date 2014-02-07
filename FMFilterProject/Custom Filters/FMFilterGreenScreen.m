//
//  FMFilterGreenScreen.m
//  FMFilterProject
//
//  Created by Kirill on 2/7/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterGreenScreen.h"
#import "MCColorConversions.h"

@interface FMFilterGreenScreen ()
@property (nonatomic, strong) GPUImageChromaKeyBlendFilter *blendFilter;
@property (nonatomic, strong) GPUImagePicture *overlayImage;

@end

@implementation FMFilterGreenScreen
- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"chroma"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                               smoothlyScaleOutput: YES];
        
        self.blendFilter = [[GPUImageChromaKeyBlendFilter alloc] init];
        NSArray *hsbArray = @[@(0.2),@(100), @(100)];
        NSArray *rgbArray = [MCColorConversions hsv2rgb:hsbArray];
        
        [self.blendFilter setColorToReplaceRed: [rgbArray[0] floatValue]
                                         green: [rgbArray[1] floatValue]
                                          blue: [rgbArray[2] floatValue] ];
        
        self.blendFilter.thresholdSensitivity = 0.4;
        [self.overlayImage addTarget: self.blendFilter
                   atTextureLocation: 1];
        [self.overlayImage processImage];
        
        [self setInitialFilters: @[self.blendFilter]];
        [self setTerminalFilter: self.blendFilter];
        

    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.blendFilter.thresholdSensitivity = updateValue;
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    NSArray *hsbArray = @[@(updateValue),@(100), @(100)];
    NSArray *rgbArray = [MCColorConversions hsv2rgb:hsbArray];

    [self.blendFilter setColorToReplaceRed: [rgbArray[0] floatValue]
                                     green: [rgbArray[1] floatValue]
                                      blue: [rgbArray[2] floatValue] ];
    [self.overlayImage processImage];
}

@end
