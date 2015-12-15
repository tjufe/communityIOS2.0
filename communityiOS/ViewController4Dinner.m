//
//  ViewController4Dinner.m
//  communityiOS
//
//  Created by 何茂馨 on 15/6/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ViewController4Dinner.h"
#import "CollectionViewCell4Dinner.h"
#import "ShopUserList.h"
#import "ShopUserInfo.h"
#import "ShoppingCartViewController.h"
#import "UIViewController+Create.h"
#import "ViewController4Food.h"
#import "ShopUserInfo.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ShopIntroduceViewController.h"

@interface ViewController4Dinner ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview4dinner;
@property(strong ,nonatomic)CollectionViewCell4Dinner *cell4dinner;
@property (strong,nonatomic)NSMutableArray *ShopList;
@property (strong,nonatomic)ShopUserInfo *shop_user_info;

@property(weak,nonatomic)NSNumber *page;
@property(weak,nonatomic)NSNumber *rows;

@end

NSInteger page1 ;//页数
NSInteger rows1 ;//分页请求行数
BOOL FirstLoad ;

@implementation ViewController4Dinner



#pragma mark-----跳转到购物车结算页面
- (IBAction)Go2ShoppingCart:(id)sender {
    
     ShoppingCartViewController *SCVC = [ShoppingCartViewController createFromStoryboardName:@"ShoppingCart" withIdentifier:@"ShoppingCart"];
    [self.navigationController pushViewController:SCVC animated:YES];
}


#pragma mark------获取商家列表
+(NSMutableArray *)getShopList{
    
    return shopListArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [shopListArray count];
    

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    CollectionViewCell4Dinner *cell = [[CollectionViewCell4Dinner alloc]init];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4dinner" forIndexPath:indexPath];
    
    
    
    
    if(shopListArray!=nil){
        ShopUserInfo *shop_user_info = [shopListArray objectAtIndex:indexPath.row];
        [cell setShopintroduce:shop_user_info.shop_desc];
        [cell setShopname:shop_user_info.shop_user_name];
        [cell setShopmainpic:shop_user_info.shop_photo];
        [cell setFoodnum:[NSString stringWithFormat:@"%d",shop_user_info.commodity_num]];
        [cell setReplynum:[NSString stringWithFormat:@"%d",shop_user_info.estimate_num]];
    }
    
    
    return cell;

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopUserInfo *shop_user_info = [shopListArray objectAtIndex:indexPath.row];
    ShopIntroduceViewController *SIVC = [ShopIntroduceViewController createFromStoryboardName:@"ShopIntroduce" withIdentifier:@"shop_introduce"];
    [SIVC getShopUserInfo:shop_user_info];
    [self.navigationController pushViewController:SIVC animated:YES];
//    ViewController4Food *VC4F = [ViewController4Food createFromStoryboardName:@"CollectionView4Food" withIdentifier:@"CollectionView4Food"];
//    [VC4F getShopID:shop_user_info.shop_user_id];
//    [VC4F getShopName:shop_user_info.shop_user_name];
//    [VC4F getShopIcon:shop_user_info.shop_photo];
//
//    [VC4F getEstimateNum:shop_user_info.estimate_num];
//    [VC4F getShopPhone:shop_user_info.shop_phone];
//    [VC4F getShopNotice:shop_user_info.shop_notice];
//    VC4F.shop_phone = shop_user_info.shop_phone;

//    [self.navigationController pushViewController:VC4F  animated:YES];
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ShopList = [[NSMutableArray alloc]init];
    shopListArray = [[NSMutableArray alloc]init];
    page1 = 1;
    rows1 = 10;
    FirstLoad = true;
    
//    self.ShopList = [[NSMutableArray alloc]init];
    //wangyao 0624  设定collectionview的布局形式，来设定行间距，item间距，以及item的size大小！
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc]init];
    flow_layout.minimumLineSpacing = 1;
    flow_layout.minimumInteritemSpacing = 1;
    
    [flow_layout setItemSize:CGSizeMake(self.view.frame.size.width/2-0.5, 250)];
    
    _collectionview4dinner.collectionViewLayout = flow_layout;
    
    
    [_collectionview4dinner registerNib:[UINib nibWithNibName:@"CollectionViewCell4Dinner" bundle:nil]forCellWithReuseIdentifier:@"cell4dinner" ];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    
//    [ShopUserList LoadShopUserListWithCommunityID:[defaults objectForKey:@"CommunityID"] page:[NSNumber numberWithInt:1] rows:[NSNumber numberWithInt:20] Success:^(id object) {
//        self.ShopList =(NSMutableArray *) object;
//        shopListArray = self.ShopList;
//        [self.collectionview4dinner reloadData];
//        
//   
//    } failurs:^(NSError *error) {
//        
//    }];
    self.navigationItem.title = @"外卖订餐";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    //设置上拉刷新
    
    [self setupRefresh];
    [self loadData];
    

}

-(void)setupRefresh{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.collectionview4dinner addFooterWithTarget:self action:@selector(footerRereshing1)];
}
-(void)footerRereshing1{

    page1++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionview4dinner footerEndRefreshing];
    });
    
}

-(void)loadData{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.page = [NSNumber numberWithInteger:page1];
    self.rows = [NSNumber numberWithInteger:rows1];
    
    [ShopUserList LoadShopUserListWithCommunityID:[defaults objectForKey:@"CommunityID"] page:self.page rows:self.rows Success:^(id object) {
        self.ShopList =(NSMutableArray *) object;
        
        
        if(self.ShopList!=nil){
            
            for (int i=0; i<[self.ShopList count]; i++) {
                self.shop_user_info = [self.ShopList objectAtIndex:i];
                if(FirstLoad){//第一次加载
                    [shopListArray addObject:self.shop_user_info];
                    
                    
                }else{ //上拉刷新
                    if(![shopListArray containsObject:self.shop_user_info]){//去重
                        [shopListArray addObject:self.shop_user_info];
                    }
                }
            }
            FirstLoad = false;
            [self.collectionview4dinner reloadData];
        }else{
            if(FirstLoad){
                //    self.table.hidden = YES;
                [self.collectionview4dinner reloadData];
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
        NSLog(@"%@",error);
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
