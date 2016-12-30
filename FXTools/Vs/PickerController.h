//
//  PickerController.h
//  MYWORK
//
//  Created by 凡迅 on 16/4/25.
//  Copyright © 2016年 JNDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain)UIPickerView * pickerView;

@end
