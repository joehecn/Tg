//
//  StarRateView.h
//  Tg
//
//  Created by 何苗 on 2018/3/20.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarRateViewDelegate <NSObject>

-(void)getCurrentScore:(CGFloat)currentScore;

@end

@interface StarRateView : UIView

@property(nonatomic, weak)id<StarRateViewDelegate>delegate;

@end
