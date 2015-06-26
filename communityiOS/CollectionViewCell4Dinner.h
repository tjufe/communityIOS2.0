//
//  CollectionViewCell4Dinner.h
//  communityiOS
//
//  Created by 何茂馨 on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell4Dinner : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shop_main_pic;
@property (weak, nonatomic) IBOutlet UILabel *shop_introduce;
@property (weak, nonatomic) IBOutlet UILabel *food_num;
@property (weak, nonatomic) IBOutlet UILabel *reply_num;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;

@property (weak, nonatomic)  NSString *Shopmainpic;
@property (weak, nonatomic)  NSString *Shopintroduce;
@property (weak, nonatomic)  NSString *Foodnum;
@property (weak, nonatomic)  NSString *Replynum;
@property (weak, nonatomic)  NSString *Shopname;

@end
