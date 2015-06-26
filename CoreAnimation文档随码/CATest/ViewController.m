//
//  ViewController.m
//  CATest
//
//  Created by dai.fengyi on 15/5/23.
//  Copyright (c) 2015年 childrenOurFuture. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, weak) IBOutlet UIView *containerView;
//@property (nonatomic, weak) IBOutlet UIView *shipView;
//@property (nonatomic, weak) IBOutlet UIView *iglooView;
//@property (nonatomic, weak) IBOutlet UIView *anchorView;

@property (strong, nonatomic) NSMutableArray *faces;

@end

@implementation ViewController
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = [[UIView alloc] initWithFrame:self.containerView.bounds];
    face.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:face];
    if (_faces == nil) {
        _faces = [NSMutableArray array];
    }
    [_faces addObject:face];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    //apply lighting
    [self applyLightingToFace:face.layer];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50, 50, 120, 120);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    blueLayer.contents = (__bridge id)([UIImage imageNamed:@"评论头像5"].CGImage);
//    blueLayer.contentsGravity = kCAGravityResizeAspect;
//    [self.layerView.layer addSublayer:blueLayer];
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //create sublayer
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    //set controller as layer delegate
//    blueLayer.delegate = self;
//    //ensure that layer backing image uses correct scale
//    blueLayer.contentsScale = [UIScreen mainScreen].scale;
//    //add layer to our view 
//    [self.coneView.layer addSublayer:blueLayer];
//    //force layer to redraw
//    [blueLayer display];
//}
//
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    //draw a thick red circle
//    CGContextSetLineWidth(ctx, 10.0f);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokeEllipseInRect(ctx, layer.bounds);
//}
//- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer {
//    //set image
//    layer.contents = (__bridge id)image.CGImage;
//    //set contentsCenter
//    layer.contentsCenter = rect;
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //load button image
//    UIImage *image = [UIImage imageNamed:@"相册头像2"];
//    //set button 1
//    [self addStretchableImage:image withContentCenter:CGRectMake(0, 0, 1, 1) toLayer:self.coneView.layer];
//    //set button 2
//    [self addStretchableImage:image withContentCenter:CGRectMake(0.1, 0.1, 0.01, 0.01) toLayer:self.shipView.layer]; }

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //enable layer shadows
//    self.coneView.layer.shadowOpacity = 0.5f;
//    self.shipView.layer.shadowOpacity = 0.5f;
//    //create a square shadow
//    CGMutablePathRef squarePath = CGPathCreateMutable();
//    CGPathAddRect(squarePath, NULL, self.coneView.bounds);
//    self.coneView.layer.shadowPath = squarePath; CGPathRelease(squarePath);
//    //create a circular shadow
//    CGMutablePathRef circlePath = CGPathCreateMutable();
//    CGPathAddEllipseInRect(circlePath, NULL, self.shipView.bounds);
//    self.shipView.layer.shadowPath = circlePath; CGPathRelease(circlePath);
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.shipView.layer.contents = (__bridge id)[UIImage imageNamed:@"相册头像2"].CGImage;
//    //create mask layer
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = self.shipView.bounds;
//    UIImage *maskImage = [UIImage imageNamed:@"赞02"];
//    maskLayer.contents = (__bridge id)maskImage.CGImage;
//    //apply mask to image layer?
//    self.shipView.layer.mask = maskLayer;
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad]; //get spritesheet image
//    UIImage *digits = [UIImage imageNamed:@"Digits.png"];
//    //set up digit views
//    for (UIView *view in self.digitViews) {
//        //set contents
//        view.layer.contents = (__bridge id)digits.CGImage;
//        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
//        view.layer.contentsGravity = kCAGravityResizeAspect;
//    }
//    //start timer
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
//    //set initial clock time
//    [self tick];
//}
//- (void)setDigit:(NSInteger)digit forView:(UIView *)view
//{
//    //adjust contentsRect to select correct digit
//    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
//}
//- (void)tick
//{
//    //convert time to hours, minutes and seconds
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
//    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    ?
//    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
//    //set hours
//    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
//    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
//    //set minutes
//    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
//    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
//    //set seconds
//    [self setDigit:components.second / 10 forView:self.digitViews[4]];
//    [self setDigit:components.second % 10 forView:self.digitViews[5]];
//}
//- (UIButton *)customButton
//{
//    //create button
//    CGRect frame = CGRectMake(0, 0, 150, 50);
//    UIButton *button = [[UIButton alloc] initWithFrame:frame];
//    button.backgroundColor = [UIColor whiteColor];
//    button.layer.cornerRadius = 10;
//    //add label
//    frame = CGRectMake(20, 10, 110, 30);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.text = @"Hello World";
//    label.textAlignment = NSTextAlignmentCenter;
//    [button addSubview:label];
//    return button;
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //create opaque button
//    UIButton *button1 = [self customButton];
//    button1.center = CGPointMake(100, 150);
//    [self.view addSubview:button1];
//    //create translucent button
//    UIButton *button2 = [self customButton];
//    button2.center = CGPointMake(280, 150);
//    button2.alpha = 0.5;
//    [self.view addSubview:button2];
//    //enable rasterization for the translucent button
//    button2.layer.shouldRasterize = YES;
//    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //rotate the outer layer 45 degrees
//    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
//    self.coneView.layer.transform = outer;
//    //rotate the inner layer -45 degrees
//    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
//    self.shipView.layer.transform = inner;
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    //rotate the outer layer 45 degrees
//    CATransform3D outer = CATransform3DIdentity;
//    outer.m34 = -1.0 / 500.0;
//    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
//    self.coneView.layer.transform = outer;
//    //rotate the inner layer -45 degrees
//    CATransform3D inner = CATransform3DIdentity;
//    inner.m34 = -1.0 / 500.0;
//    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
//    self.shipView.layer.transform = inner;
//}
@end
