//
//  ClassButton.m
//  Tg
//
//  Created by 何苗 on 2018/3/19.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "ClassButton.h"
@interface ClassButton () {
    CGRect imageRect;
    CGRect titleRect;
}
@end

@implementation ClassButton

-(instancetype)initWithFrame:(CGRect)frame imageFrame:(CGRect)imageFrame titleFrame:(CGRect)titleFrame {
    if (self = [super initWithFrame:frame]) {
        imageRect = imageFrame;
        titleRect = titleFrame;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat x = titleRect.origin.x;
    CGFloat y = titleRect.origin.y;
    CGFloat w = titleRect.size.width;
    CGFloat h = titleRect.size.height;
    return CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat x = imageRect.origin.x;
    CGFloat y = imageRect.origin.y;
    CGFloat w = imageRect.size.width;
    CGFloat h = imageRect.size.height;
    return CGRectMake(x, y, w, h);
}

@end
