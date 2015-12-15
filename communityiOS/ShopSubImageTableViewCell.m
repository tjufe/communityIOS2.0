//
//  ShopSubImageTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopSubImageTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation ShopSubImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setShop_sub_image:(NSString *)shop_sub_image{
    
    if (shop_sub_image!=nil&&![shop_sub_image isEqualToString:@""]) {
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,shop_sub_image];
        
        [_ShopSubImage sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _ShopSubImage.image = image;
            
        }];
    }else{
        
        _ShopSubImage.image = [UIImage imageNamed:@"loading"];
        
    }
    
    
}



@end
