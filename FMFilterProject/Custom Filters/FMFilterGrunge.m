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
        
        [self addFilter: self.overlay];
        [self setInitialFilters: @[self.overlay]];
        [self setTerminalFilter: self.overlay];
        
        [self.overlayImage processImage];
    }
    
    return self;
}

#pragma mark - adjust -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    // no adjusting for this parameter
}

@end
