//
//  Estimatelist.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "Estimatelist.h"
#import "HttpTool.h"
#import "EstimateInfo.h"

@implementation Estimatelist

+(Estimatelist *)initWithparametes:(NSDictionary *)dic{
    Estimatelist *estimate_list = [Estimatelist new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:estimate_list usingMapping:[Estimatelist mapDictionary]];
    return estimate_list;
}
+(NSDictionary *)mapDictionary{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"EstimateList":@"EstimateList"
                     
                     }
             
             };
}

+(void)LoadEstimateListWithShopID:(NSString *)shop_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:shop_id forKey:@"shop_id"];
    [firstDic setValue:page forKey:@"page"];
    [firstDic setValue:rows forKey:@"rows"];
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"LoadEstimateList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         Estimatelist *list = [Estimatelist initWithparametes:dic];
                         NSMutableArray *ListArray = [NSMutableArray array];
                         for(NSDictionary *dic in list.EstimateList ){
                             EstimateInfo *estimate_info = [EstimateInfo initWithparametes:dic];
                             [ListArray addObject:estimate_info];
                         }
                         success(ListArray);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];







}


@end
