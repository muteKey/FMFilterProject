//
//  MCColorConversions.m
//  Diddeo
//
//  Created by Ruslan on 1/31/14.
//  Copyright (c) 2014 Nu Systems Productions. All rights reserved.
//

#import "MCColorConversions.h"

@implementation MCColorConversions

+ (NSArray *)rgb2hsv:(NSArray *)rgbArray {
    
    float colorArray[3];
    
    colorArray[0] = [[rgbArray objectAtIndex:0] doubleValue];
    colorArray[1] = [[rgbArray objectAtIndex:1] doubleValue];
    colorArray[2] = [[rgbArray objectAtIndex:2] doubleValue];
    
    float max = MAX(colorArray[0], colorArray[1]);
    float min = MIN(colorArray[0], colorArray[1]);
    
    max = MAX(max, colorArray[2]);
    min = MIN(min, colorArray[2]);
    
    float delta = max-min;
    
    int hue = 0;
    int saturation = 0;
    int brightness =  (int)(100.0*max + 0.5);
    
    if(max != min)
    {
        
        saturation = (int)((100.0*delta/max) + 0.5);
        
        if(max == colorArray[0]) // Red
            hue = (colorArray[1]-colorArray[2])/(delta)*60;
        else if(max == colorArray[1]) // Green
            hue = (2.0 + (colorArray[2]-colorArray[0])/(delta))*60;
        else // Blue
            hue = (4.0 + (colorArray[0]-colorArray[1])/(delta))*60;
        
        if (hue < 0) {
            hue = hue + 360;
        }
        
    }
    
    NSArray *hsbArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:hue],
                         [NSNumber numberWithInt:saturation],
                         [NSNumber numberWithInt:brightness], nil];
    
    return hsbArray;
    
}

+ (NSArray *)hsv2rgb:(NSArray *)hsvArray {
    
    double hsvHi = [[hsvArray objectAtIndex:0] doubleValue];
    double hsvSi = [[hsvArray objectAtIndex:1] doubleValue];
    double hsvBi = [[hsvArray objectAtIndex:2] doubleValue];
    
    double hsvH = (hsvHi/360.0);
    double hsvS = (hsvSi/100.0);
    double hsvB = (hsvBi/100.0);
    
    double red = 0.0;
    double green = 0.0;
    double blue = 0.0;
    
    if ( hsvS == 0.0 )
    {
        red = hsvB;
        green = hsvB;
        blue = hsvB;
    }
    else
    {
        double var_h = hsvH * 6.0;
        if ( var_h == 6.0 ) { var_h = 0; }
        double var_i = (int)var_h;
        double var_1 = hsvB * ( 1.0 - hsvS );
        double var_2 = hsvB * ( 1.0 - hsvS * ( var_h - var_i ) );
        double var_3 = hsvB * ( 1.0 - hsvS * ( 1.0 - ( var_h - var_i ) ) );
        
        if      ( var_i == 0 ) { red = hsvB  ; green = var_3 ; blue = var_1; }
        else if ( var_i == 1 ) { red = var_2 ; green = hsvB  ; blue = var_1; }
        else if ( var_i == 2 ) { red = var_1 ; green = hsvB  ; blue = var_3; }
        else if ( var_i == 3 ) { red = var_1 ; green = var_2 ; blue = hsvB;  }
        else if ( var_i == 4 ) { red = var_3 ; green = var_1 ; blue = hsvB;  }
        else                   { red = hsvB  ; green = var_1 ; blue = var_2; }
        
    }
    
    NSArray *rgbArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:red],
                         [NSNumber numberWithDouble:green],
                         [NSNumber numberWithDouble:blue], nil];
    
    return rgbArray;
    
}


@end
