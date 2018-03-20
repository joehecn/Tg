//
//  UserViewController.m
//  Tg
//
//  Created by 何苗 on 2018/3/16.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "UserViewController.h"
#import "Util.h"
#import "ClassButton.h"

@interface UserViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *sourceData;
    UITableView *tableView1;
}

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = true;
    UIView *view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    view_head.backgroundColor = MYGREENCOLOR;
    [self.view addSubview:view_head];
    
    ClassButton *bt_userName = [[ClassButton alloc]initWithFrame:CGRectMake(10, 40, 60, 60) imageFrame:CGRectMake(0, 0, 60, 60) titleFrame:CGRectZero];
    [bt_userName setImage:[UIImage imageNamed:@"userlogin"] forState:UIControlStateNormal];
    [view_head addSubview:bt_userName];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(70, 60, 100, 20)];
    lab.text = @"我的账户";
    lab.textColor = [UIColor whiteColor];
    [view_head addSubview:lab];
    
    array1 = [[NSMutableArray alloc]init];
    array2 = [[NSMutableArray alloc]init];
    array3 = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:@"shopping_cart.png" forKey:@"image"];
    [dic setValue:@"我的商品" forKey:@"title"];
    [array1 addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"score.png" forKey:@"image"];
    [dic setValue:@"我的积分" forKey:@"title"];
    [array2 addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"right.png" forKey:@"image"];
    [dic setValue:@"我的特权" forKey:@"title"];
    [array2 addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"icon_tel" forKey:@"image"];
    [dic setValue:@"电话" forKey:@"title"];
    [array3 addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"qqsupport" forKey:@"image"];
    [dic setValue:@"QQ" forKey:@"title"];
    [array3 addObject:dic];
    dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"weixinsupport" forKey:@"image"];
    [dic setValue:@"微信" forKey:@"title"];
    [array3 addObject:dic];
    
    sourceData = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,nil];
    
    // add tableView
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 150 - 44) style:UITableViewStyleGrouped];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    [self.view addSubview:tableView1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sourceData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArray = [sourceData objectAtIndex:section];
    return subArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"www.imooc.com.tuangou.user.tvb.cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSArray *array = [sourceData objectAtIndex:indexPath.section];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *image = [dic valueForKey:@"image"];
    NSString *title = [dic valueForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:image];
    cell.textLabel.text = title;
    
//    ProductDataSource *product = [productArray objectAtIndex:indexPath.row];
//    ProductTableViewCell *cell = [ProductTableViewCell createCellWithTableView:tableView];
//    [cell loadData:product];
    return cell;
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
