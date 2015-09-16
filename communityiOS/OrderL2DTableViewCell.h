//
//  OrderL2DTableViewCell.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/15.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderL2DTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CommPic;
@property (weak, nonatomic) IBOutlet UILabel *CommName;

@property(strong ,nonatomic)NSString *comm_pic_url;
@property (strong , nonatomic)NSString *comm_name;
@property (weak, nonatomic) IBOutlet UILabel *OrderDate;
@property (strong,nonatomic)NSString *order_date;
@property (weak, nonatomic) IBOutlet UILabel *CommPrice;
@property (weak, nonatomic) IBOutlet UILabel *BuyCount;
@property (weak, nonatomic) IBOutlet UILabel *CommUnit;

@property (strong,nonatomic)NSString *comm_price;
@property (strong,nonatomic)NSString *buy_count;
@property (strong,nonatomic)NSString *comm_unit;



@end
