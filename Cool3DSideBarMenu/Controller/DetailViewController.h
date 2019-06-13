//
//  DetailViewController.h
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (nonatomic,strong)MenuItemModel *item;
@end

NS_ASSUME_NONNULL_END
