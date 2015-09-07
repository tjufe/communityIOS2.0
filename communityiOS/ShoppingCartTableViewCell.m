//
//  ShoppingCartTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

#pragma mark-----选中一个section的商品-----
- (IBAction)Btn2selectComm:(id)sender {
    //调用代理
    if([self.delegate respondsToSelector:@selector(selectCommInSection:)]){
        [self.delegate selectCommInSection:self];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSel_status:(int)sel_status{
    _sel_status = sel_status;
    if(sel_status==1){
        _img_select_shop.image = [UIImage imageNamed:@"选择"];
    }else{
        _img_select_shop.image = [UIImage imageNamed:@"未选择"];
    }
}

@end
