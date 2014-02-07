//
//  FMFilterHalfTone.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterHalfTone.h"

@interface FMFilterHalfTone ()

@property (nonatomic, strong) GPUImageHalftoneFilter *halfToneFilter;

@end

@implementation FMFilterHalfTone

- (id)init
{
    if (self = [super init])
    {
        self.halfToneFilter = [[GPUImageHalftoneFilter alloc] init];
        
        [self addFilter: self.halfToneFilter];
        
        [self setInitialFilters: @[self.halfToneFilter]];
        [self setTerminalFilter: self.halfToneFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.halfToneFilter.fractionalWidthOfAPixel = updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
}

@end
