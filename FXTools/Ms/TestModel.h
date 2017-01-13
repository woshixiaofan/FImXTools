//
//  TestModel.h
//  FXTools
//
//  Created by 凡迅 on 2017/1/11.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic, strong)NSString *background_url;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *author;


@property (nonatomic, strong)NSNumber *charge_mode;
@property (nonatomic, strong)NSNumber *count;
@property (nonatomic, strong)NSNumber *current_chapter_id;


- (id)initWithDictionary:(NSDictionary *)dic;
@end
