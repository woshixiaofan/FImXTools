//
//  DatePickerController.m
//  MYWORK
//
//  Created by 凡迅 on 16/5/17.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "DatePickerController.h"
#import "Header.h"

@interface DatePickerController ()
@property(strong, nonatomic)UITextField *birthdayFiled;
@property(nonatomic,strong)UIDatePicker *datePicker;//日期选择
@end

@implementation DatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.birthdayFiled=[[UITextField alloc]initWithFrame:CGRectMake(50, 100, WIDTH-100, 40)];
    [self.view addSubview:self.birthdayFiled];
    _birthdayFiled.backgroundColor=[[UIColor magentaColor]colorWithAlphaComponent:0.3];
    
    //代码创建UIDatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置datepicker的本地化为中国
    datePicker.locale = [NSLocale
                         localeWithLocaleIdentifier:@"zh"];
    
    //设置datepicker模式
    datePicker.datePickerMode = UIDatePickerModeDate;//只显示日期，不显示时间
    //设置textFiled键盘
    self.birthdayFiled.inputView = datePicker;
    datePicker.backgroundColor=[UIColor whiteColor];
    
    //代码创建UIToolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.bounds = CGRectMake(0, 0, 320, 44);
    toolbar.backgroundColor = [UIColor grayColor];
    
    //创建上一个按钮
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //创建下一个按钮
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //弹簧
    UIBarButtonItem *tanhuangBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //创建完成按钮
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelectedDate)];
    
    
    toolbar.items = @[previous,next,tanhuangBtn,finish];
    
    //设置inputAccessoryView在，就能在键盘上面添加辅助的view
    self.birthdayFiled.inputAccessoryView = toolbar;
    
    self.datePicker = datePicker;

}

-(void)finishSelectedDate{
    //获取时间
    NSDate *selectedDate = self.datePicker.date;
    
    //格式化日期(2014-08-25)
    //格式化日期类
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    //设置日期格式
    formater.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [formater stringFromDate:selectedDate];
    NSLog(@"%@",dateStr);
    
    //设置textfiled的文本
    
    self.birthdayFiled.text = dateStr;
    
    //隐藏键盘
    [self.birthdayFiled resignFirstResponder];
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
