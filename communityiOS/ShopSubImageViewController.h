//
//  ShopSubImageViewController.h
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopUserInfo.h"

@interface ShopSubImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *ShopSubImageTableView;
-(void)getShopUserInfo:(ShopUserInfo *)shop_user_info;
@end
