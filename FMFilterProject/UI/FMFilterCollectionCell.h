//
//  FMFilterCollectionCell.h
//  FMFilterProject
//
//  Created by Kirill on 2/7/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMFilterCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)setText: (NSString *)text;
@end
