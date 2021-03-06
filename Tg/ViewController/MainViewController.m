//
//  MainViewController.m
//  Tg
//
//  Created by 何苗 on 2018/3/16.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "BusinessViewController.h"
#import "UserViewController.h"

@interface MainViewController () {
    HomeViewController* vc_home;
    BusinessViewController* vc_business;
    UserViewController* vc_user;
    
    UINavigationController* nav_home;
    UINavigationController* nav_business;
    UINavigationController* nav_user;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vc_home = [[HomeViewController alloc]init];
    vc_home.tabBarItem.title = @"主页";
    vc_home.tabBarItem.image = [UIImage imageNamed:@"home"];
    nav_home = [[UINavigationController alloc]initWithRootViewController:vc_home];
    [self addChildViewController:nav_home];
    
    vc_business = [[BusinessViewController alloc]init];
    vc_business.tabBarItem.title = @"购物";
    vc_business.tabBarItem.image = [UIImage imageNamed:@"shop"];
    nav_business = [[UINavigationController alloc]initWithRootViewController:vc_business];
    [self addChildViewController:nav_business];
    
    vc_user = [[UserViewController alloc]init];
    vc_user.tabBarItem.title = @"用户";
    vc_user.tabBarItem.image = [UIImage imageNamed:@"login_username"];
    nav_user = [[UINavigationController alloc]initWithRootViewController:vc_user];
    [self addChildViewController:nav_user];
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.16 green:0.72 blue:0.55 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
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
