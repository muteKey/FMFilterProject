//
//  FMFilterGaussianBlur.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterGaussianBlur.h"

@interface FMFilterGaussianBlur ()

@property (nonatomic, strong) GPUImageGaussianBlurFilter *blurFilter;

@end

@implementation FMFilterGaussianBlur

- (id)init
{
    if (self = [super init])
    {
        self.blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        
        [self addFilter: self.blurFilter];
        
        [self setInitialFilters: @[self.blurFilter]];
        [self setTerminalFilter: self.blurFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.blurFilter.blurRadiusInPixels = updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    // no second parameter
}


@end
