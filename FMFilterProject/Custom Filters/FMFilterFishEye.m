//
//  FMFilterFishEye.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterFishEye.h"

@interface FMFilterFishEye ()
@property (nonatomic, strong)GPUImageBulgeDistortionFilter *distortionFilter;
@end

@implementation FMFilterFishEye
- (id)init
{
    if (self = [super init])
    {
        self.distortionFilter = [[GPUImageBulgeDistortionFilter alloc] init];
        
        [self addFilter: self.distortionFilter];
        
        [self setInitialFilters: @[self.distortionFilter]];
        [self setTerminalFilter: self.distortionFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    self.distortionFilter.radius = updateValue;
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    self.distortionFilter.scale = updateValue;
}

@end
