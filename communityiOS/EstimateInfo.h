//
//  EstimateInfo.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EstimateInfo : NSObject

@property(strong,nonatomic)NSString *estimate_id;
@property(strong,nonatomic)NSString *shop_id;
@property(strong,nonatomic)NSString *user_id;
@property(strong,nonatomic)NSString *user_name;
@property(strong,nonatomic)NSString *user_head;
@property(strong,nonatomic)NSString *content;
@property(assign,nonatomic)int score;
@property(strong,nonatomic)NSString *estimate_date;
@property(strong,nonatomic)NSString *buy_date;


+(EstimateInfo *)initWithparametes:(NSDictionary*)dic;

@end
