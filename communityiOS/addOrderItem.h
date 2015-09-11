//
//  addOrderItem.h
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"

@interface addOrderItem : NSObject

@property (nonatomic,copy)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSString *mainorder_id;//主订单id

+(addOrderItem *)createItemWitparametes:(NSDictionary*)dic;



@end


//用于返回插入订单结果