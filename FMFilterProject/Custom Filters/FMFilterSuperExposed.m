//
//  FMFilterSuperExposed.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterSuperExposed.h"

@interface FMFilterSuperExposed ()

@property (nonatomic, strong) GPUImageExposureFilter *exposureFilter;

@end

@implementation FMFilterSuperExposed
- (id)init
{
    if (self = [super init])
    {
        self.exposureFilter = [[GPUImageExposureFilter alloc] init];
        
        [self addFilter: self.exposureFilter];
        
        [self setInitialFilters: @[self.exposureFilter]];
        [self setTerminalFilter: self.exposureFilter];
        
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.exposureFilter.exposure = updateValue - 5.0;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    // no adjusting for 2 parameter
}
@end
