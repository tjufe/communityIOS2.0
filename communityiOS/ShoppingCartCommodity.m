//
//  ShoppingCartCommodity.m
//  communityiOS
//
//  Created by lx on 15/6/25.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShoppingCartCommodity.h"

@implementation ShoppingCartCommodity

-(id)initWithCoder:(NSCoder *)coder{
    
    if(self=[super init]){
        
        _commodity_id = [coder decodeObjectForKey:@"commodity_id"];
        _comm_name = [coder decodeObjectForKey:@"comm_name"];
        _comm_price = [coder decodeDoubleForKey:@"comm_price"];
        _comm_unit = [coder decodeObjectForKey:@"comm_unit"];
        _comm_photo = [coder decodeObjectForKey:@"comm_photo"];
        _buy_amount = [coder decodeDoubleForKey:@"buy_amount"];
        _shop_name = [coder decodeObjectForKey:@"shop_name"];
        _shop_id = [coder decodeObjectForKey:@"shop_id"];
        _select_status = [coder decodeInt32ForKey:@"select_status"];
        _shop_phone = [coder decodeObjectForKey:@"shop_phone"];
        
        
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_commodity_id forKey:@"commodity_id"];
    [coder encodeObject:_comm_name forKey:@"comm_name"];
    [coder encodeDouble:_comm_price forKey:@"comm_price"];
    [coder encodeObject:_comm_unit forKey:@"comm_unit"];
    [coder encodeObject:_comm_photo forKey:@"comm_photo"];
    [coder encodeDouble:_buy_amount forKey:@"buy_amount"];
    [coder encodeObject:_shop_name forKey:@"shop_name"];
    [coder encodeObject:_shop_id forKey:@"shop_id"];
    [coder encodeInt32:_select_status forKey:@"select_status"];
    [coder encodeObject:_shop_phone forKey:@"shop_phone"];
    
    
}

@end
