//
//  CommodityInfo.h
//  communityiOS
//
//  Created by lx on 15/6/23.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//  商品信息

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"


@interface CommodityInfo : NSObject

@property (strong,nonatomic) NSString *commodity_id;
@property (strong,nonatomic) NSString *comm_name;
@property (strong,nonatomic) NSString *comm_unit; //商品单位
@property (assign,nonatomic) float comm_price;
@property (strong,nonatomic) NSString *comm_state; //商品状态：上架、下架、删除
@property (strong,nonatomic) NSString *comm_regdate; //商品登记时间
@property (strong,nonatomic) NSString *comm_desc;  //商品描述
@property (strong,nonatomic) NSString *comm_photo;
@property (assign,nonatomic) int comm_sequence;//排列序号
@property (strong,nonatomic) NSString *shop_id; //商家id

+(CommodityInfo *)initWithparametes:(NSDictionary*)dic;

@end
