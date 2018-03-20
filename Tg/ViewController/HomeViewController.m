//
//  HomeViewController.m
//  Tg
//
//  Created by 何苗 on 2018/3/16.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "HomeViewController.h"
#import "Util.h"
#import "CitySelectedButton.h"
#import "LoginViewController.h"
#import "CitySelectViewController.h"
#import "MyDataSource.h"
#import "ClassButton.h"
#import "ProductDataSource.h"
#import "ProductTableViewCell.h"
#import "ItemViewController.h"
#import "BusinessViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {
    LoginViewController *vc_login;
    CitySelectViewController *vc_citySelect;
    CitySelectedButton *bt_selectCity;
    NSMutableArray *productArray;
    UITableView *tableView_product;
    ItemViewController *itemVC;
    BusinessViewController *subClassVC;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateSimulateData];
    // 1 登录按钮
    UIImage* image = [UIImage imageNamed:@"login"];
    UIImage* newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * bbi_login = [[UIBarButtonItem alloc]initWithImage:newImage style:UIBarButtonItemStyleDone target:self action:@selector(loginAction)];
    
//    self.navigationItem.leftBarButtonItem = bbi_login;
//
//    // 2 二维码按钮
//    // 2.1 坐标
//    UIButton* bt_qrcode = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, 44, 44)];
//    [bt_qrcode setImage:[UIImage imageNamed:@"QR_Code"] forState:UIControlStateNormal];
//    [bt_qrcode addTarget:self action:@selector(qrcodeAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:bt_qrcode];
//    // 2.2 TODO navigationItem
    
    image = [UIImage imageNamed:@"QR_Code"];
    UIImage* qrImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *bbi_qrCode = [[UIBarButtonItem alloc]initWithImage:qrImage style:UIBarButtonItemStyleDone target:self action:@selector(qrcodeAction)];
    
    NSArray *bt_array = [[NSArray alloc]initWithObjects:bbi_login, bbi_qrCode, nil];
    self.navigationItem.leftBarButtonItems = bt_array;
    
    // 3 搜索框
    UITextField* tf_search = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100 -100, 25)];
    tf_search.backgroundColor = [UIColor whiteColor];
    tf_search.borderStyle = UITextBorderStyleNone;
    tf_search.layer.borderColor = [UIColor whiteColor].CGColor;
    tf_search.layer.cornerRadius = 25.0 / 2;
    // 3.1 UIImagesView -> leftView + PS p图 3.2 自定义 UITextField 3.3 UIImagesView -> UIView -> leftView
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"search"];
    [view addSubview:imageView];
    
    tf_search.leftView = view;
    tf_search.leftViewMode = UITextFieldViewModeAlways;
//    tf_search.delegate = self;
    
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100 - 100, 25)];
    self.navigationItem.titleView.backgroundColor = [UIColor clearColor];
    [self.navigationItem.titleView addSubview:tf_search];
    
    // 4 城市选择
    bt_selectCity = [[CitySelectedButton alloc]initWithFrame:CGRectMake(0, 0, 65, 44)];
    [bt_selectCity addTarget:self action:@selector(selectorCityAction) forControlEvents:UIControlEventTouchUpInside];
    [bt_selectCity setTitle:@"北京" forState:UIControlStateNormal];
    [bt_selectCity setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    UIBarButtonItem *bbi_selectCity = [[UIBarButtonItem alloc]initWithCustomView:bt_selectCity];
    self.navigationItem.rightBarButtonItem = bbi_selectCity;
    
    // 分类按钮
    NSArray *className = @[@"机票",@"车票",@"汽车",@"蛋糕",@"美食",@"手表",@"电脑",@"手机"];
    for (int i = 0; i < 8; i++) {
        CGRect btRect;
        CGRect imageRect;
        CGRect titleRect;
        if (i < 4) {
            btRect = CGRectMake(i*SCREEN_WIDTH/4, 75, SCREEN_WIDTH/4, 50);
        } else {
            btRect = CGRectMake((i-4)*SCREEN_WIDTH/4, 75 + 60, SCREEN_WIDTH/4, 50);
        }
        imageRect = CGRectMake((SCREEN_WIDTH/4-30)/2, 0, 30, 30);
        titleRect = CGRectMake(0, 32, SCREEN_WIDTH/4, 18);
        ClassButton *bt_class = [[ClassButton alloc]initWithFrame:btRect imageFrame:imageRect titleFrame:titleRect];
        NSString *image = [NSString stringWithFormat:@"home_class%d", i + 1];
        NSString *title = [className objectAtIndex:i];
        [bt_class setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [bt_class setTitle:title forState:UIControlStateNormal];
        [bt_class setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt_class addTarget:self action:@selector(classSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:bt_class];
    }
    
    // add tableView
    tableView_product = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200 - 44)];
    tableView_product.dataSource = self;
    tableView_product.delegate = self;
    [self.view addSubview:tableView_product];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.text = @"---大家都在团---";
    label.textColor = MYGREENCOLOR;
    tableView_product.tableHeaderView = label;
}

-(void)classSelectAction:(UIButton *)bt {
    // bt.tag
    subClassVC = [[BusinessViewController alloc]init];
    [self.navigationController pushViewController:subClassVC animated:true];
}

#pragma mark --UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return productArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"www.imooc.com.tuangou.tb";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    NSArray *array = [cityArray objectAtIndex:indexPath.section];
//    NSDictionary *dic = [array objectAtIndex:indexPath.row];
//    NSString *cityName = [dic valueForKey:@"cityName"];
//    cell.textLabel.text = cityName;
    
    ProductDataSource *product = [productArray objectAtIndex:indexPath.row];
    ProductTableViewCell *cell = [ProductTableViewCell createCellWithTableView:tableView];
    [cell loadData:product];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDataSource *itemDataSoure = [productArray objectAtIndex:indexPath.row];
    itemVC = [[ItemViewController alloc]init];
    itemVC.itemDatasource = itemDataSoure;
    [self.navigationController pushViewController:itemVC animated:true];
}

-(void)loginAction {
    if (vc_login == nil) {
        vc_login = [[LoginViewController alloc]init];
    }
    [self presentViewController:vc_login animated:true completion:nil];
}

-(void)qrcodeAction {
    
}

-(void)selectorCityAction {
    if (vc_citySelect == nil) {
        vc_citySelect = [[CitySelectViewController alloc]init];
    }
//    [self presentViewController:vc_citySelect animated:true completion:nil];
    [self.navigationController pushViewController:vc_citySelect animated:true];
}

-(void)viewWillAppear:(BOOL)animated {
    NSString *currentCityName = [[MyDataSource getInstance]getCityName];
    
    if (currentCityName == nil) {
        currentCityName = @"北京";
    }
    [bt_selectCity setTitle:currentCityName forState:UIControlStateNormal];
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

#pragma mark -- Model 模拟数据
-(void)generateSimulateData{
    NSArray *productTitle = @[@"牛排",@"地三鲜",@"松仁大虾",@"冷饮",@"牛排",@"地三鲜",@"松仁大虾",@"冷饮",@"牛排",@"地三鲜",@"松仁大虾",@"冷饮"];
    NSArray *productSubTitle1 = @[@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉",@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉",@"超值单人套餐,10分钟极速配送",@"营养搭配，科学膳食组合。",@"在这里可以尽尝各种美味",@"体验冷热酸甜想吃就是的感觉"];
    NSArray *productSubTitle2 = @[@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9",@"¥39.9",@"¥99.9",@"¥12",@"¥9.9"];
    NSArray *productSubTitle3 = @[@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢",@"新用户一元抢"];
    NSArray *productSaleNum = @[@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份",@"已售:44份",@"已售:20份",@"已售:99份",@"已售:2份"];
    
    productArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 12; i++) {
        ProductDataSource *dataSource = [[ProductDataSource alloc]init];
        NSString *image = [NSString stringWithFormat:@"product%d", i + 1];
        NSString *title = [productTitle objectAtIndex:i];
        NSString *subTitle1 = [productSubTitle1 objectAtIndex:i];
        NSString *subTitle2 = [productSubTitle2 objectAtIndex:i];
        NSString *subTitle3 = [productSubTitle3 objectAtIndex:i];
        NSString *saleNum = [productSaleNum objectAtIndex:i];
        
        dataSource.image = image;
        dataSource.title = title;
        dataSource.subtitle1 = subTitle1;
        dataSource.subtitle2 = subTitle2;
        dataSource.subtitle3 = subTitle3;
        dataSource.saleNum = saleNum;
        
        [productArray addObject:dataSource];
    }
    [[MyDataSource getInstance]setHomeData:productArray];
}


@end
