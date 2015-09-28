//
//  myInformation.h
//  communityiOS
//
//  Created by tjufe on 15/9/22.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"

@interface myInformation : NSObject

@property (strong,nonatomic) NSString *message_id;
@property (strong,nonatomic) NSString *group_id;//商家id
@property (strong,nonatomic) NSString *send_member;//商家名称
@property (strong,nonatomic) NSString *content;//商家用户登录密码
@property (strong,nonatomic) NSString *image;//商家负责人姓名
@property (strong,nonatomic) NSString *title;//联系电话
@property (strong,nonatomic) NSString *create_time;//商家地址
@property (strong,nonatomic) NSString *send_time;//是否认证
@property (strong,nonatomic) NSString *state;//注册时间
@property (strong,nonatomic) NSString *deleted;//认证文凭
@property (strong,nonatomic) NSString *member_name;//商家描述介绍
@property (strong,nonatomic) NSString *member_head;//商家主图
@property (strong,nonatomic) NSString *group_name;//商家主图
+(myInformation *)createItemWitparametes:(NSDictionary*)dic;

@end
