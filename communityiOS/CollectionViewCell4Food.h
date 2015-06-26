//
//  CollectionViewCell4Food.h
//  communityiOS
//
//  Created by 何茂馨 on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell4Food : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CommMainPic;
@property (weak, nonatomic) IBOutlet UILabel *CommName;
@property (weak, nonatomic) IBOutlet UILabel *CommUnit;
@property (weak, nonatomic) IBOutlet UILabel *CommPrice;
@property (weak, nonatomic) IBOutlet UIButton *Add2Cart;
- (IBAction)Add2CartOnClick:(id)sender;

@property(weak ,nonatomic) NSString *comm_main_pic;
@property(weak ,nonatomic) NSString *Comm_name;
@property(weak ,nonatomic) NSString *comm_unit;
@property(weak ,nonatomic) NSString *comm_price;


@end
