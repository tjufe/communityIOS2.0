//
//  getUserNameItem.h
//  communityiOS
//
//  Created by tjufe on 15/9/8.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getUserNameItem : NSObject

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSString *user_name;
@property (nonatomic,strong)NSString *user_address;


+(getUserNameItem *)createItemWitparametes:(NSDictionary*)dic;


@end
