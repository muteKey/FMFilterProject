//
//  FMFilterStretch.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterStretch.h"

@interface FMFilterStretch ()
@property (nonatomic, strong) GPUImageStretchDistortionFilter *stretchFilter;
@end

@implementation FMFilterStretch

- (id)init
{
    if (self = [super init])
    {
        self.stretchFilter = [[GPUImageStretchDistortionFilter alloc] init];
        
        [self addFilter: self.stretchFilter];
        
        [self setInitialFilters: @[self.stretchFilter]];
        [self setTerminalFilter: self.stretchFilter];
    }
    
    return self;
}

#pragma mark - adjusting -
- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    // no adjusting for this filter
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    // no adjusting for this filter
}

@end
