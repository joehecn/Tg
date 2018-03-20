//
//  StarRateView.m
//  Tg
//
//  Created by 何苗 on 2018/3/20.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "StarRateView.h"

@interface StarRateView () {
    UIView *foreStarView;
    UIView *backStarView;
    CGFloat currentScore;
}

@end

@implementation StarRateView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        foreStarView = [self createView:@"star_yellow" frame:CGRectZero];
        backStarView = [self createView:@"star_gray" frame:self.bounds];
        [self addSubview:backStarView];
        [self addSubview:foreStarView];
        
        UITapGestureRecognizer *tagGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tagGeture.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:tagGeture];
    }
    return self;
}

-(void)tapAction:(UITapGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:self];
    CGFloat x = tapPoint.x;
    CGFloat realStarScore = x / (self.bounds.size.width / 5);
    currentScore = realStarScore / 5;
    [self refushUI];
}

-(void)refushUI {
    if (currentScore < 0) {
        currentScore = 0;
    } else if (currentScore > 1) {
        currentScore = 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(getCurrentScore:)]) {
        [self.delegate getCurrentScore:currentScore];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    foreStarView.frame = CGRectMake(0, 0, self.bounds.size.width * currentScore, self.bounds.size.height);
    [UIView commitAnimations];
    
}

-(UIView *)createView:(NSString *)imageName frame:(CGRect)frame {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.clipsToBounds = true;
    view.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(self.bounds.size.width / 5 * i, 0, self.bounds.size.width / 5, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
