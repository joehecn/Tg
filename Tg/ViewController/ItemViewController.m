//
//  ItemViewController.m
//  Tg
//
//  Created by 何苗 on 2018/3/20.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "ItemViewController.h"
#import "Util.h"
#import "StarRateView.h"

@interface ItemViewController () <UIScrollViewDelegate, StarRateViewDelegate> {
    UIScrollView *sv_image;
    UIPageControl *pageControl;
    NSTimer *timer;
    int imageIndex;
    
    StarRateView *starRateView;
    UILabel *lab_currentScore;
}

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // header 颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    self.navigationItem.title = self.itemDatasource.title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    // 轮播图 sv 空白
//    if (@available(iOS 11.0, *)) {
//
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = false;
//    }
    
    UIView *view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
    view_head.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_head];
    
    sv_image = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.6)];
    sv_image.contentSize = CGSizeMake(SCREEN_WIDTH * 4, 0);
    sv_image.pagingEnabled = true;
    sv_image.directionalLockEnabled = true;
    sv_image.showsHorizontalScrollIndicator = false;
//    sv_image.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    sv_image.delegate = self;
    
    [view_head addSubview:sv_image];
    
    for (int index = 0; index < 4; index++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH *0.6)];
        NSString *imagePath = [NSString stringWithFormat:@"%d", index + 1];
        imageView.image = [UIImage imageNamed:imagePath];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [sv_image addSubview:imageView];
    }
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.6 - 20, SCREEN_WIDTH, 20)];
    pageControl.numberOfPages = 4;
//    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [view_head addSubview:pageControl];
    
    imageIndex = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imagePlay) userInfo:nil repeats:true];
    
    UIView *view_buy = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + SCREEN_WIDTH * 0.6 + 5, SCREEN_WIDTH, 50)];
    view_buy.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_buy];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
    label1.text = @"¥27.8";
    label1.font = [UIFont systemFontOfSize:15.0];
    label1.textColor = MYGREENCOLOR;
    [view_buy addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100) / 2, 0, 60, 50)];
    label2.text = @"团购价: ¥22";
    label2.font = [UIFont systemFontOfSize:14.0];
    label2.textColor = [UIColor grayColor];
    [view_buy addSubview:label2];
    
    UIButton *bt_buy = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 0, 100, 50)];
    [bt_buy setTitle:@"19.9拿下" forState:UIControlStateNormal];
    bt_buy.backgroundColor = [UIColor orangeColor];
    [view_buy addSubview:bt_buy];
    
    // 评分
    UIView *view_star = [[UIView alloc]initWithFrame:CGRectMake(0, view_buy.frame.origin.y + view_buy.frame.size.height + 5, SCREEN_WIDTH, 40)];
    view_star.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_star];
    
    starRateView = [[StarRateView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    starRateView.delegate = self;
    [view_star addSubview:starRateView];
    
    lab_currentScore = [[UILabel alloc]initWithFrame:CGRectMake(starRateView.frame.size.width + 5, 0, 50, 40)];
    lab_currentScore.text = @"0分";
    lab_currentScore.textColor = [UIColor grayColor];
    [view_star addSubview:lab_currentScore];
    
    // 商品描述
    UIView *view_desc = [[UIView alloc]initWithFrame:CGRectMake(0, view_star.frame.origin.y + view_star.frame.size.height + 5, SCREEN_WIDTH, 150)];
    view_desc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view_desc];
    
    UILabel *lab_desc1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    lab_desc1.text = @"商品详细信息";
    lab_desc1.textAlignment = NSTextAlignmentCenter;
    lab_desc1.font = [UIFont systemFontOfSize:15.0];
    [view_desc addSubview:lab_desc1];
    
    UILabel *lab_desc2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
    lab_desc2.text = @"该菜品口感纯正，价格公道，分量十足。欢迎进店品尝。门店地址：北京市海淀区XX路YY胡同999号。10月28日之前进店还能享受98折优惠呢！还等什么，手机下单立减五元！";
    lab_desc2.numberOfLines = 0;
    lab_desc2.font = [UIFont systemFontOfSize:12.0];
    [view_desc addSubview:lab_desc2];
}

-(void)getCurrentScore:(CGFloat)currentScore {
    NSString *score = [NSString stringWithFormat:@"%.1f分", currentScore * 5];
    lab_currentScore.text = score;
}

-(void)imagePlay {
    pageControl.currentPage = imageIndex;
    sv_image.contentOffset = CGPointMake(imageIndex * SCREEN_WIDTH, 0);
    imageIndex++;
    if (imageIndex >= 4) {
        imageIndex = 0;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    imageIndex = x / SCREEN_WIDTH;
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
