//
//  ShopUserList.m
//  communityiOS
//
//  Created by tjufe on 15/6/19.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopUserList.h"
#import "HttpTool.h"
#import "ShopUserInfo.h"


@implementation ShopUserList

+(ShopUserList *)initWithparametes:(NSDictionary *)dic{
    
    ShopUserList *list = [ShopUserList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[ShopUserList mapDictionary]];
    
    return list;
}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"ShopUserList":@"ShopUserList"
                     
                     }
             };
    
}

+(void)LoadShopUserListWithCommunityID:(NSString *)community_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:community_id forKey:@"community_id"];
    [firstDic setValue:page forKey:@"page"];
    [firstDic setValue:rows forKey:@"rows"];
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"LoadShopList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         ShopUserList *list = [ShopUserList initWithparametes:dic];
                         NSMutableArray *ListArray = [NSMutableArray array];
                         for(NSDictionary *dic in list.ShopUserList ){
                             ShopUserInfo *shopuser_info = [ShopUserInfo initWithparametes:dic];
                             [ListArray addObject:shopuser_info];
                         }
                         success(ListArray);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];
    
    
}

@end
