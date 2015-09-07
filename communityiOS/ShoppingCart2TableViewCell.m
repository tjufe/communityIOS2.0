//
//  ShoppingCart2TableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShoppingCart2TableViewCell.h"

@implementation ShoppingCart2TableViewCell

#pragma mark------ 选中商品 --------
- (IBAction)Button2Select:(id)sender {
    //调用代理
    if ([self.delegate
         respondsToSelector:@selector(selectComm:)]) {
        [self.delegate selectComm:self];
    }
}

#pragma mark------ 减少商品数量 --------
- (IBAction)BtnClick2deleteComm:(id)sender {
    //调用代理
    if([self.delegate respondsToSelector:@selector(changeAmount:Flag:)]){
        [self.delegate changeAmount:self Flag:(int)_btn_delete.tag];
    }
}

#pragma mark------ 增加商品数量 --------
- (IBAction)BtnClick2addComm:(id)sender {
    
    //调用代理
    if([self.delegate respondsToSelector:@selector(changeAmount:Flag:)]){
        [self.delegate changeAmount:self Flag:(int)_btn_add.tag];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setComm:(ShoppingCartCommodity *)comm{
    _comm = comm;
    if(comm.select_status==1){
        _img_select_comm.image = [UIImage imageNamed:@"选择"];
    }else{
        _img_select_comm.image = [UIImage imageNamed:@"未选择"];
    }
}

@end
