//
//  ViewController4Food.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/24.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ViewController4Food.h"
#import "CollectionViewCell4Food.h"
#import "CommodityInfo.h"
#import "CommodityList.h"
#import "Detail4FoodViewController.h"
#import "UIViewController+Create.h"
#import "UIImageView+WebCache.h"//加载图片
#import "APIAddress.h"
#import "ShoppingCartViewController.h"
#import "AppDelegate.h"
#import "EstimateListViewController.h"
#import "UIAlertView+Blocks.h"

#import "MJRefresh.h"

#import "MBProgressHUD.h"

@interface ViewController4Food ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView4Food;
@property(strong,nonatomic) NSMutableArray *comm_list;
@property(strong,nonatomic) NSString *shop_id;
@property(strong,nonatomic) NSString *shop_name;
@property(strong,nonatomic) NSString *shop_icon_url;
@property(strong,nonatomic) NSString *shop_notice;
@property(assign,nonatomic) int estimate_num;
@property(weak,nonatomic)NSNumber *page;
@property(weak,nonatomic)NSNumber *rows;
@property (strong,nonatomic)CommodityInfo *comm_info;

@property(strong,nonatomic)NSMutableArray *commlistArray;

@end
NSInteger page1 ;//页数
NSInteger rows1 ;//分页请求行数
BOOL FirstLoad ;

@implementation ViewController4Food

#pragma mark-----跳转购物车页面------
- (IBAction)go2ShoppingCart:(id)sender {
    
    ShoppingCartViewController *SCVC = [ShoppingCartViewController createFromStoryboardName:@"ShoppingCart" withIdentifier:@"ShoppingCart"];
    [self.navigationController pushViewController:SCVC animated:YES];
}

-(void)getShopName:(NSString *)shop_name{
    self.shop_name = shop_name;
    
}
-(void)getShopPhone:(NSString *)shop_phone{
    self.shop_phone = shop_phone;
    
}
-(void)getShopID:(NSString *) shop_id {
    self.shop_id = shop_id;
}

-(void)getShopIcon:(NSString *) shop_icon_url {
    self.shop_icon_url = shop_icon_url;
}
-(void)getEstimateNum:(int) estimate_num {
    self.estimate_num = estimate_num;
}

-(void)getShopNotice:(NSString *) shop_notice {
    self.shop_notice = shop_notice;
}

- (IBAction)ToEstimateListOnclick:(id)sender {
    EstimateListViewController *ELVC =  [EstimateListViewController createFromStoryboardName:@"EstimateList" withIdentifier:@"estimate_list"];
    [ELVC shopID:self.shop_id];
    [self.navigationController pushViewController:ELVC animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    暂时注释掉，改成静态数据wangyao 0828
    return [self.comm_list count];
 //   return 1;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell4Food *cell4food = [[CollectionViewCell4Food alloc]init];
    cell4food = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4food" forIndexPath:indexPath];


    if(self.comm_list!=nil){
        CommodityInfo *comm_info = [self.comm_list objectAtIndex:indexPath.row];
        [cell4food setComm_main_pic:comm_info.comm_photo];
        [cell4food setComm_name:comm_info.comm_name];
       [cell4food setComm_price:comm_info.comm_price];
        
    }
    
    
    return cell4food;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //传值
    CommodityInfo *comm_info = [self.comm_list objectAtIndex:indexPath.row];
    
    
    Detail4FoodViewController *DFVC = [Detail4FoodViewController createFromStoryboardName:@"Detail4Food" withIdentifier:@"detail4food"];

    
    [DFVC getCommodityInfo:comm_info];

    DFVC.shop_name = self.shop_name;
    DFVC.shop_phone = _shop_phone;
    [self.navigationController pushViewController:DFVC  animated:YES];


}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIAlertView showAlertViewWithTitle:@"卖家公告" message:self.shop_notice cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
        
        ;
    } onCancel:^{
        
    }];

    self.comm_list = [[NSMutableArray alloc]init];
    self.commlistArray = [[NSMutableArray alloc] init];
    page1 = 1;
    rows1 = 10;
    FirstLoad = true;
    //导航栏
    self.navigationItem.title = @"商品列表";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    


    
    //wangyao 0624  设定collectionview的布局形式，来设定行间距，item间距，以及item的size大小！
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc]init];
    flow_layout.minimumLineSpacing = 1;
    flow_layout.minimumInteritemSpacing = 1;
    

    [flow_layout setItemSize:CGSizeMake(self.view.frame.size.width/2-0.5, 300)];

    
    _collectionView4Food.collectionViewLayout = flow_layout;
    
    
    [_collectionView4Food registerNib:[UINib nibWithNibName:@"CollectionViewCell4Food" bundle:nil]forCellWithReuseIdentifier:@"cell4food" ];
    //赋值

    [self.ShopName setText:self.shop_name];
    
    [self.ReplyNum setText:[NSString stringWithFormat:@"%d",self.estimate_num]];
    
    if(![self.shop_icon_url isEqual:@""]&&self.shop_icon_url!=nil){
        NSString *url = [NSString stringWithFormat:@"%@/uploadimg/%@",API_HOST,self.shop_icon_url];
        
        [self.ShopIcon sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
           
            if(image!=nil){
                    self.ShopIcon.image = image;
            }else{
                 self.ShopIcon.image = [UIImage imageNamed:@"默认小头像"];
            
            }
            
        }];
    }else{
        
        self.ShopIcon.image = [UIImage imageNamed:@"默认小头像"];
        
    }
    [self.ShopIcon.layer setCornerRadius:self.ShopIcon.layer.frame.size.height/2];
    self.ShopIcon.contentMode=UIViewContentModeScaleAspectFill;
    self.ShopIcon.layer.masksToBounds = YES;
    
    //设置上拉刷新
    
    [self setupRefresh];
    [self loadData];
    
    
    
}

-(void)setupRefresh{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.collectionView4Food addFooterWithTarget:self action:@selector(footerReresh)];
}

-(void)footerReresh{
    
    page1++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView4Food footerEndRefreshing];
    });
    
}

-(void)loadData{
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.page = [NSNumber numberWithInteger:page1];
    self.rows = [NSNumber numberWithInteger:rows1];
    [CommodityList LoadCommodityListWithShopID:self.shop_id page:[NSNumber numberWithInt:1] rows:[NSNumber numberWithInt:20] Success:^(id object) {
        self.comm_list = (NSMutableArray *)object;
        
        if(self.comm_list!=nil){
            
            for (int i=0; i<[self.comm_list count]; i++) {
                self.comm_info = [self.comm_list objectAtIndex:i];
                if(FirstLoad){//第一次加载
                    [self.commlistArray addObject:self.comm_info];
                    
                    
                }else{ //上拉刷新
                    if(![self.commlistArray containsObject:self.comm_info]){//去重
                        [self.commlistArray addObject:self.comm_info];
                    }
                }
            }
            FirstLoad = false;
            [self.collectionView4Food reloadData];
        }else{
            if(FirstLoad){
                //    self.table.hidden = YES;
                [self.collectionView4Food reloadData];
            }else{//刷新完成，已无更多
                page1--;
                //提示
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                [self.view addSubview:hud];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"没有更多内容了！";
                [hud showAnimated:YES whileExecutingBlock:^{
                    sleep(1);
                }completionBlock:^{
                    [hud removeFromSuperview];
                }];
                
                
            }
        }

    } failurs:^(NSError *error) {
        
    }];

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

@end
