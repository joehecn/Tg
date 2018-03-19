//
//  CitySelectedButton.m
//  Tg
//
//  Created by 何苗 on 2018/3/16.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "CitySelectedButton.h"

@implementation CitySelectedButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 50;
    CGFloat h = 44;
    return CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = 50;
    CGFloat y = (44.0 - 15) / 2;
    CGFloat w = 15;
    CGFloat h = 15;
    return CGRectMake(x, y, w, h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
