//
//  MyInformationTableViewCell.h
//  communityiOS
//
//  Created by 何茂馨 on 15/9/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ReadState;
@property (weak, nonatomic) IBOutlet UILabel *SendTime;
@property (weak, nonatomic) IBOutlet UILabel *InfoTitle;
@property (weak, nonatomic) IBOutlet UILabel *SendGroup;
@property (weak, nonatomic) NSString  *read_state;
@property (weak, nonatomic) NSString  *send_time;
@property (weak, nonatomic) NSString  *info_title;
@property (weak, nonatomic) NSString  *send_group;
@end
