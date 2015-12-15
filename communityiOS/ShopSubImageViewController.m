//
//  ShopSubImageViewController.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopSubImageViewController.h"
#import "ShopSubImageTableViewCell.h"
#import "ShopSubImageList.h"
#import "MBProgressHUD.h"


@interface ShopSubImageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSArray * pic_list;
@property(strong,nonatomic)ShopUserInfo * shop_user_info;

@end

@implementation ShopSubImageViewController

-(void)getShopUserInfo:(ShopUserInfo *)shop_user_info{
    
    self.shop_user_info = shop_user_info;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.pic_list count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopSubImageTableViewCell *SSITVC = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!SSITVC) {
        SSITVC =[[[NSBundle mainBundle] loadNibNamed:@"ShopSubImageTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    [SSITVC setShop_sub_image:[self.pic_list objectAtIndex:indexPath.row]];
    return SSITVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.shop_user_info.shop_user_name;
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    [self loadData];
}

-(void)loadData{
    [ShopSubImageList LoadShopSubImageWithShopID:self.shop_user_info.shop_user_id Success:^(id object) {
        //        self.pic_list = (NSArray *)object;
        if (object==nil) {
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有更多内容了！";
            [hud showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            }completionBlock:^{
                [hud removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }else{
            self.pic_list = (NSArray *)object;
            [self.ShopSubImageTableView reloadData];
        }
        
        
    } failurs:^(NSError *error) {
        NSLog(@"^^^^^^%@",error);
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
