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

-(void)setShop_head_url:(NSString *)shop_head_url{
    if(shop_head_url!=nil&&![shop_head_url isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,shop_head_url];
        
        [_ShopHead sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            if (image!=nil) {
                _ShopHead.image = image;
            }else{
                _ShopHead.image = [UIImage imageNamed:@"默认小头像"];
            }
            
            
        }];
    }else{
        
        _ShopHead.image = [UIImage imageNamed:@"默认小头像"];
        
    }
    [_ShopHead.layer setCornerRadius:_ShopHead.layer.frame.size.height/2];
    _ShopHead.contentMode=UIViewContentModeScaleAspectFill;
    _ShopHead.layer.masksToBounds = YES;
}

-(void)setShop_name:(NSString *)shop_name{
    _ShopName.text = shop_name;
}
    


-(void)setComm_pic1_url:(NSString *)comm_pic1_url{
    if(comm_pic1_url!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic1_url];
        
        [_CommPic1 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic1.image = image;
            
        }];
    }else{
        
        _CommPic1.image = [UIImage imageNamed:@"loading"];
        
    }

}
    

-(void)setComm_pic2_url:(NSString *)comm_pic2_url{
    if(comm_pic2_url!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic2_url];
        
        [_CommPic2 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic2.image = image;
            
        }];
    }else{
        
        _CommPic2.image = [UIImage imageNamed:@"loading"];
        
    }

    

}

-(void)setComm_pic3_url:(NSString *)comm_pic3_url{
    if(comm_pic3_url!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic3_url];
        
        [_CommPic3 sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic3.image = image;
            
        }];
    }else{
        
        _CommPic3.image = [UIImage imageNamed:@"loading"];
        
    }
    

    
}
-(void)setOrder_price:(NSString *)order_price{
    _OrderPrice.text=order_price;

}
-(void)setOrder_state:(NSString *)order_state{

    _OrderState.text = order_state;
}


//- (IBAction)OrderDeleteOnclick:(id)sender {
//}
//- (IBAction)toEstimateOnclick:(id)sender {
//}
@end
