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
                                  kSecondValue          : @(-1)
                                  },
                                
                                @{kFilterName           : @"FMFilterStripes",
                                  kDisplayName          : @"Stripes",
                                  kFirstAttributeName   : @"Opacity",
                                  kSecondAttributeName  : @"Intensity",
                                  kFirstValue           : @(0.5),
                                  kSecondValue          : @(0.8)
                                  },
                                
                                @{kFilterName           : @"FMFilterPolkaDot",
                                  kDisplayName          : @"Polka Dot",
                                  kFirstAttributeName   : @"Pixel Size",
                                  kFirstValue           : @(0.2),
                                  kSecondValue          : @(-1)
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier
                                                                           forIndexPath: indexPath];
    
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    FMFilterModel* model = self.data[indexPath.row];
    CGSize size;
    if ([UIDevice currentDevice].systemVersion.floatValue <= 7.0)
    {
        size = [model.displayName sizeWithFont: [UIFont fontWithName: @"HelveticaNeue"
                                                                size: 16]];
    }
    else
    {
        size = [model.displayName sizeWithAttributes: @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue"
                                                                                             size: 16]
                                                        }];
    }
    
    UILabel *text = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, size.width, size.height)];
    text.text = model.displayName;
    
    [cell.contentView addSubview: text];
    
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
        
        self.firstSliderTitle.text  = model.attribute1Name;
        
        if (!model.attribute2Name)
        {
            self.slider2.enabled = NO;
        }
        else
        {
            self.slider2.enabled = YES;
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
