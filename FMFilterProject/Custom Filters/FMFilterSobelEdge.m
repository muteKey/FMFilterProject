//
//  FMFilterSobelEdge.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterSobelEdge.h"

@interface FMFilterSobelEdge ()
@property (nonatomic, strong) GPUImageSobelEdgeDetectionFilter *sobelEdgeFilter;
@end

@implementation FMFilterSobelEdge

- (id)init
{
    if (self = [super init])
    {
        self.sobelEdgeFilter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        
        [self addFilter: self.sobelEdgeFilter];
        
        [self setInitialFilters: @[self.sobelEdgeFilter]];
        [self setTerminalFilter: self.sobelEdgeFilter];
    }
    
    return self;
}


#pragma mark - adjusting -

- (void)updateFirstFilterWithValue:(CGFloat)updateValue
{
    
}

- (void)updateSecondFilterWithValues:(CGFloat)updateValue
{
    
}
@end
