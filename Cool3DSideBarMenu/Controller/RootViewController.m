//
//  RootViewController.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "RootViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"
#import "HamburgerView.h"
#import "Masonry.h"
#define weakSelf(weakSelf) __weak typeof(self) weakSelf = self
@interface RootViewController ()<UIScrollViewDelegate,MenuViewControllerDelegate>
@property (nonatomic,assign)CGFloat menuWidth;
@property (nonatomic,assign)CGFloat threshold;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)MenuViewController *menuVC;
@property (nonatomic,strong)DetailViewController *detailVC;
@property (nonatomic,strong)UIView *menuContainer;
@property (nonatomic,strong)UIView *detailContainer;
@property (nonatomic,strong)HamburgerView *hamburgerView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuWidth = 80;
    _threshold = _menuWidth/2.0;
    
    [self creatView];
    
}
-(void)creatView{
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delaysContentTouches = NO;
    _scrollView.delegate = self;
    weakSelf(weakSelf);
    [self.view addSubview:self.scrollView];
    [weakSelf.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
   
    UIView *horizontalContainerView = [[UIView alloc]init];
    [self.scrollView addSubview:horizontalContainerView];
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.scrollView);
        make.height.equalTo(weakSelf.scrollView);
        
    }];
    //过渡视图添加子视图
    UIView *previousView =nil;
    _menuContainer = [[UIView alloc]init];
    [horizontalContainerView addSubview:self.menuContainer];

    [weakSelf.menuContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(weakSelf.menuWidth);
    }];
    previousView = self.menuContainer;
    
    _detailContainer = [[UIView alloc]init];
    [horizontalContainerView addSubview:_detailContainer];

    [weakSelf.detailContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.menuContainer.mas_trailing);
        make.width.mas_equalTo(weakSelf.scrollView.mas_width);
        make.bottom.top.mas_equalTo(0);
    }];

    previousView = weakSelf.detailContainer;

    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(previousView.mas_right);
    }];    
    _menuVC = (MenuViewController*)[self installFromStroryboard:NSStringFromClass([MenuViewController class]) into:_menuContainer];
    _menuVC.delegate = self;
    _detailVC = (DetailViewController*)[self installFromStroryboard:NSStringFromClass([DetailViewController class]) into:_detailContainer];
    _hamburgerView = [[HamburgerView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(burgerTaped)];
    _hamburgerView.iv.userInteractionEnabled = YES;
    [_hamburgerView addGestureRecognizer:tap];
    
    _detailVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_hamburgerView];
    _hamburgerView.fraction = 1.0;
}
#pragma mark - Private
-(UIViewController*)installFromStroryboard:(NSString*)name into:(UIView*)container{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:name];
    UINavigationController *nv = [self installInNavigationControllerWithRootVC:vc];
    [container addSubview:nv.view];
    [nv.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.mas_equalTo(0);
    }];
    return vc;
}
-(UINavigationController*)installInNavigationControllerWithRootVC:(UIViewController*)rootVC{
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:rootVC];
    nv.navigationBar.barTintColor = [UIColor blackColor];
    nv.navigationBar.tintColor = [UIColor whiteColor];
    nv.navigationBar.translucent = NO;
    nv.navigationBar.clipsToBounds = YES;
    [self addChildViewController:nv];
    return nv;
}
-(void)burgerTaped{
    [self toggleMenu];
}
#pragma mark - MenuViewControllerDelegate
- (void)didSelectMenuItem:(MenuItemModel *)model{
    _detailVC.item = model;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    scrollView.pagingEnabled = offset.x<_threshold;
    CGFloat fraction = [self calculateMenuDisplayFraction:scrollView];
    _hamburgerView.fraction = fraction;
    [self updateViewVisibility:_menuContainer andFraction:fraction];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint offset = scrollView.contentOffset;
    if(offset.x>_threshold){
        [self hideMenu];
    }
}
-(CGFloat)calculateMenuDisplayFraction:(UIScrollView*)scrollView{
    CGFloat fraction = scrollView.contentOffset.x/_menuWidth;
    CGFloat clamped = MIN(MAX(0, fraction), 1.0);
    return clamped;
}
-(void)moveMenuWithNextPosition:(CGFloat)positon{
    CGPoint nextPosition = CGPointMake(positon, 0);
    [_scrollView setContentOffset:nextPosition animated:YES];
}
-(void)hideMenu{
    [self moveMenuWithNextPosition:_menuWidth];
}
-(void)showMenu{
    [self moveMenuWithNextPosition:0];
}
-(void)toggleMenu{
    BOOL menuIsHidden = _scrollView.contentOffset.x > _threshold;
    if(menuIsHidden){
        [self showMenu];
    }else{
        [self hideMenu];
    }
}
-(void)updateViewVisibility:(UIView*)container andFraction:(CGFloat)fraction{
    container.layer.anchorPoint = CGPointMake(1.0, 0.5);
    container.layer.transform = [self transfromForFraction:fraction andOfWidth:_menuWidth];
    container.alpha = 1.0-fraction;
}
-(CATransform3D)transfromForFraction:(CGFloat)fraction andOfWidth:(CGFloat)width{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000.0;
    CGFloat angle = -fraction*M_PI/2.0;
    CGFloat xoffset = width/2.0 + width*fraction/4.0;
    CATransform3D rotate  = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D translate = CATransform3DMakeTranslation(xoffset, 0.0, 0.0);
    return CATransform3DConcat(rotate, translate);
}
@end
