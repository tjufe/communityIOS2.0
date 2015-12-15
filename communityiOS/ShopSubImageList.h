//
//  ShopSubImageList.h
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusTool.h"
@interface ShopSubImageList : NSObject
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic,strong)NSDictionary *data;

@property(strong ,nonatomic)NSArray * urlList;

+(ShopSubImageList *)initWithparametes:(NSDictionary *)dic;
+(void)LoadShopSubImageWithShopID:(NSString *)shop_id Success:(StatusSuccess)success failurs:(StatusFailurs)failure;

@end
