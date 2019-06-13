//
//  MenuViewController.m
//  Cool3DSideBarMenu
//
//  Created by wubo on 2019/6/6.
//  Copyright © 2019 nycojie@gmail.com. All rights reserved.
//

#import "MenuViewController.h"
#import "DetailViewController.h"
#import "MenuItemCell.h"
@interface MenuViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MenuItemCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MenuItemCell class])];
    [self initData];
    
    
}
-(void)initData{
    _dataArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MenuItems" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (int i = 0;i<arr.count;i++){
        MenuItemModel *model = [[MenuItemModel alloc]init];
        NSDictionary *dic = arr[i];
        model.bigImageName = dic[@"bigImageName"];
        model.colorArray = dic[@"colorArray"];
        model.imageName = dic[@"imageName"];
        [_dataArr addObject:model];
    }
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = tableView.safeAreaLayoutGuide.layoutFrame.size.height/(CGFloat)self.dataArr.count;
    return MIN(100, height);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuItemCell class]) forIndexPath:indexPath];
    
    MenuItemModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
     MenuItemModel *model = self.dataArr[_indexPath.row];
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectMenuItem:)]){
        [self.delegate didSelectMenuItem:model];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destination =  segue.destinationViewController;
    MenuItemModel *model = self.dataArr[_indexPath.row];
    destination.item = model;
}


@end
