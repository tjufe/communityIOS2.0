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
    if(![CustHead isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,CustHead];
        
        [_CustHead sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            _CustHead.image = image;
            
        }];
    }else{
        
        _CustHead.image = [UIImage imageNamed:@"商家小图"];
        
    }


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
