//
//  FMFilterGrayscale.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterGrayscale.h"

@interface FMFilterGrayscale ()

@property (nonatomic, strong) GPUImageSaturationFilter* saturationFilter;

@end

@implementation FMFilterGrayscale
- (id)init
{
    if (self = [super init])
    {
        self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
        
        [self addFilter: self.saturationFilter];
        
        [self setInitialFilters: @[self.saturationFilter]];
        [self setTerminalFilter: self.saturationFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.saturationFilter.saturation = 1.0 - updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    
}

@end
