//
//  CommSales.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KZPropertyMapper.h"

@interface CommSales : NSObject

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

//@property (nonatomic,assign)long *comm_sales;
@property (nonatomic,assign)int comm_sales;

+(CommSales *)createItemWitparametes:(NSDictionary*)dic;

@end
