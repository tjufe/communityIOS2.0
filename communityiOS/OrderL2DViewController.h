//
//  OrderL2DViewController.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/15.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
@interface OrderL2DViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *OL2DTableView;

-(void)getOrderInfo:(OrderInfo *)order_info;

@end
