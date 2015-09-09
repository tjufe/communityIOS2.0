//
//  OrderDetailPicTableViewCell.h
//  communityiOS
//
//  Created by 何茂馨 on 15/8/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailPicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_comm1;
@property (weak, nonatomic) IBOutlet UIImageView *img_comm2;
@property (weak, nonatomic) IBOutlet UIImageView *img_comm3;
@property (weak, nonatomic) IBOutlet UILabel *label_over;
@property (weak, nonatomic) IBOutlet UILabel *label_comm_amount;

@property (weak,nonatomic) NSString *img_comm1_url;
@property (weak,nonatomic) NSString *img_comm2_url;
@property (weak,nonatomic) NSString *img_comm3_url;


@end
