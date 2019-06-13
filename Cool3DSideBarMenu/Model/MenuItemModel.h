//
//  MenuItemModel.h
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/8.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MenuItemModel : NSObject
@property (nonatomic,copy)NSString *bigImageName;
@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString  *colorArray;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)UIImage *bigImage;
@property (nonatomic,strong)UIColor *color;
@end

NS_ASSUME_NONNULL_END
