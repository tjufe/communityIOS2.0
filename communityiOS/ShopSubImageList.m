//
//  ShopSubImageList.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopSubImageList.h"
#import "KZPropertyMapper.h"
#import "HttpTool.h"


@implementation ShopSubImageList

+(ShopSubImageList *)initWithparametes:(NSDictionary *)dic{
    ShopSubImageList *list = [ShopSubImageList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[ShopSubImageList mapDictionary]];
    
    return list;
}
+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"urlList":@"urlList"
                     
                     }
             };
    
}

+(void)LoadShopSubImageWithShopID:(NSString *)shop_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:shop_id forKey:@"shop_id"];
    
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"GetShopPhotoList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         ShopSubImageList *list = [ShopSubImageList initWithparametes:dic];
                         //                         NSMutableArray *ListArray = [NSMutableArray array];
                         //                         for(NSDictionary *dic in list.MainOrderList ){
                         //                             OrderInfo *order_info = [OrderInfo initWithparametes:dic];
                         //                             [ListArray addObject:order_info];
                         //                         }
                         success(list.urlList);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];
    
    
    
    
}



@end
