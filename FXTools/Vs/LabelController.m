//
//  RootViewController.m
//  Label
//
//  Created by 凡迅 on 16/4/15.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import "LabelController.h"
#import "IMLabel.h"
#import "Header.h"

#define LINESPACE   5
#define TEXTFONT    15
@interface LabelController ()
@property (nonatomic, strong)IMLabel *label1;
@property (nonatomic, strong)IMLabel *label2;
@property (nonatomic, strong)IMLabel *label3;
@property (nonatomic, strong)IMLabel *label4;
@end

@implementation LabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    
    _label1.text=TEXT;
    _label2.text=TEXT;
    _label3.text=TEXT;
    _label4.text=TEXT;
    
    
    _label1.frame=CGRectMake(KLEFT, KLEFT, WIDTH-2*KLEFT, [_label1 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label2.frame=CGRectMake(KLEFT, KLEFT+_label1.bottom, WIDTH-2*KLEFT, [_label2 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label3.frame=CGRectMake(KLEFT, KLEFT+_label2.bottom, WIDTH-2*KLEFT, [_label3 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    _label4.frame=CGRectMake(KLEFT, KLEFT+_label3.bottom, WIDTH-2*KLEFT, [_label4 getAttributedStringHeightWidthValue:WIDTH-2*KLEFT]);
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point   = [[touches anyObject] locationInView:self.label4];
    NSLog(@"%.2f",point.x);
    
    //    CFIndex idx     = [self characterIndexAtPoint:point];
    //    self.activeLink = [self linkAtCharacterIndex:idx];
    //
    //    if (!self.activeLink)
    //    {
    //        [super touchesBegan:touches withEvent:event];
    //    }
}
- (IMLabel *)label1 {
    if (!_label1) {
        self.label1 = [[IMLabel alloc]init];
        _label1.numberOfLines=0;
        _label1.font=[UIFont systemFontOfSize:TEXTFONT];
        _label1.backgroundColor=DEBUG_COLOR;
        _label1.linesSpacing=LINESPACE;
        _label1.firstLineHeadIndent=_label1.font.pointSize*2;
        
    }
    return _label1;
}
- (IMLabel *)label2 {
    if (!_label2) {
        self.label2 = [[IMLabel alloc]init];
        _label2.numberOfLines=2;
        _label2.font=[UIFont systemFontOfSize:TEXTFONT];
        _label2.backgroundColor=DEBUG_COLOR;
        _label2.linesSpacing=LINESPACE;
        _label2.firstLineHeadIndent=_label2.font.pointSize*2;
    }
    return _label2;
}
- (IMLabel *)label3 {
    if (!_label3) {
        self.label3 = [[IMLabel alloc]init];
        _label3.numberOfLines=3;
        _label3.font=[UIFont systemFontOfSize:TEXTFONT];
        _label3.backgroundColor=DEBUG_COLOR;
        _label3.linesSpacing=LINESPACE;
        _label3.firstLineHeadIndent=_label3.font.pointSize*2;
    }
    return _label3;
}
- (IMLabel *)label4 {
    if (!_label4) {
        self.label4 = [[IMLabel alloc]init];
        _label4.numberOfLines=1;
        _label4.font=[UIFont systemFontOfSize:TEXTFONT];
        _label4.backgroundColor=DEBUG_COLOR;
        _label4.linesSpacing=10;
        _label4.wordSpacing=0;
        _label4.firstLineHeadIndent=_label4.font.pointSize*2+_label4.wordSpacing*2;
    }
    return _label4;
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
