//
//  ViewController.m
//  collectionView
//
//  Created by dfy on 15/2/11.
//  Copyright (c) 2015年 childrenAreOurFuture. All rights reserved.
//

#import "ViewController.h"
#import "DFYCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    @property (nonatomic) CGFloat minimumLineSpacing;
//    @property (nonatomic) CGFloat minimumInteritemSpacing;
//    @property (nonatomic) CGSize itemSize;
//    @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -perferredLayoutAttributesFittingAttributes:
//    @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
//    @property (nonatomic) CGSize headerReferenceSize;
//    @property (nonatomic) CGSize footerReferenceSize;
//    @property (nonatomic) UIEdgeInsets sectionInset;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(200, 300);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blueColor];
//    [collectionView registerClass:[DFYCollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"DFYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    [self.view addSubview:collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[DFYCollectionViewCell alloc] init];
//    }
    cell.labelText = [NSString stringWithFormat:@"index is %ld",indexPath.row];
    return cell;
}
@end
