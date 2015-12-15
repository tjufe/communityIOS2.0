//
//  ShopIntroMainImageTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopIntroMainImageTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation ShopIntroMainImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMainImage:(NSString *)main_image_url{
    
    if (main_image_url!=nil&&![main_image_url isEqualToString:@""]) {
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,main_image_url];
        
        [_ShopIcon sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _ShopIcon.image = image;
            
        }];
    }else{
        
        _ShopIcon.image = [UIImage imageNamed:@"loading"];
        
    }
    
    
}

@end
