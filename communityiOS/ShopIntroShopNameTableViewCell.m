//
//  ShopIntroShopNameTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopIntroShopNameTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation ShopIntroShopNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setShopmainpic:(NSString *)shop_main_url{
    if(![shop_main_url isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,shop_main_url];
        
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        [_ShopPhoto sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _ShopPhoto.image = image;
            
        }];
    }else{
        
        _ShopPhoto.image = [UIImage imageNamed:@"loading"];
        
    }
    
    
}

@end
