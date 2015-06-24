//
//  ShopUserList.h
//  communityiOS
//
//  Created by lx on 15/6/19.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//  商家信息列表

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"
#import "StatusTool.h"

@interface ShopUserList : NSObject

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property (nonatomic,strong)NSArray *ShopUserList;


+(ShopUserList *)initWithparametes:(NSDictionary*)dic;

//加载商家信息列表
+ (void)LoadShopUserListWithCommunityID:(NSString *)community_id  page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure;


@end
