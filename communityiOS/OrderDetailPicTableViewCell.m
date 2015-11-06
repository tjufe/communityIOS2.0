//
//  OrderDetailPicTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderDetailPicTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"


@implementation OrderDetailPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark----依次给图片赋值-----
-(void)setImg_comm1_url:(NSString *)img_comm1_url{
    if(img_comm1_url!=nil&&![img_comm1_url isEqual:@""]){
        NSString *img_url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,img_comm1_url];
    
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[img_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if([img_comm1_url isEqualToString:@"loading"]){
            self.img_comm1.image = [UIImage imageNamed:@"loading"];
        }else{
            [self.img_comm1 sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.img_comm1.image = image;
            }];
        }
    }else{
        _img_comm1.image = [UIImage imageNamed:@"loading"];

    }
    self.img_comm1.contentMode=UIViewContentModeScaleAspectFill;
    
    
}

-(void)setImg_comm2_url:(NSString *)img_comm2_url{
    if(img_comm2_url!=nil&&![img_comm2_url isEqual:@""]){

        NSString *img_url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,img_comm2_url];
    
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[img_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if([img_comm2_url isEqualToString:@"loading"]){
            self.img_comm2.image = [UIImage imageNamed:@"loading"];
        }else{
            [self.img_comm2 sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.img_comm2.image = image;
            }];
        }
    }else{
        self.img_comm2.image = [UIImage imageNamed:@"商家小图"];
    }
    
    self.img_comm2.contentMode=UIViewContentModeScaleAspectFill;
    
    
}

-(void)setImg_comm3_url:(NSString *)img_comm3_url{
    if(img_comm3_url!=nil&&![img_comm3_url isEqual:@""]){

        NSString *img_url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,img_comm3_url];
    
        //包含中文字符的string转换为nsurl
            NSURL *iurl = [NSURL URLWithString:[img_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if([img_comm3_url isEqualToString:@"loading"]){
            self.img_comm3.image = [UIImage imageNamed:@"loading"];
        }else{
            [self.img_comm3 sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.img_comm3.image = image;
            }];
        }
    }else{
        self.img_comm3.image = [UIImage imageNamed:@"商家小图"];

    }
    
    self.img_comm3.contentMode=UIViewContentModeScaleAspectFill;
}

@end
