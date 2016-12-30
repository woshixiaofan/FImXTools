//
//  PickerController.m
//  MYWORK
//
//  Created by 凡迅 on 16/4/25.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "PickerController.h"

@interface PickerController ()
@property(nonatomic,retain)NSMutableArray * provincesArray;

@property(nonatomic,retain)NSMutableArray * cityArray;
@end

@implementation PickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * string = [[NSBundle mainBundle] pathForResource:@"Provineces" ofType:@"plist"];
    
    self.provincesArray = [NSMutableArray arrayWithContentsOfFile:string];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:self.view.bounds];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
}

//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component ==0) {
        //省份个数
        return self.provincesArray.count;
    }
    //城市个数
    return self.cityArray.count;
}


//根据指定的组件和行号返回该行的标题，即应向用户显示的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //确定每个轮子上的内容
    if (component == 0) {
        //选择省份
        return [[self.provincesArray objectAtIndex:row] objectForKey:@"ProvinceName"];
    }else{
        //选择城市
        return [[self.cityArray objectAtIndex:row] objectForKey:@"CityName"];
    }
}


//当用户在选择器中做出选择时，将调用该委托方法，并向它传递用户选择的行号以及用户最后触摸的组件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component ==0) {
        self.cityArray =[[ self.provincesArray objectAtIndex:row ] objectForKey:@"cities"];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
    }
}


//改变字体大小,底色,位置
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //创建一个label
    UILabel * pickerLabel = (UILabel *) view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor cyanColor];
        pickerLabel.font = [UIFont systemFontOfSize:15];
    }
    //把label贴上
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
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
