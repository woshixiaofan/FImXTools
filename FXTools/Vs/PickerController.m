//
//  PickerController.m
//  MYWORK
//
//  Created by 凡迅 on 16/4/25.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "PickerController.h"
#import "PSCityPickerView.h"
#import "UIView+corners.h"
#import "Header.h"
@interface PickerController ()<PSCityPickerViewDelegate>
@property (strong, nonatomic) PSCityPickerView *cityPicker;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation PickerController

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, WIDTH-100, 50)];
    _textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"省 市 县" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [_textField setStyle:666 cornerRedius:4];
    _textField.backgroundColor=[UIColor orangeColor];
    _textField.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:_textField];
    self.textField.inputView = self.cityPicker;
}

#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(PSCityPickerView *)picker
    finishPickProvince:(NSString *)province
                  city:(NSString *)city
              district:(NSString *)district
{
    [self.textField setText:[NSString stringWithFormat:@"%@ %@ %@",province,city,district]];
}

#pragma mark - Getter and Setter
- (PSCityPickerView *)cityPicker
{
    if (!_cityPicker)
    {
        _cityPicker = [[PSCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
    }
    return _cityPicker;
}
/*
 #pragma mark - Navigation

2017-01-16 15:48:47.780 FXTools[403:18681] APIBase request didFailWithError
2017-01-16 15:48:47.781 FXTools[403:18681] APIBase request didFailWithError
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
