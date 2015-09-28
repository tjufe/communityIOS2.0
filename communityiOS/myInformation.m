//
//  myInformation.m
//  communityiOS
//
//  Created by tjufe on 15/9/22.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "myInformation.h"

@implementation myInformation


+(myInformation *)createItemWitparametes:(NSDictionary*)dic{
    
    myInformation * my_info = [myInformation new];
    [KZPropertyMapper mapValuesFrom:dic toInstance:my_info usingMapping:[myInformation mapDictionary]];
    return my_info;
}
+ (NSDictionary*)mapDictionary
{
    return @{
             @"message_id":@"message_id",
             @"group_id":@"group_id",
             @"send_member":@"send_member",
             @"content":@"content",
             @"image":@"image",
             @"title":@"title",
             @"create_time":@"create_time",
             @"send_time":@"send_time",
             @"state":@"state",
             @"deleted":@"deleted",
             @"member_name":@"member_name",
             @"member_head":@"member_head",
             @"group_name":@"group_name"
            };
}


@end
