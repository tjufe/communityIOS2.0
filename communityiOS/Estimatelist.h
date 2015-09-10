//
//  Estimatelist.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"
#import "StatusTool.h"

@interface Estimatelist : NSObject
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property (nonatomic,strong)NSArray *EstimateList;

+(Estimatelist *)initWithparametes:(NSDictionary*)dic;

//加载商家信息列表
+ (void)LoadEstimateListWithShopID:(NSString *)shop_id  page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure;



@end
