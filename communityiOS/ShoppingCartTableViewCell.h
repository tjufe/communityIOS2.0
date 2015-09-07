//
//  ShoppingCartTableViewCell.h
//  communityiOS
//
//  Created by tjufe on 15/6/17.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingCartTableViewCellDelegate <NSObject>

-(void)selectCommInSection:(UITableViewCell *)cell;//选中整个section商品

@end

@interface ShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_select_shop;
@property (weak, nonatomic) IBOutlet UILabel *label_shop_name;
//是否选中标识
@property (assign,nonatomic) int sel_status;
@property (assign)id <ShoppingCartTableViewCellDelegate>delegate;

@end
