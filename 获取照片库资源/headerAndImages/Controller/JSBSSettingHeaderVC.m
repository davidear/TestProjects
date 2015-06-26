//
//  JSBSSettingHeaderVC.m
//  BeaconMall
//
//  Created by dai.fengyi on 15/5/4.
//  Copyright (c) 2015年 zkjinshi. All rights reserved.
//

#import "JSBSSettingHeaderVC.h"
//#import "JSBSTextField.h"
//#import "JSBSButton.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kItemCount                  15
#define kItemCountForRow            3
#define kCollectionViewIdentity     @"CollectionViewIdentity"
@interface JSBSAssetsCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation JSBSAssetsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    _imageView.frame = self.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}
@end

@interface JSBSSettingHeaderVC () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UIImageView *headerImageView;
    __weak IBOutlet UITextField *nicknameTextField;
    __weak IBOutlet UIButton *okButton;
    __weak IBOutlet UICollectionView *assetsCollectionView;
}
@end

@implementation JSBSSettingHeaderVC
{
    NSArray *_phoneAssetsArray;
    ALAssetsLibrary *lib;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self setupSubviews];
}

- (void)loadData
{
    [self getAllPictures];
}
- (void)setupSubviews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10.0f;
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20) / kItemCountForRow, ([UIScreen mainScreen].bounds.size.width - 20) / kItemCountForRow);
    assetsCollectionView.collectionViewLayout = layout;
    assetsCollectionView.delegate = self;
    assetsCollectionView.dataSource = self;
    [assetsCollectionView registerClass:[JSBSAssetsCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewIdentity];
}


#pragma mark - CollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_phoneAssetsArray != nil) {
        return _phoneAssetsArray.count;
    } else return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSBSAssetsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewIdentity forIndexPath:indexPath];
    ALAsset *asset = _phoneAssetsArray[indexPath.row];
    CGImageRef cg = [asset thumbnail];
    UIImage *image = [UIImage imageWithCGImage:cg];
    
    cell.imageView.image = image;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - 获取照片
- (void)getAllPictures
{
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:kItemCount];
    lib = [[ALAssetsLibrary alloc] init];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        NSString *str = [group valueForProperty:ALAssetsGroupPropertyName];
        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"Camera Roll"]) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil & mutArr.count < 15) {
                    [mutArr addObject:result];
                }
            }];
            _phoneAssetsArray = [NSArray arrayWithArray:mutArr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [assetsCollectionView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
