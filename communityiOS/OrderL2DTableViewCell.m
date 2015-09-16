//
//  OrderL2DTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/15.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "OrderL2DTableViewCell.h"

#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"


@implementation OrderL2DTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setComm_name:(NSString *)comm_name{

    [_CommName setText: comm_name];
    
}

-(void)setComm_pic_url:(NSString *)comm_pic_url{
    if (comm_pic_url!=nil&&![comm_pic_url isEqualToString:@""]) {
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_pic_url];
        
        [_CommPic sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommPic.image = image;
            
        }];
    }else{
        
        _CommPic.image = [UIImage imageNamed:@"商家小图"];
        
    }

}
-(void)setOrder_date:(NSString *)order_date{

    [_OrderDate setText:order_date];
}
-(void)setComm_price:(NSString *)comm_price{

    [_CommPrice setText:comm_price];

}

-(void)setComm_unit:(NSString *)comm_unit{

    [_CommUnit setText:comm_unit];

}
-(void)setBuy_count:(NSString *)buy_count{

    [_BuyCount setText:buy_count];
}

@end
