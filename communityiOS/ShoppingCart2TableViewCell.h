//
//  ShoppingCart2TableViewCell.h
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartCommodity.h"

@protocol ShoppingCart2TableViewCellDelegate <NSObject>

-(void)selectComm:(UITableViewCell *)cell;//选中商品
-(void)changeAmount:(UITableViewCell *)cell Flag:(int)tag;//改变商品数量

@end


@interface ShoppingCart2TableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *img_select_comm;

@property (weak, nonatomic) IBOutlet UIImageView *img_comm_photo;
@property (weak, nonatomic) IBOutlet UILabel *label_comm_name;
@property (weak, nonatomic) IBOutlet UILabel *label_comm_price;
@property (weak, nonatomic) IBOutlet UILabel *label_comm_amount;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_add;
@property(strong,nonatomic)NSString *comm_url;




//标记值
@property (strong,nonatomic) ShoppingCartCommodity *comm;
@property (assign)id <ShoppingCart2TableViewCellDelegate>delegate;
@end


