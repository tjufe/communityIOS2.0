//
//  CollectionViewCell4Dinner.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "CollectionViewCell4Dinner.h"
#import "ShopUserInfo.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation CollectionViewCell4Dinner

- (void)awakeFromNib {
    // Initialization code
}

//-(void)setValueForFrame:(ShopUserInfo *)shop_user_info{
//    
//    [self.food_num setText:[NSString stringWithFormat:@"%d",shop_user_info.commodity_num]];
//    [self.reply_num setText:[NSString stringWithFormat:@"%d",shop_user_info.estimate_num]];
//}

-(void)setShopmainpic:(NSString *)shop_main_url{
    if(![shop_main_url isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,shop_main_url];
        
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        
        [_shop_main_pic sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _shop_main_pic.image = image;
            
        }];
    }else{
    
        _shop_main_pic.image = [UIImage imageNamed:@"商家小图"];
    
    }


}

-(void)setShopname:(NSString *)shopname{
    
    _shop_name.text = shopname;
    
}

-(void)setShopintroduce:(NSString *)shopintroduce{
    
    _shop_introduce.text = shopintroduce;
}

-(void)setFoodnum:(NSString *)foodnum{
    _food_num.text = foodnum;
}

-(void)setReplynum:(NSString *)replynum{
    
    _reply_num.text = replynum;
}



@end
