//
//  ViewController4Food.h
//  communityiOS
//
//  Created by 何茂馨 on 15/6/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController4Food : UIViewController


-(void)getShopName:(NSString *)shop_name;
-(void)getShopID:(NSString *) shop_id ;
-(void)getShopIcon:(NSString *) shop_icon_url;
-(void)getEstimateNum:(int) estimate_num;

@property (weak, nonatomic) IBOutlet UILabel *ShopName;
@property (weak, nonatomic) IBOutlet UIImageView *ShopIcon;
@property (weak, nonatomic) IBOutlet UILabel *ReplyNum;
@property (strong ,nonatomic)NSString *shop_phone;

@end
