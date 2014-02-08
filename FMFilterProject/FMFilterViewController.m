//
//  FMFilterViewController.m
//  FMFilterProject
//
//  Created by Kirill on 2/6/14.
//  Copyright (c) 2014 Kirill. All rights reserved.
//

#import "FMFilterViewController.h"
#import "FMFilterAdjustingProtocol.h"
#import "FMFilterModel.h"
#import "FMFilterCollectionCell.h"

@interface FMFilterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *filters;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@property (nonatomic) NSInteger currentSelectedIndex;
@property (weak, nonatomic) IBOutlet UILabel *firstSliderTitle;
@property (weak, nonatomic) IBOutlet UILabel *secondSliderTilte;

@property (strong, nonatomic) GPUImageFilterGroup<FMFilterAdjustingProtocol> *currentFilter;

@property (strong, nonatomic) UIImage *originalImage;

@end

static const NSString *kFilterName              = @"kFilterName";
static const NSString *kDisplayName             = @"kDisplayName";

static const NSString *kFirstValue              = @"kFirstValue";
static const NSString *kSecondValue             = @"kSecondValue";

static const NSString *kFirstAttributeName      = @"kFirstAttributeName";
static const NSString *kSecondAttributeName     = @"kSecondAttributeName";

@implementation FMFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *filtersInfo    = @[@{kFilterName           : @"FMFilterCracks",
                                  kDisplayName          : @"Cracks",
                                  kFirstAttributeName   : @"Opacity",
                                  kSecondAttributeName  : @"Vignette Radius",
                                  kFirstValue           : @(0.5),
                                  kSecondValue          : @(0.2)
                                  },
                                
                                @{kFilterName           : @"FMFilterGrayscale",
                                  kDisplayName          : @"Grayscale",
                                  kFirstAttributeName   : @"Intensity",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },
                                
                                @{kFilterName           : @"FMFilterGrunge",
                                  kDisplayName          : @"Grunge",
                                  kFirstAttributeName   : @"Opacity",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },
                                
                                @{kFilterName           : @"FMFilterStars",
                                  kDisplayName          : @"Stars",
                                  kFirstAttributeName   : @"Opacity",
                                  kSecondAttributeName  : @"Hue",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0.4)
                                  },
                                
                                @{kFilterName           : @"FMFilterColorFlare",
                                  kDisplayName          : @"Color Flare",
                                  kFirstAttributeName   : @"Opacity",
                                  kSecondAttributeName  : @"Vignette Radius",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },
                                
                                @{kFilterName           : @"FMFilterRedColorSplash",
                                  kDisplayName          : @"Red Color Splash",
                                  },

                                @{kFilterName           : @"FMFilterGreenColorSplash",
                                  kDisplayName          : @"Green Color Splash",
                                  },
                                
                                @{kFilterName           : @"FMFilterBlueScreenSplash",
                                  kDisplayName          : @"Blue Color Splash",
                                  },
                                
                                @{kFilterName           : @"FMFilterSuperExposed",
                                  kDisplayName          : @"Super Exposed",
                                  kFirstAttributeName   : @"SMTH",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
                                  },

                                @{kFilterName           : @"FMFilterDazedAndConfused",
                                  kDisplayName          : @"Dazed and Confused",
                                  kFirstAttributeName   : @"Threshold",
                                  kSecondAttributeName  : @"Blur Radius",
                                  kFirstValue           : @(0.4),
                                  kSecondValue          : @(0.3)
                                  },
                                
                                @{kFilterName           : @"FMFilterPolkaDot",
                                  kDisplayName          : @"Polka Dot",
                                  kFirstAttributeName   : @"Pixel Size",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },
                                
                                @{kFilterName           : @"FMFilterHalfTone",
                                  kDisplayName          : @"Half Tone",
                                  kFirstAttributeName   : @"Pixel Size",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },

                                @{kFilterName           : @"FMFilterSobelEdge",
                                  kDisplayName          : @"Sobel Edge",
                                  },
                                
                                @{kFilterName           : @"FMFilterCartoon",
                                  kDisplayName          : @"Cartoon",
                                  kFirstAttributeName   : @"Blur Raduis",
                                  kSecondAttributeName  : @"Quantization",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
                                  },

                                @{kFilterName           : @"FMFilterEmboss",
                                  kDisplayName          : @"Emboss",
                                  kFirstAttributeName   : @"Depth",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
                                  },
                                
                                @{kFilterName           : @"FMFilterGaussianBlur",
                                  kDisplayName          : @"Gaussian Blur",
                                  kFirstAttributeName   : @"Radius",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
                                  },
                                
                                @{kFilterName           : @"FMFilterFishEye",
                                  kDisplayName          : @"Fish Eye",
                                  kFirstAttributeName   : @"Radius",
                                  kSecondAttributeName  : @"Scale",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
                                  },
                                
                                @{kFilterName           : @"FMFilterStretch",
                                  kDisplayName          : @"Stretch",
                                  },
                                
                                @{kFilterName           : @"FMFilterWhiteScreen",
                                  kDisplayName          : @"White Screen",
                                  kFirstAttributeName   : @"Smoothing",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(0)
                                  },
                                
                                @{kFilterName           : @"FMFilterGreenScreen",
                                  kDisplayName          : @"Green Screen",
                                  kFirstAttributeName   : @"Threshold",
                                  kSecondAttributeName  : @"Hue",
                                  kFirstValue           : @(0.4),
                                  kSecondValue          : @(0.2)
                                  }


                               ];
    self.currentSelectedIndex = -1;
    [self createFiltersWithArray: filtersInfo];
    
    self.originalImage = [UIImage imageNamed:@"home.jpg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createFiltersWithArray: (NSArray *)dataSource
{
    for (NSDictionary *filterInfo in dataSource)
    {
        FMFilterModel *model                = [FMFilterModel new];
        model.className                     = filterInfo[kFilterName];
        model.displayName                   = filterInfo[kDisplayName];
        model.attribute1DefaultValue        = [filterInfo[kFirstValue] floatValue];
        model.attribute2DefaultValue        = [filterInfo[kSecondValue] floatValue];
        model.attribute1Name                = filterInfo[kFirstAttributeName];
        model.attribute2Name                = filterInfo[kSecondAttributeName];
        
        GPUImageFilterGroup<FMFilterAdjustingProtocol> *filter = [[NSClassFromString(model.className) alloc] init];

        [self.data addObject: model];
        
        [self.filters addObject: filter];
    }
    
    [self.collectionVIew reloadData];
}

#pragma mark - UICollectionViewDataSource -

- (NSInteger)collectionView: (UICollectionView *)collectionView
     numberOfItemsInSection: (NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView
                  cellForItemAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"collectionCell";
    FMFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier
                                                                           forIndexPath: indexPath];
    
    FMFilterModel* model = self.data[indexPath.row];
    [cell setText: model.displayName];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate -

- (void)collectionView:       (UICollectionView *)collectionView
    didSelectItemAtIndexPath: (NSIndexPath *)indexPath
{
    if (self.currentSelectedIndex != indexPath.row)
    {
        FMFilterModel *model        = self.data[indexPath.row];
        GPUImageFilterGroup<FMFilterAdjustingProtocol> *filter = self.filters[indexPath.row];

        self.currentSelectedIndex = indexPath.row;
        
        self.imageView.image = [filter imageByFilteringImage: self.originalImage];
        
        if (!model.attribute1Name)
        {
            self.slider1.enabled = NO;
        }
        else
        {
            self.slider1.enabled = YES;
            self.slider1.value = model.attribute1DefaultValue;
        }
        
        self.firstSliderTitle.text  = model.attribute1Name;
        
        if (!model.attribute2Name)
        {
            self.slider2.enabled = NO;
        }
        else
        {
            self.slider2.enabled = YES;
            self.slider2.value = model.attribute2DefaultValue;
        }
        
        self.secondSliderTilte.text = model.attribute2Name;
    }
}

#pragma mark - Lazy getters -

- (NSMutableArray *)data
{
    if (!_data)
    {
        _data = [NSMutableArray new];
    }
    
    return _data;
}

- (NSMutableArray *)filters
{
    if (!_filters)
    {
        _filters = [NSMutableArray new];
    }
    
    return _filters;
}


#pragma mark - UI actions -

- (IBAction)slider1ValueChanged: (UISlider *)sender
{
    GPUImageFilterGroup<FMFilterAdjustingProtocol> *filter = self.filters[self.currentSelectedIndex];

    if ([filter respondsToSelector: @selector( updateFirstFilterWithValue: )])
    {
        [filter updateFirstFilterWithValue: sender.value];
        
        self.imageView.image = [filter imageByFilteringImage: self.originalImage];
    }
}

- (IBAction)slider2ValueChanged:(UISlider *)sender
{
    GPUImageFilterGroup<FMFilterAdjustingProtocol> *filter = self.filters[self.currentSelectedIndex];
    
    if ([filter respondsToSelector: @selector( updateSecondFilterWithValues: )])
    {
        [filter updateSecondFilterWithValues: sender.value];

        self.imageView.image = [filter imageByFilteringImage: self.originalImage];
    }
}

@end
