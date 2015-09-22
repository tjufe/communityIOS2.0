//
//  MoreCommPicList.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/16.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MoreCommPicList.h"
#import "KZPropertyMapper.h"
#import "HttpTool.h"

@implementation MoreCommPicList

+(MoreCommPicList *)initWithparametes:(NSDictionary *)dic{
    MoreCommPicList *list = [MoreCommPicList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[MoreCommPicList mapDictionary]];
    
    return list;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"MoreCommPicList":@"MoreCommPicList"
                     
                     }
             };
    
}

+(void)LoadMoreCommPicWithCommID:(NSString *)comm_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:comm_id forKey:@"comm_id"];

    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"GetMoreCommPic" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         MoreCommPicList *list = [MoreCommPicList initWithparametes:dic];
//                         NSMutableArray *ListArray = [NSMutableArray array];
//                         for(NSDictionary *dic in list.MainOrderList ){
//                             OrderInfo *order_info = [OrderInfo initWithparametes:dic];
//                             [ListArray addObject:order_info];
//                         }
                         success(list.MoreCommPicList);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];
    
    
    
    
}


@end
