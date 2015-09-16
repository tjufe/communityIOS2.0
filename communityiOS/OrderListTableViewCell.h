//
//  OrderListTableViewCell.h
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ShopHead;
@property (weak, nonatomic) IBOutlet UILabel *ShopName;
@property (weak, nonatomic) IBOutlet UIImageView *CommPic1;
@property (weak, nonatomic) IBOutlet UIImageView *CommPic2;
@property (weak, nonatomic) IBOutlet UIImageView *CommPic3;
@property (weak, nonatomic) IBOutlet UIImageView *CommPicMore;

@property (weak, nonatomic) IBOutlet UILabel *OrderPrice;
@property (weak, nonatomic) IBOutlet UIButton *OrderDeleteBt;
- (IBAction)OrderDeleteOnclick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *toEstimateBt;
- (IBAction)toEstimateOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *OrderState;

@property (strong,nonatomic) NSString *order_price;
@property (strong,nonatomic) NSString *comm_pic3_url;
@property (strong,nonatomic) NSString *comm_pic2_url;
@property (strong,nonatomic) NSString *comm_pic1_url;
@property (strong,nonatomic) NSString *shop_name;
@property (strong,nonatomic) NSString *shop_head_url;
@property (strong,nonatomic) NSString *order_state;
@end
