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
#import "CommodityInfo.h"
#import "CommSales.h"

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "StatusTool.h"

@interface Detail4FoodViewController ()
@property (strong,nonatomic)CommodityInfo *comm_info;

@end

@implementation Detail4FoodViewController

-(void)getCommodityInfo:(id)comm_info{
    self.comm_info = (CommodityInfo *)comm_info;


}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    //导航栏
    self.navigationItem.title = @"商品详情";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //赋值
    [self setValues];
    //调用网络接口获取销量
    [StatusTool statusToolGetCommSalesWithComm_id:self.comm_info.commodity_id Success:^(id object) {
        CommSales *comm_sales = (CommSales *)object;
        [self.CommSales setText:[NSString stringWithFormat:@"%d",comm_sales.comm_sales]];
    } failurs:^(NSError *error) {
        NSLog(@"fail to get comm sales");
    }];
    
//    NSLog(@"~~~~~~");
    
    
    
}

-(void)setValues{
    [self.CommName setText:self.comm_info.comm_name];
    [self.CommDescribe setText:self.comm_info.comm_desc];
    [self.CommPrice setText:[NSString stringWithFormat:@"%.2f",self.comm_info.comm_price]];
    if(![self.comm_info.comm_photo isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,self.comm_info.comm_photo];
        
        [self.CommImage sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            self.CommImage.image = image;
            
        }];
    }else{
        
        self.CommImage.image = [UIImage imageNamed:@"商家小图"];
        
    }
    
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
