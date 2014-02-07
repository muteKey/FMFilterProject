//
//  FMFilterAdjustingProtocol.h
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMFilterAdjustingProtocol <NSObject>

@required
- (void)updateFirstFilterWithValue: (CGFloat)updateValue;
- (void)updateSecondFilterWithValues: (CGFloat)updateValue;
@end
