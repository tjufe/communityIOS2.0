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

#import "ShoppingCartViewController.h"
#import "String.h"
#import "ShoppingCartCommodity.h"

@interface Detail4FoodViewController ()

@end

@implementation Detail4FoodViewController


-(void)getCommodityInfo:(id)comm_info{
    self.comm_info = (CommodityInfo *)comm_info;


}

#pragma mark----添加商品到购物车---- lx
- (IBAction)addShoppingCart:(id)sender {
    
    ShoppingCartCommodity *newfood = [[ShoppingCartCommodity alloc]init];
    newfood.commodity_id = _comm_info.commodity_id;
    newfood.comm_name = _comm_info.comm_name;
    newfood.comm_photo = _comm_info.comm_photo;
    newfood.comm_price = _comm_info.comm_price;
    newfood.comm_unit = _comm_info.comm_unit;
    newfood.shop_id = _comm_info.shop_id;
    newfood.shop_name = _shop_name;
    newfood.shop_phone = _shop_phone;
    newfood.buy_amount=1;
    newfood.select_status = 0;
    
    //获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *file_path = [documentDirectory stringByAppendingPathComponent:
                      ShoppingCartFile];
    //接档，读取文件数据
    NSMutableArray *cart = [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
    
    if(cart && [cart count]>0){//购物车不为空
        for(int i=0;i<[cart count];i++){
            NSMutableArray *comm_array = [cart objectAtIndex:i];
            if([comm_array containsObject:newfood]){
                for(int j=0;j<[comm_array count];j++){
                    ShoppingCartCommodity *s = [comm_array objectAtIndex:j];
                    if(s.commodity_id == newfood.commodity_id){//找到同一商品
                        newfood.buy_amount=s.buy_amount+1;
                        [comm_array removeObject:s];
                        [comm_array addObject:newfood];
                        NSMutableArray *comm_array2 = [NSMutableArray arrayWithArray:comm_array];
                        [cart removeObject:comm_array];
                        [cart addObject:comm_array2];
                        break;
                    }
                }
            }else{
               ShoppingCartCommodity *s = [comm_array objectAtIndex:0];
               if(s.shop_id==newfood.shop_id){//同一商家
                   [comm_array addObject:newfood];
                   NSMutableArray *comm_array2 = [NSMutableArray arrayWithArray:comm_array];
                   [cart removeObject:comm_array];
                   [cart addObject:comm_array2];
               }
            
            }
        }
        
    }else{//购物车为空
        NSMutableArray *comm_array = [[NSMutableArray alloc]init];
        [comm_array addObject:newfood];
        [cart addObject:comm_array];
        
        
    }
    
    //先删除归档
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isDeletableFileAtPath:file_path]){
        [fileManager removeItemAtPath:file_path error:nil];
    }
    //再重新添加,保存归档
    bool flag =[NSKeyedArchiver archiveRootObject:cart toFile:file_path];
    if(flag){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已添加到购物车" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
                              
    }

    
}


#pragma mark----跳转到购物车页-----  lx
- (IBAction)go2ShoppingCart:(id)sender {
    
    ShoppingCartViewController *SCVC = [ShoppingCartViewController createFromStoryboardName:@"ShoppingCart" withIdentifier:@"ShoppingCart"];
    [self.navigationController pushViewController:SCVC animated:YES];

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
