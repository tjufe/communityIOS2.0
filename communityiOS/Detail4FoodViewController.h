//
//  Detail4FoodViewController.h
//  communityiOS
//
//  Created by 何茂馨 on 15/6/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail4FoodViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *IntoShopBt;
- (IBAction)IntoShopOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *CallSellerBt;
- (IBAction)CallSellerOnclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBt;
- (IBAction)BuyNowOnclick:(id)sender;

@end
