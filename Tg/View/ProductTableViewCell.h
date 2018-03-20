//
//  ProductTableViewCell.h
//  Tg
//
//  Created by 何苗 on 2018/3/20.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDataSource.h"

@interface ProductTableViewCell : UITableViewCell

+(instancetype)createCellWithTableView:(UITableView *)tableView;
-(void)loadData:(ProductDataSource *)product;

@end
