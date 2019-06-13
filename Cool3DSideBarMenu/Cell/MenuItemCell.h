//
//  MenuItemCell.h
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (nonatomic,strong)MenuItemModel *model;
@end

NS_ASSUME_NONNULL_END
