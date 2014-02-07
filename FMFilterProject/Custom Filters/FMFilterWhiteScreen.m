//
//  FMFilterWhiteScreen.m
//  FMFilterProject
//
//  Created by Kirill on 2/7/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterWhiteScreen.h"

@interface FMFilterWhiteScreen ()

@property (nonatomic, strong) GPUImageChromaKeyBlendFilter *blendFilter;
@property (nonatomic, strong) GPUImagePicture *overlayImage;


@end

@implementation FMFilterWhiteScreen

- (id)init
{
    if (self = [super init])
    {
        UIImage *image = [UIImage imageNamed:@"chroma"];
        self.overlayImage = [[GPUImagePicture alloc] initWithImage: image
                                               smoothlyScaleOutput: YES];
        
        self.blendFilter = [[GPUImageChromaKeyBlendFilter alloc] init];
        [self.blendFilter setColorToReplaceRed: 1.0
                                         green: 1.0
                                          blue: 1.0];
        [self.blendFilter setThresholdSensitivity: 0.0];
        [self.blendFilter setSmoothing:0.2];
        
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
    [self.blendFilter setSmoothing: updateValue];
    [self.overlayImage processImage];
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    // nothing
}
@end
