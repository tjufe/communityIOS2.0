//
//  Detail4FoodViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "Detail4FoodViewController.h"
#import "CollectionViewCell4Food.h"
#import "UIViewController+Create.h"
#import "ViewController4Food.h"
#import "OrderDetailViewController.h"

#import "UIAlertView+Blocks.h"
@interface Detail4FoodViewController ()

@end

@implementation Detail4FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationItem.title = @"商品详情";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)IntoShopOnclick:(id)sender {
//    ViewController4Food *vc4f = [ViewController4Food createFromStoryboardName:@"CollectionView4Food" withIdentifier:@"CollectionView4Food"];
//    [self.navigationController pushViewController:vc4f animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)CallSellerOnclick:(id)sender {
    [UIAlertView showAlertViewWithTitle:@"卖家详情" message:@"卖家电话：13800003333" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
        
        ;
    } onCancel:^{

    }];
}


#pragma mark--跳到立即购买
- (IBAction)BuyNowOnclick:(id)sender {
    OrderDetailViewController *ODVC = [OrderDetailViewController createFromStoryboardName:@"OrderDetail" withIdentifier:@"order_detail"]
    ;
    [self.navigationController pushViewController:ODVC animated:YES];
}






@end
