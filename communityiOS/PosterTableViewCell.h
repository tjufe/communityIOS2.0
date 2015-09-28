//
//  PosterTableViewCell.h
//  communityiOS
//
//  Created by tjufe on 15/3/31.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postDate;

@property (weak, nonatomic) IBOutlet UILabel *posterNickname;
@property (weak, nonatomic) IBOutlet UIImageView *posterAuth;

@property (weak, nonatomic) IBOutlet UIImageView *headPortrait;

//wangyao 0922 重用postercell 用来显示消息信息
@property (weak, nonatomic) NSString  *send_date;
@property (weak, nonatomic) NSString  *member_name;
@property (weak, nonatomic) NSString  *member_head;

@end
