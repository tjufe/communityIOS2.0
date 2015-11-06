//
//  MoreCommPicTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/16.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MoreCommPicTableViewCell.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation MoreCommPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMore_comm_pic:(NSString *)more_comm_pic{

    if (more_comm_pic!=nil&&![more_comm_pic isEqualToString:@""]) {
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,more_comm_pic];
        
        [_MoreCommPic sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _MoreCommPic.image = image;
            
        }];
    }else{
        
        _MoreCommPic.image = [UIImage imageNamed:@"loading"];
        
    }
    

}

@end
