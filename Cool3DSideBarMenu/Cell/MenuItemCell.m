//
//  MenuItemCell.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
}
-(void)setModel:(MenuItemModel *)model{
    
    _model = model;
    self.backgroundColor = model.color;
    self.iv.image = model.image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
