//
//  ShopIntroMainImageTableViewCell.h
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopIntroMainImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ShopIcon;//其实是商品介绍图
-(void)setMainImage:(NSString *)main_image_url;

@end
