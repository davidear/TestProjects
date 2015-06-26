//
//  JSGSettingHeaderVC.m
//  BeaconMall
//
//  Created by dai.fengyi on 15/5/4.
//  Copyright (c) 2015年 zkjinshi. All rights reserved.
//

#import "JSGSettingHeaderVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kItemCount                  15
#define kItemCountForRow            3
#define kCollectionViewIdentity     @"CollectionViewIdentity"
#pragma mark - JSGAssetsCollectionViewCell
@interface JSGAssetsCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation JSGAssetsCollectionViewCell

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

#pragma mark - JSGSettingHeaderVC
@interface JSGSettingHeaderVC () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    __weak IBOutlet UIImageView *headerImageView;
    __weak IBOutlet UICollectionView *assetsCollectionView;
}
@end

@implementation JSGSettingHeaderVC
{
    NSArray *_phoneAssetsArray;
    ALAssetsLibrary *_lib;       //必须用内部变量保存该lib
    
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
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.cornerRadius = headerImageView.bounds.size.height / 2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10.0f;
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20) / kItemCountForRow, ([UIScreen mainScreen].bounds.size.width - 20) / kItemCountForRow);
    assetsCollectionView.collectionViewLayout = layout;
    assetsCollectionView.delegate = self;
    assetsCollectionView.dataSource = self;
    [assetsCollectionView registerClass:[JSGAssetsCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewIdentity];
}
- (IBAction)cancelBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)okBtnClicked:(id)sender {
// do something
    
//
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CollectionView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_phoneAssetsArray != nil) {
        return _phoneAssetsArray.count + 1;
    } else return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    JSGAssetsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewIdentity forIndexPath:indexPath];
    if (indexPath.row != _phoneAssetsArray.count) {
        cell.imageView.image = [UIImage imageWithCGImage:[_phoneAssetsArray[indexPath.row] thumbnail]];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"图片占位"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _phoneAssetsArray.count) {
        headerImageView.image = [UIImage imageWithCGImage:[_phoneAssetsArray[indexPath.row] thumbnail]];
    } else {
        //跳转到imagepicker
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
    }
}
#pragma mark - 获取照片
- (void)getAllPictures
{
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:kItemCount];
    _lib = [[ALAssetsLibrary alloc] init];
    [_lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"All Photos"] | [[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"Camera Roll"]) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil & mutArr.count < kItemCount) {
                    [mutArr addObject:result];
                }
            }];
            _phoneAssetsArray = [NSArray arrayWithArray:mutArr];
            dispatch_async(dispatch_get_main_queue(), ^{
                [assetsCollectionView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        
//        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    headerImageView.image = info[@"UIImagePickerControllerEditedImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
