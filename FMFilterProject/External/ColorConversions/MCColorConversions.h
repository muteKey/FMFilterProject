//
//  MCColorConversions.h
//  Diddeo
//
//  Created by Ruslan on 1/31/14.
//  Copyright (c) 2014 Nu Systems Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCColorConversions : NSObject

+ (NSArray *)rgb2hsv:(NSArray *)rgbArray;
+ (NSArray *)hsv2rgb:(NSArray *)hsvArray;

@end
