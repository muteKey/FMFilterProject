//
//  FMFilterModel.h
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMFilterModel : NSObject
@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *attribute1Name;
@property (nonatomic, strong) NSString *attribute2Name;

@property (nonatomic) float attribute1DefaultValue;
@property (nonatomic) float attribute2DefaultValue;
@end
