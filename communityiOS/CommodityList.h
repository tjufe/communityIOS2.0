//
//  CommodityList.h
//  communityiOS
//
//  Created by tjufe on 15/6/23.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"
#import "StatusTool.h"

@interface CommodityList : NSObject

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property (nonatomic,strong)NSArray *CommodityList;


+(CommodityList *)initWithparametes:(NSDictionary*)dic;

//加载商品信息列表
+ (void)LoadCommodityListWithShopID:(NSString *)shop_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure;



@end
