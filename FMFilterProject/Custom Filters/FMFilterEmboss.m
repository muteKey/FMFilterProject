//
//  FMFilterEmboss.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterEmboss.h"

@interface FMFilterEmboss ()

@property (nonatomic, strong)GPUImageEmbossFilter *embossFilter;

@end


@implementation FMFilterEmboss

- (id)init
{
    if (self = [super init])
    {
        self.embossFilter = [[GPUImageEmbossFilter alloc] init];
        
        [self addFilter: self.embossFilter];
        
        [self setInitialFilters: @[self.embossFilter]];
        [self setTerminalFilter: self.embossFilter];
    }
    
    return self;
}

#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    self.embossFilter.intensity = updateValue;
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    // no second parameter
}

@end
