//
//  OrderDetailZhifuTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderDetailZhifuTableViewCell.h"

@implementation OrderDetailZhifuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setL_send_date:(NSString *)l_send_date{
    
    [_label_send_date setText:l_send_date];

}

@end
