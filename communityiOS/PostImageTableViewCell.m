//
//  PostImageTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/3/31.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "PostImageTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation PostImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMain_image:(NSString *)main_image{
    if(![main_image isEqual:@""]&&main_image!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,main_image];
        
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        [_MainImage sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _MainImage.image = image;
            
        }];
    }else{
        
        _MainImage.image = [UIImage imageNamed:@"loading"];
        
    }

}

@end
