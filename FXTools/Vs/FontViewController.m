//
//  FontViewController.m
//  MYWORK
//
//  Created by 凡迅 on 16/8/9.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "FontViewController.h"
#import "Header.h"
@implementation FontViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array=@[@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",@"艾美艾美艾美",];
    double height=10;
    double font=10;
    
    for (int i=0; i<array.count; i++) {
        
        UILabel *size=[[UILabel alloc]init];
        size.backgroundColor=DEBUG_COLOR;
        size.font=[UIFont systemFontOfSize:font+i];
        
        CGRect rect0=[self getRectFont:size.font.pointSize content:array[i]];
        
        size.frame=CGRectMake(20, height, 230, rect0.size.height);
        
        [self.view addSubview:size];
        
        UILabel *label=[[UILabel alloc]init];
        label.backgroundColor=DEBUG_COLOR;
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:font+i];
        
        CGRect rect=[self getRectFont:label.font.pointSize content:array[i]];
        
        label.frame=CGRectMake(size.right+20, height, rect.size.width, rect.size.height);
        [self.view addSubview:label];
        height += rect0.size.height+10;
        
        size.text=[NSString stringWithFormat:@"%@  %.3f  %.3f  %.3f",@(size.font.pointSize),rect.size.width,rect.size.height,(rect.size.width-label.text.length*label.font.pointSize)/(label.text.length-1)];
    }
}

- (CGRect)getRectFont:(double)font content:(NSString *)content {
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
    CGRect rect = [content?:@"" boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}
@end
