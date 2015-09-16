//
//  CollectionViewCell4Food.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "CollectionViewCell4Food.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation CollectionViewCell4Food

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)Add2CartOnClick:(id)sender {
    
    
}

-(void)setComm_main_pic:(NSString *)comm_main_pic{

    if(![comm_main_pic isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,comm_main_pic];
        
        [_CommMainPic sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CommMainPic.image = image;
            
        }];
    }else{
        
        _CommMainPic.image = [UIImage imageNamed:@"商家小图"];
        
    }


}
-(void)setComm_name:(NSString *)Comm_name{
    [_CommName setText:Comm_name];

}

-(void)setComm_unit:(NSString *)comm_unit{
    [_CommUnit setText:comm_unit];
}


-(void)setComm_price:(double)comm_price{

    [_CommPrice setText:[NSString stringWithFormat:@"%.2f",comm_price]];
}


@end
