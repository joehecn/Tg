//
//  MyDataSource.h
//  Tg
//
//  Created by 何苗 on 2018/3/19.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataSource : NSObject

+(instancetype)getInstance;
-(void)setCityName:(NSString *)str;
-(NSString *)getCityName;

@end
