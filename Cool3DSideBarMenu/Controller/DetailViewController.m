//
//  DetailViewController.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (nonatomic,strong)UIImageView *animateIv;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.animateIv = [[UIImageView alloc] init];
    self.animateIv.frame = CGRectMake(self.view.center.x-30/2, -60, 60, 60);
    [self.view addSubview:self.animateIv];
    self.animateIv.hidden = YES;
}
-(void)setItem:(MenuItemModel *)item{
    
    [self.animateIv.layer removeAllAnimations];
    [self.iv.layer removeAllAnimations];
    
    _item = item;
    self.view.backgroundColor = item.color;
    self.iv.image = item.bigImage;
    self.animateIv.hidden = NO;
    self.animateIv.image = item.image;
   
//    CATransform3D identity = CATransform3DIdentity;
//    identity.m22 = -identity.m22;//垂直翻转
//    identity.m11 = -identity.m11;//水平翻转
//    identity.m24 = -identity.m24;
//    self.iv.layer.transform = identity;

   
    CABasicAnimation *rotationAimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAimation.duration = 0.15f;
    rotationAimation.repeatDuration = 1.8f;
    rotationAimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotationAimation.toValue = [NSNumber numberWithFloat:M_PI];
    [self.animateIv.layer addAnimation:rotationAimation forKey:@"rotation"];
    
    
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"position"];
    transform.duration = 2.0f;
    transform.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, 0)];
    transform.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y-180)];
    [self.animateIv.layer addAnimation:transform forKey:@"transform"];
    
    
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    //damping阻尼系数，越大，停止越快
    spring.damping = 10;
    spring.initialVelocity = -0.71;
    //stiffness刚度系数 越大，运动越快，默认100
    spring.stiffness = 200;
    //mass 模拟的是质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    spring.mass = 0.7;
    spring.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 0.5, 1)];
    spring.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    spring.beginTime = CACurrentMediaTime()+2.0f;
    spring.duration = spring.settlingDuration;;
    [self.iv.layer addAnimation:spring forKey:@"springAnimation"];
    
//    使用UIVeiw动画也可以实现，但是在快速切换时imageView上的动画执行有问题，一时解决不了，换用CAAnimation可以很好的管理控制动画
//    [UIView animateWithDuration:2.0f animations:^{
//        self.animateIv.layer.transform = CATransform3DMakeTranslation(0, 90+self.iv.frame.origin.y, 0);
//
//    } completion:^(BOOL finished) {
//
//        self.animateIv.layer.transform = CATransform3DIdentity;
//        self.animateIv.hidden = YES;
//
//    }];
//
//    [UIView animateWithDuration:0.1 delay:2.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
//
//        CATransform3D scaleTransform = CATransform3DMakeScale(1.1, 0.5, 1);
//        self.iv.layer.transform = scaleTransform;
//
//    } completion:^(BOOL finished) {
//
//        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            CATransform3D scaleTransform = CATransform3DMakeScale(1, 1, 1);
//            self.iv.layer.transform = scaleTransform;
//
//        } completion:^(BOOL finished) {
//
//
//        }];
//
//
//    }];
}
@end
