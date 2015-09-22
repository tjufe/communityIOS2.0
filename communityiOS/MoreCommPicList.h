//
//  MoreCommPicList.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/16.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusTool.h"

@interface MoreCommPicList : NSObject
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property(strong ,nonatomic)NSArray * MoreCommPicList;

+(MoreCommPicList *)initWithparametes:(NSDictionary *)dic;
+(void)LoadMoreCommPicWithCommID:(NSString *)comm_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure;

@end
