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

@interface ViewController4Dinner ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview4dinner;
@property(strong ,nonatomic)CollectionViewCell4Dinner *cell4dinner;
@property (strong,nonatomic)NSMutableArray *ShopList;

@end

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

    return [self.ShopList count];
    

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    CollectionViewCell4Dinner *cell = [[CollectionViewCell4Dinner alloc]init];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4dinner" forIndexPath:indexPath];
    
    
    
    
    if(self.ShopList!=nil){
        ShopUserInfo *shop_user_info = [self.ShopList objectAtIndex:indexPath.row];
        [cell setShopintroduce:shop_user_info.shop_desc];
        [cell setShopname:shop_user_info.shop_user_name];
        [cell setShopmainpic:shop_user_info.shop_photo];
        [cell setFoodnum:[NSString stringWithFormat:@"%d",shop_user_info.commodity_num]];
        [cell setReplynum:[NSString stringWithFormat:@"%d",shop_user_info.estimate_num]];
        
//        cell.frame.size = CGSizeMake(self.view.frame.size.width, 300);
        
        
        
    }
    
    
    return cell;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ShopList = [[NSMutableArray alloc]init];
    //wangyao 0624  设定collectionview的布局形式，来设定行间距，item间距，以及item的size大小！
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc]init];
    flow_layout.minimumLineSpacing = 1;
    flow_layout.minimumInteritemSpacing = 1;
    
    [flow_layout setItemSize:CGSizeMake(self.view.frame.size.width/2-0.5, 250)];
    
    _collectionview4dinner.collectionViewLayout = flow_layout;
    
    
    // Do any additional setup after loading the view.
    // Register cell classes
//    [_collectionview4dinner registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell4dinner"];
    [_collectionview4dinner registerNib:[UINib nibWithNibName:@"CollectionViewCell4Dinner" bundle:nil]forCellWithReuseIdentifier:@"cell4dinner" ];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [ShopUserList LoadShopUserListWithCommunityID:[defaults objectForKey:@"CommunityID"] page:[NSNumber numberWithInt:1] rows:[NSNumber numberWithInt:20] Success:^(id object) {
        self.ShopList =(NSMutableArray *) object;
        shopListArray = self.ShopList;
        [self.collectionview4dinner reloadData];
        
   
    } failurs:^(NSError *error) {
        
    }];
    self.navigationItem.title = @"外卖订餐";
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

@end
