//
//  ProductTableViewCell.m
//  Tg
//
//  Created by 何苗 on 2018/3/20.
//  Copyright © 2018年 joehe. All rights reserved.
//

#import "ProductTableViewCell.h"

@interface ProductTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;
@property (weak, nonatomic) IBOutlet UILabel *subTitle3;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;


@end

@implementation ProductTableViewCell
@synthesize imageView = _imageView;

-(instancetype)createCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"www.imooc,com.tb.cell";
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)loadData {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
