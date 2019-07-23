//
//  TableViewController.m
//  ObserverTable
//
//  Created by Jion on 2017/7/19.
//  Copyright © 2017年 天天. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "HederView.h"
@interface TableViewController ()
{
    HederView *_header;
}
@end

@implementation TableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _header.source = [NSDictionary dictionary];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    _header = [[HederView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 200)];
    self.tableView.tableHeaderView = _header;
    //设置数据源一定要在设置为headerView之后
    _header.source = @{};
}
-(void)dealloc{
    [_header.superview removeObserver:_header forKeyPath:@"contentOffset" context:(__bridge void * _Nullable)(NSStringFromClass([_header class]))];
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"row == %ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CollectionViewController *collectionView = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:collectionView animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
