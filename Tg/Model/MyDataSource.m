//
//  MyDataSource.m
//  Tg
//
//  Created by 何苗 on 2018/3/19.
//  Copyright © 2018年 joehe. All rights reserved.
//

// 单例类 单例模式
#import "MyDataSource.h"

@interface MyDataSource () {
    NSString *currentCityName;
}

@end

@implementation MyDataSource

// 1 全局变量
static id _instance = nil;
// 2 单例方法
+(instancetype)getInstance {
    return [[self alloc]init];
}
// 3 初始化方法 只执行一次
-(instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}

-(void)setCityName:(NSString *)str {
    currentCityName = str;
}

-(NSString *)getCityName {
    return currentCityName;
}
@end
