//
//  HamburgerView.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/9.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "HamburgerView.h"

@implementation HamburgerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _iv = [[UIImageView alloc]initWithFrame:self.bounds];
        _iv.contentMode = UIViewContentModeCenter;
        _iv.image = [UIImage imageNamed:@"Hamburger"];
        [self addSubview:_iv];
    }
    return self;
}
-(void)setFraction:(CGFloat)fraction{
    CGFloat angle = fraction*M_PI/2.0; //（0-90°）
    _iv.transform = CGAffineTransformMakeRotation(angle);
}
@end
