//
//  ShopUserInfo.h
//  communityiOS
//
//  Created by lx on 15/6/19.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//  商家信息

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"



@interface ShopUserInfo : NSObject

@property (strong,nonatomic) NSString *community_id;
@property (strong,nonatomic) NSString *shop_user_id;//商家id
@property (strong,nonatomic) NSString *shop_user_name;//商家名称
@property (strong,nonatomic) NSString *shop_pass;//商家用户登录密码
@property (strong,nonatomic) NSString *shop_master;//商家负责人姓名
@property (strong,nonatomic) NSString *shop_phone;//联系电话
@property (strong,nonatomic) NSString *shop_address;//商家地址
@property (strong,nonatomic) NSString *shop_auth;//是否认证
@property (strong,nonatomic) NSString *shop_regdate;//注册时间
@property (strong,nonatomic) NSString *shop_idcard;//认证文凭
@property (strong,nonatomic) NSString *shop_desc;//商家描述介绍
@property (strong,nonatomic) NSString *shop_photo;//商家主图
@property (strong,nonatomic) NSString *shop_icon;//商家商标
@property (strong,nonatomic) NSString *shop_notice;//商家gonggao
@property (assign,nonatomic) int shop_sequence;//排列序号
@property (assign,nonatomic) int commodity_num;//在卖商品数量
@property (assign,nonatomic) int estimate_num;//商家评价数


+(ShopUserInfo *)initWithparametes:(NSDictionary*)dic;


@end
