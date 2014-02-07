//
//  FMFilterCollectionCell.m
//  FMFilterProject
//
//  Created by Kirill on 2/7/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterCollectionCell.h"

@implementation FMFilterCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text
{
    self.title.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.title.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
