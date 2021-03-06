//
//  FMFilterDazedAndConfused.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterDazedAndConfused.h"

@interface FMFilterDazedAndConfused ()

@property (nonatomic, strong) GPUImageLowPassFilter *lowPassFilter;

@property (nonatomic, strong) GPUImageGaussianSelectiveBlurFilter *selectiveBlurFilter;

@end

@implementation FMFilterDazedAndConfused

- (id)init
{
    if (self = [super init])
    {
//            commened due to https://github.com/BradLarson/GPUImage/issues/793
        
//        self.lowPassFilter = [[GPUImageLowPassFilter alloc] init];
//        [self.lowPassFilter setFilterStrength: 0.4];
        
        self.selectiveBlurFilter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
        [self.selectiveBlurFilter setExcludeCircleRadius: 0.3];
        
        [self setInitialFilters: @[self.selectiveBlurFilter]];
        [self setTerminalFilter: self.selectiveBlurFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
//    self.lowPassFilter.filterStrength = updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    self.selectiveBlurFilter.excludeCircleRadius = updateValue;
}

@end
