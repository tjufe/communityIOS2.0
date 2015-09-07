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

#import "AppDelegate.h"

@interface ViewController4Food ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView4Food;
@property(strong,nonatomic) NSMutableArray *comm_list;
@property(strong,nonatomic) NSString *shop_id;
@property(strong,nonatomic) NSString *shop_name;
@property(strong,nonatomic) NSString *shop_icon_url;
@end

@implementation ViewController4Food

-(void)getShopName:(NSString *)shop_name{
    self.shop_name = shop_name;
    
}
-(void)getShopID:(NSString *) shop_id {
    self.shop_id = shop_id;
}

-(void)getShopIcon:(NSString *) shop_icon_url {
    self.shop_icon_url = shop_icon_url;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //暂时注释掉，改成静态数据wangyao 0828
//    return [self.comm_list count];
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell4Food *cell4food = [[CollectionViewCell4Food alloc]init];
    cell4food = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell4food" forIndexPath:indexPath];
     //暂时注释掉，改成静态数据 wangyao 0828
//    if(self.comm_list!=nil){
//        CommodityInfo *comm_info = [self.comm_list objectAtIndex:indexPath.row];
//        [cell4food setComm_main_pic:comm_info.comm_photo];
//        [cell4food setComm_name:comm_info.comm_name];
//        [cell4food setComm_price:comm_info.comm_price];
//    }
    
    
    return cell4food;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Detail4FoodViewController *DFVC = [Detail4FoodViewController createFromStoryboardName:@"Detail4Food" withIdentifier:@"detail4food"];
    [self.navigationController pushViewController:DFVC  animated:YES];


}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.navigationItem.title = @"商品列表";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    self.comm_list = [[NSMutableArray alloc]init];
    //wangyao 0624  设定collectionview的布局形式，来设定行间距，item间距，以及item的size大小！
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc]init];
    flow_layout.minimumLineSpacing = 1;
    flow_layout.minimumInteritemSpacing = 1;
    
    [flow_layout setItemSize:CGSizeMake(self.view.frame.size.width/2-0.5, 300)];
    
    _collectionView4Food.collectionViewLayout = flow_layout;
    
    
    [_collectionView4Food registerNib:[UINib nibWithNibName:@"CollectionViewCell4Food" bundle:nil]forCellWithReuseIdentifier:@"cell4food" ];
    
    [self.ShopName setText:self.shop_name];
    
    if(![self.shop_icon_url isEqual:@""]){
        NSString *url = [NSString stringWithFormat:@"%@/topicpic/%@",API_HOST,self.shop_icon_url];
        
        [self.ShopIcon sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//加载图片
            
            self.ShopIcon.image = image;
            
        }];
    }else{
        
        self.ShopIcon.image = [UIImage imageNamed:@"吉祥馄饨"];
        
    }
    
    
    [CommodityList LoadCommodityListWithShopID:self.shop_id page:[NSNumber numberWithInt:1] rows:[NSNumber numberWithInt:20] Success:^(id object) {
        self.comm_list = (NSMutableArray *)object;
        [self.collectionView4Food reloadData];
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
