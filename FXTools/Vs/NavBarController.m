//
//  NavBarController.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/9.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "NavBarController.h"
#import "Header.h"
#import "UIColor+Extension.h"
@interface NavBarController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NavBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImage *image = [[UIColor blueColor] imageWithColor];
    [self.navigationController.navigationBar setBackgroundImage:image  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
    
    [self loadData];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
-(void)loadData{
    _dataArray =[[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i++) {
        NSString * string=[NSString stringWithFormat:@"第%d行",i];
        [_dataArray addObject:string];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MotaiController *motai = [[MotaiController alloc]init];
    motai.title=@"motai";
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:motai];
    UIImage *image = [[UIColor orangeColor] imageWithColor];
    [naVC.navigationBar setBackgroundImage:image  forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    naVC.navigationBar.shadowImage = image;
    [self.navigationController presentViewController:naVC animated:YES completion:^{
        
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    NSString *str=_dataArray[indexPath.row];
    cell.textLabel.text=str;
    return cell;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
