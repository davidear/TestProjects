//
//  ViewController.m
//  headerAndImages
//
//  Created by dai.fy on 15/4/30.
//  Copyright (c) 2015年 dai.fy. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JSBSSettingHeaderVC.h"
@interface GoodColletionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GoodColletionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageView];
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    _imageView.frame = self.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}
@end

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static int count=0;
@implementation ViewController
{
    ALAssetsLibrary *library;
    
    NSArray *imageArray;
    
    NSMutableArray *mutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    imageArray = [NSMutableArray array];
//    for (int i = 0; i<10; i++) {
//        [imageArray addObject:[UIImage imageNamed:@"38mm-Walkway.png"]];
//    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    @property (nonatomic) CGFloat minimumLineSpacing;
    //    @property (nonatomic) CGFloat minimumInteritemSpacing;
    //    @property (nonatomic) CGSize itemSize;
    //    @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -perferredLayoutAttributesFittingAttributes:
    //    @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
    //    @property (nonatomic) CGSize headerReferenceSize;
    //    @property (nonatomic) CGSize footerReferenceSize;
    //    @property (nonatomic) UIEdgeInsets sectionInset;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((self.collectionView.bounds.size.width-20) /3, (self.collectionView.bounds.size.width-20) /3);
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300) collectionViewLayout:layout];
    self.collectionView.collectionViewLayout = layout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor blueColor];
    [self.collectionView registerClass:[GoodColletionViewCell class] forCellWithReuseIdentifier:@"goodone"];
//    [self.view addSubview:_collectionView];
}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"will appear");
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"did appear");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imageArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodone" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageWithCGImage:[imageArray[indexPath.row] thumbnail]];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - 获取图片
//获取所有图片
-(void)getAllPictures
{
    dispatch_queue_t queue = dispatch_queue_create("childrenOurFuture", NULL);
    imageArray = [[NSArray alloc] init];
    mutableArray = [NSMutableArray array];
    NSMutableArray *assetURLDictionaryes = [NSMutableArray array];
    NSMutableArray *assetGroups = [NSMutableArray array];
    library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSLog(@"enumerateGroupsWithTypes，thread is %@",[NSThread currentThread]);
        NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
            if ([groupName isEqualToString:@"Camera Roll"]) {
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    NSLog(@"enumerateAssetsUsingBlock，thread is %@",[NSThread currentThread]);
                    if (result != nil) {
//                        if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
//                            NSURL *url = (NSURL *)[[result defaultRepresentation] url];
//                            [mutableArray addObject:url];
                        [mutableArray addObject:result];
                            if (mutableArray.count == 10) {
                                imageArray = [NSArray arrayWithArray:mutableArray];
                                [self allPhotosCollected:imageArray];
                            }
                    }
                }];
                *stop = NO;
            }
    } failureBlock:^(NSError *error) {
        NSLog(@"enumerateGroupsWithTypes failed, %@", [error localizedDescription]);
    }];
    
//    imageArray=[[NSArray alloc] init];
//    mutableArray =[[NSMutableArray alloc]init];
//    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
//    library = [[ALAssetsLibrary alloc] init];
//    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
//        if(result != nil) {
//            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
//                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
//                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
//                
//                [library assetForURL:url
//                 
//                         resultBlock:^(ALAsset *asset) {
//                             
//                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
//                             
//                             if ([mutableArray count]==10)
//                                 
//                             {
//                                 
//                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
//                                 
//                                 [self allPhotosCollected:imageArray];
//                                 
//                                 *stop = NO;
//                             }
//                             
//                         }
//                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
//            }
//            
//        }
//        
//    };
//    
//    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
//    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
//        
//        if(group != nil) {
//            
//            [group enumerateAssetsUsingBlock:assetEnumerator];
//            
//            [assetGroups addObject:group];
//            
//            count = (int)[group numberOfAssets];
//            
//            *stop = NO;
//            
//        }
//    };
//    assetGroups = [[NSMutableArray alloc] init];
//    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
//     
//                           usingBlock:assetGroupEnumerator
//     
//                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
//
    NSLog(@"main,imageArray is %@",imageArray);
    
    NSLog(@"main,thread is %@",[NSThread currentThread]);
}

-(void)allPhotosCollected:(NSArray*)imgArray
{
    //write your code here after getting all the photos from library...
    NSLog(@"all pictures are %@",imgArray);
//    [self.collectionView reloadData];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView reloadData];
//    });
    
//    [self.collectionView reloadData];
//    self.collectionView performSelectorOnMainThread:<#(SEL)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#> modes:<#(NSArray *)#>
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
        
    
//dispatch_sync(dispatch_get_main_queue(), ^{
//    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    scroll.contentSize = CGSizeMake(self.view.bounds.size.width * imageArray.count, self.view.bounds.size.height);
//    for (int i = 0; i < imageArray.count; i++) {
////        NSData *data = [NSData dataWithContentsOfURL:imageArray[i]];
////        UIImage *image = [UIImage imageWithData:data];
//        ALAssetsLibrary * lib = [[ALAssetsLibrary alloc] init];
//        NSLog(@"thread is %@",[NSThread currentThread]);
//        [lib assetForURL:imageArray[i] resultBlock:^(ALAsset *asset) {
//            NSLog(@"resultBlock thread is %@",[NSThread currentThread]);
//                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//                imageView.contentMode = UIViewContentModeScaleToFill;
//                UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
//                imageView.image = image;
//                imageView.frame = CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//                [scroll addSubview:imageView];
//                scroll.backgroundColor = [UIColor redColor];
//                [self.view addSubview:scroll];
//
//        } failureBlock:^(NSError *error) {
//            
//        }];
//                           
//        
//
//    }
//});
}



- (IBAction)imagePicker:(id)sender {
//    [self getAllPictures];
//    NSLog(@"%@",imageArray);
    JSBSSettingHeaderVC *vc = [[JSBSSettingHeaderVC alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
