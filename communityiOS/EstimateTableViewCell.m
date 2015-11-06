//
//  EstimateTableViewCell.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "EstimateTableViewCell.h"

#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "AppDelegate.h"

@implementation EstimateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)MakeCustHead:(NSString *)CustHead{
    if(![CustHead isEqual:@""]&&CustHead!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,CustHead];
        _CustHead.image = [UIImage imageNamed:@"默认小头像"];
        [_CustHead sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"默认小头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            if (image!=nil) {
                 _CustHead.image = image;
            }else{
                _CustHead.image = [UIImage imageNamed:@"默认小头像"];

            }
           
       
            
        }];
    }else{
        
        _CustHead.image = [UIImage imageNamed:@"默认小头像"];
        
    }
    [_CustHead.layer setCornerRadius:_CustHead.layer.frame.size.height/2];
    _CustHead.contentMode=UIViewContentModeScaleAspectFill;
    _CustHead.layer.masksToBounds = YES;


}
-(void)MakeCustName:(NSString *)CustName{

    [_CustName setText:CustName];

}
-(void)MakeEstimateTime:(NSString *)EstimateTime{

    [_EstimateTime setText:EstimateTime];

}
-(void)MakeEstimateContent:(NSString *)EstimateContent{
    [_EstimateContent setText:EstimateContent];

}
-(void)MakeBuyDate:(NSString *)BuyDate{
    [_BuyDate setText:BuyDate];
}

@end
