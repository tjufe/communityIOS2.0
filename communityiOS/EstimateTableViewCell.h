//
//  EstimateTableViewCell.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/9.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstimateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CustHead;
@property (weak, nonatomic) IBOutlet UILabel *CustName;
@property (weak, nonatomic) IBOutlet UILabel *EstimateTime;
@property (weak, nonatomic) IBOutlet UIImageView *EstimateStar;
@property (weak, nonatomic) IBOutlet UIImageView *EstimateStar2;
@property (weak, nonatomic) IBOutlet UIImageView *EstimateStar3;
@property (weak, nonatomic) IBOutlet UIImageView *EstimateStar4;
@property (weak, nonatomic) IBOutlet UIImageView *EstimateStar5;
@property (weak, nonatomic) IBOutlet UILabel *EstimateContent;
@property (weak, nonatomic) IBOutlet UILabel *BuyDate;

-(void)MakeCustHead:(NSString *)CustHead;
-(void)MakeCustName:(NSString *)CustName;
-(void)MakeEstimateTime:(NSString *)EstimateTime;
-(void)MakeEstimateContent:(NSString *)EstimateContent;
-(void)MakeBuyDate:(NSString *)BuyDate;

@end
