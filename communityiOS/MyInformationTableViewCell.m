//
//  MyInformationTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MyInformationTableViewCell.h"

@implementation MyInformationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo_title:(NSString *)info_title{
    if (info_title!=nil) {
         [_InfoTitle setText:info_title];
    }
   
}
-(void)setRead_state:(NSString *)read_state{
    if ([read_state isEqualToString:@"已读"]) {
        [_ReadState setText:read_state];
    }else{
        [_ReadState setText:@"未读"];
        [_ReadState setTextColor:[UIColor redColor]];
    }
    
}
-(void)setSend_group:(NSString *)send_group{
    if (send_group!=nil) {
         [_SendGroup setText:send_group];
    }
   

}
-(void)setSend_time:(NSString *)send_time{
    if (send_time!=nil) {
        [_SendTime setText:send_time];
    }

}

@end
