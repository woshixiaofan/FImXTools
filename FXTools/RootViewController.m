//
//  RootViewController.m
//  MYWORK
//
//  Created by 凡迅 on 16/4/15.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "RootViewController.h"
#import "Header.h"
#import "UIColor+Extension.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation RootViewController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title=@"Hello world";
    
    self.dataArray=[NSArray arrayWithObjects:@"KeyboardController",@"NavBarController",@"CornerController",@"PlaceHolderController",@"SDCycleController",@"TTTAttributedLabelController",@"CollectionController",@"UMLoginController",@"VoiceController",@"LabelController",@"AlertController",@"PickerController",@"DatePickerController",@"MohuController",@"ErweimaController",@"ReadBookController",@"ShareController",nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cells";
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cells) {
        cells = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cells.textLabel.text=self.dataArray[indexPath.row];
    return cells;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title=self.dataArray[indexPath.row];
    UIViewController *subViewController = [[NSClassFromString(title) alloc] init];
    if (![title isEqualToString:@"NavBarController"]) {
        subViewController.view.backgroundColor=[UIColor whiteColor];
    }
    subViewController.title = title;
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 DX3Q50W0FR9K   F75SNL6JHG75
 /Users/fanxun/Desktop/IMTools
*/
@end
