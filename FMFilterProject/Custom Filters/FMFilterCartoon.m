//
//  FMFilterCartoon.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterCartoon.h"

@interface FMFilterCartoon ()
@property (nonatomic, strong) GPUImageSmoothToonFilter *toonFilter;

@end

@implementation FMFilterCartoon

- (id)init
{
    if (self = [super init])
    {
        self.toonFilter = [[GPUImageSmoothToonFilter alloc] init];
        
        [self addFilter: self.toonFilter];
        
        [self setInitialFilters: @[self.toonFilter]];
        [self setTerminalFilter: self.toonFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.toonFilter.blurRadiusInPixels = updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    self.toonFilter.quantizationLevels = updateValue;
}

@end
