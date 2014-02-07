//
//  FMFilterPolkaDot.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterPolkaDot.h"

@interface FMFilterPolkaDot ()

@property (nonatomic, strong) GPUImagePolkaDotFilter *polkaDotFilter;

@end

@implementation FMFilterPolkaDot

- (id)init
{
    if (self = [super init])
    {
        self.polkaDotFilter = [[GPUImagePolkaDotFilter alloc] init];
        
        [self addFilter: self.polkaDotFilter];
        
        [self setInitialFilters: @[self.polkaDotFilter]];
        [self setTerminalFilter: self.polkaDotFilter];

    }
    
    return self;
}

#pragma mark - Adjusting -

- (void)updateFirstFilterWithValue: (CGFloat)updateValue
{
    self.polkaDotFilter.fractionalWidthOfAPixel = updateValue;
}

- (void)updateSecondFilterWithValues: (CGFloat)updateValue
{
    // does not have other parameter to adjust
}

@end
