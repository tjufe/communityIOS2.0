//
//  DetailInformationViewController.h
//  communityiOS
//
//  Created by tjufe on 15/9/22.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myInformation.h"

@interface DetailInformationViewController : UIViewController

-(void)getInfo:(myInformation *)my_info;
@property (weak, nonatomic) IBOutlet UILabel *InformationTitle;
@property (weak, nonatomic) IBOutlet UILabel *GroupName;
@property (weak, nonatomic) IBOutlet UITableView *DetailInformationTableView;
    
@end
