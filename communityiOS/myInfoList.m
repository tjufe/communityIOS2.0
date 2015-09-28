//
//  myInfoList.m
//  communityiOS
//
//  Created by tjufe on 15/9/22.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "myInfoList.h"
#import "HttpTool.h"
#import "myInformation.h"

@implementation myInfoList

+(myInfoList *)initWithparametes:(NSDictionary*)dic{

    myInfoList *list = [myInfoList new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:list usingMapping:[myInfoList mapDictionary]];
    
    return list;

}

+ (NSDictionary*)mapDictionary
{
    return @{
             @"status" : @"status",
             @"msg" : @"msg",
             @"data" :@{
                     @"GroupMessageList":@"GroupMessageList"
                     
                     }
             };
    
}

+(void)LoadGroupMessageListWithUserID:(NSString *)user_id page:(NSNumber *)page rows:(NSNumber *)rows Success:(StatusSuccess)success failurs:(StatusFailurs)failure{
    
    NSMutableDictionary *firstDic = [[NSMutableDictionary alloc]init];
    [firstDic setValue:user_id forKey:@"user_id"];
    [firstDic setValue:page forKey:@"page"];
    [firstDic setValue:rows forKey:@"rows"];
    
    NSMutableDictionary *secondDic = [[NSMutableDictionary  alloc] init];
    [secondDic  setValue:firstDic forKey:@"Data"];
    NSMutableDictionary *thirdDic = [[NSMutableDictionary  alloc] init];
    [thirdDic setValue:secondDic forKey:@"param"];
    [thirdDic setValue:@"LoadGroupMessageList" forKey:@"method"];
    
    [HttpTool postWithparams:thirdDic
                     success:^(id responseObject) {
                         NSData *data = [[NSData alloc] initWithData:responseObject];
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                         myInfoList *list = [myInfoList initWithparametes:dic];
                         NSMutableArray *ListArray = [NSMutableArray array];
                         for(NSDictionary *dic in list.GroupMessageList ){
                             myInformation *my_info = [myInformation createItemWitparametes:dic];
                             [ListArray addObject:my_info];
                         }
                         success(ListArray);
                         
                     } failure:^(NSError *error) {
                         if (failure == nil) return;
                         failure(error);
                     }];
    
    
}

@end
