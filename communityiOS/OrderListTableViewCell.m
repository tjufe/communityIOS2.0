//
//  OrderListTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderListTableViewCell.h"

#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopHead:(NSString *)ShopHead{
    if(![ShopHead isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,ShopHead];
        
        [_ShopHead sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _ShopHead.image = image;
            
        }];
    }else{
        
        _ShopHead.image = [UIImage imageNamed:@"商家小图"];
        
    }


}

-(void)setShopName:(NSString *)shop_name{
    [_ShopName setText:shop_name];
    
}

-(void)setCommPic1:(NSString *)comm_pic1{
    if(![comm_pic1 isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic1];
        
        [_CommPic1 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic1.image = image;
            
        }];
    }else{
        
        _CommPic1.image = [UIImage imageNamed:@"商家小图"];
        
    }

}
-(void)setCommPic2:(NSString *)comm_pic2{
    if(![comm_pic2 isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic2];
        
        [_CommPic2 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic2.image = image;
            
        }];
    }else{
        
        _CommPic2.image = [UIImage imageNamed:@"商家小图"];
        
    }


}

-(void)setCommPic3:(NSString *)comm_pic3{
    if(![comm_pic3 isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic3];
        
        [_CommPic3 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic3.image = image;
            
        }];
    }else{
        
        _CommPic3.image = [UIImage imageNamed:@"商家小图"];
        
    }
    
    
}
-(void)setOrderPrice:(NSString *)OrderPrice{
    [_OrderPrice setText:OrderPrice];

}


- (IBAction)OrderDeleteOnclick:(id)sender {
}
- (IBAction)toEstimateOnclick:(id)sender {
}
@end
