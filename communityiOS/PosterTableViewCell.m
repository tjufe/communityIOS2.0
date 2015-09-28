//
//  PosterTableViewCell.m
//  communityiOS
//
//  Created by tjufe on 15/3/31.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "PosterTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation PosterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPosterImage:(UIImageView *)posterImage{
   
       posterImage.layer.masksToBounds = YES;
        [posterImage.layer setCornerRadius:posterImage.layer.frame.size.height/4];
        
  

}
//wangyao0922重用 它显示消息详情信息
-(void)setSend_date:(NSString *)send_date{
    if (send_date!=nil) {
         [_postDate setText:send_date];
    }
   

}
-(void)setMember_head:(NSString *)member_head{
    if(![member_head isEqual:@""]&&member_head!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,member_head];
        
        //包含中文字符的string转换为nsurl
        NSURL *iurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        [_headPortrait sd_setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _headPortrait.image = image;
            
        }];
    }else{
        
        _headPortrait.image = [UIImage imageNamed:@"默认小头像"];
        
    }
    

}
-(void)setMember_name:(NSString *)member_name{

    if (member_name!=nil) {
        [_posterNickname setText:member_name];
    }
    
}


@end
