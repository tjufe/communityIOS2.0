//
//  Detail4FoodViewController.h
//  communityiOS
//
//  Created by 何茂馨 on 15/6/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityInfo.h"

@interface Detail4FoodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *IntoShopBt;
- (IBAction)IntoShopOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CallSellerBt;
- (IBAction)CallSellerOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBt;
- (IBAction)BuyNowOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *MorePicBt;

- (IBAction)MorePicOnclick:(id)sender;

-(void)getCommodityInfo:(id)comm_info;

@property (weak, nonatomic) IBOutlet UILabel *CommName;
@property (weak, nonatomic) IBOutlet UILabel *CommDescribe;
@property (weak, nonatomic) IBOutlet UILabel *CommSales;
@property (weak, nonatomic) IBOutlet UILabel *CommUnit;
@property (weak, nonatomic) IBOutlet UILabel *CommPrice;
@property (weak, nonatomic) IBOutlet UIImageView *CommImage;

@property(nonatomic,strong)CommodityInfo *comm_info;//商品信息
@property(nonatomic,strong)NSString *shop_name;//商家名称
@property (nonatomic,strong)NSString *shop_phone;

@end
