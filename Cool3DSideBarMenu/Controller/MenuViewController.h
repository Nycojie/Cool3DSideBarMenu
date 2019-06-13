//
//  MenuViewController.h
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItemModel;
NS_ASSUME_NONNULL_BEGIN
@protocol MenuViewControllerDelegate <NSObject>

-(void)didSelectMenuItem:(MenuItemModel*)model;

@end

@interface MenuViewController : UITableViewController
@property (nonatomic,weak)id<MenuViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
