//
//  OrderDetailAddressTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderDetailAddressTableViewCell.h"


@implementation OrderDetailAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setL_address:(NSString *)l_address{

    [_label_address setText:l_address];

}
-(void)setL_name:(NSString *)l_name{

    [_label_name setText:l_name];
}
-(void)setL_phone:(NSString *)l_phone{

    [_label_phone setText:l_phone];
}

@end
