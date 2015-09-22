//
//  ShoppingCart2TableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShoppingCart2TableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"


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
-(void)setComm_url:(NSString *)comm_url{
    if(![comm_url isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_url];
        
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        [_img_comm_photo sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _img_comm_photo.image = image;
            
        }];
    }else{
        
        _img_comm_photo.image = [UIImage imageNamed:@"商家小图"];
        
    }

}

@end
