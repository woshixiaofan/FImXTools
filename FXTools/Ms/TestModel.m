//
//  TestModel.m
//  FXTools
//
//  Created by 凡迅 on 2017/1/11.
//  Copyright © 2017年 JNDL. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
//        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:dic];
//        for (int i = 0;i < [d allKeys].count;i++) {
//            NSString *key = [[d allKeys] objectAtIndex:i];
//            NSString *value = [[d allValues] objectAtIndex:i];
//            if ([value isEqual:[NSNull null]]) {
//                [d setValue:@"0" forKey:key];
//            }
//        }
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
