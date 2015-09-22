//
//  MoreCommPicViewController.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/16.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityInfo.h"

@interface MoreCommPicViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *MCPtableView;

-(void)getCommInfo:(CommodityInfo *)comm_info;

@end
