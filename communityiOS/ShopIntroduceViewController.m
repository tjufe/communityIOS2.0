//
//  ShopIntroduceViewController.m
//  communityiOS
//
//  Created by tjufe on 15/12/14.
//  Copyright © 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "ShopIntroduceViewController.h"
#import "ShopIntroCommListTableViewCell.h"
#import "ShopIntroMainImageTableViewCell.h"
#import "ShopIntroShopAddressTableViewCell.h"
#import "ShopIntroShopIntroTableViewCell.h"
#import "ShopIntroShopNameTableViewCell.h"
#import "ShopIntroSuggestImageTableViewCell.h"
#import "ShopIntroShopNoticeTableViewCell.h"
#import "ShopIntroTelephoneTableViewCell.h"
#import "ShopSubImageViewController.h"
#import "ViewController4Food.h"

#import "UIViewController+Create.h"

@interface ShopIntroduceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong ,nonatomic)ShopUserInfo *shop_user_info;
@property(strong,nonatomic)ShopIntroMainImageTableViewCell *SIMainImageTVCell;
@property(strong,nonatomic)ShopIntroShopAddressTableViewCell *SISAddressTVCell;
@property(strong,nonatomic)ShopIntroShopIntroTableViewCell *SISIntroTVCell;
@property(strong,nonatomic)ShopIntroShopNameTableViewCell *SISNameTVCell;
@property(strong,nonatomic)ShopIntroSuggestImageTableViewCell *SISuggestImageTVCell;
@property(strong,nonatomic)ShopIntroCommListTableViewCell *SICommListTVCell;
@property(strong,nonatomic)ShopIntroShopNoticeTableViewCell *SISNoticeTVCell;
@property(strong,nonatomic)ShopIntroTelephoneTableViewCell *SITelephoneTVCell;
@end

@implementation ShopIntroduceViewController

float SISAddressTVCellheight = 0;
float SISIntroTVCellHeight = 0;
float SISNameTVCellHeight = 0;
float SISNoticeTVCellHeight = 0;

-(void)getShopUserInfo:(ShopUserInfo *)shop_user_info{
    self.shop_user_info = shop_user_info;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //商铺主图
    if (indexPath.row == 0 ) {
//        self.SIMainImageTVCell = [tableView dequeueReusableCellWithIdentifier:nil];
         self.SIMainImageTVCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!self.SIMainImageTVCell) {
            self.SIMainImageTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroMainImageTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.SIMainImageTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.SIMainImageTVCell setMainImage:self.shop_user_info.shop_icon];
        return self.SIMainImageTVCell;
    //商铺名称
    }else if(indexPath.row == 1){
//        self.SISNameTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
        self.SISNameTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.SISNameTVCell) {
            self.SISNameTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroShopNameTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.SISNameTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.SISNameTVCell.ShopName setText:self.shop_user_info.shop_user_name];
        [self.SISNameTVCell setShopmainpic:self.shop_user_info.shop_photo];
        //改变cell的高度需要reload该cell
            CGSize size = CGSizeMake(300, 1000);
            CGSize labelSize = [self.SISNameTVCell.ShopName.text sizeWithFont:self.SISNameTVCell.ShopName.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//            SISNameTVCellHeight = labelSize.height+10;
        CGRect rect = self.SISNameTVCell.frame;
        rect.size.height = labelSize.height;
        self.SISNameTVCell.frame = rect;
        NSLog(@"^^^^^^sisnameHeight%f",labelSize.height);
        return self.SISNameTVCell;
    //商铺介绍
    }else if (indexPath.row == 2){
//        self.SISIntroTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
        self.SISIntroTVCell =[tableView cellForRowAtIndexPath:indexPath];

        if (!self.SISIntroTVCell) {
            self.SISIntroTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroShopIntroTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.SISIntroTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
   
        [self.SISIntroTVCell.ShopIntroduce setText:self.shop_user_info.shop_desc];
        CGSize size = CGSizeMake(300, 1000);

            CGSize labelSize1 = [self.SISIntroTVCell.ShopIntroduce.text sizeWithFont:self.SISIntroTVCell.ShopIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
            SISIntroTVCellHeight = labelSize1.height+30;
        CGRect rect = self.SISIntroTVCell.frame;
        rect.size.height = labelSize1.height;
        self.SISIntroTVCell.frame = rect;
        NSLog(@"^^^^^^^^SISIntroTVCellHeight%f",labelSize1.height);
        return self.SISIntroTVCell;
    //商铺推荐图
    }else if (indexPath.row == 3){
//        self.SISuggestImageTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
         self.SISuggestImageTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.SISuggestImageTVCell) {
            self.SISuggestImageTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroSuggestImageTableViewCell" owner:nil options:nil]objectAtIndex:0];
            
        }
        return self.SISuggestImageTVCell;
    //商铺商品列表
    }else if (indexPath.row == 4){
//        self.SICommListTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
                self.SICommListTVCell =[tableView cellForRowAtIndexPath:indexPath];

        if (!self.SICommListTVCell) {
            self.SICommListTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroCommListTableViewCell" owner:nil options:nil]objectAtIndex:0];
        }
        return self.SICommListTVCell;
    //商铺公告
//    }else if (indexPath.row == 5){
////        self.SISNoticeTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
//         self.SISNoticeTVCell =[tableView cellForRowAtIndexPath:indexPath];
//        if (!self.SISNoticeTVCell) {
//            self.SISNoticeTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroShopNoticeTableViewCell" owner:nil options:nil]objectAtIndex:0];
//            self.SISNoticeTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        [self.SISNoticeTVCell.ShopNotice setText:self.shop_user_info.shop_notice];
//        CGSize size = CGSizeMake(300, 1500);
//
//        CGSize labelSize2 = [self.SISNoticeTVCell.ShopNotice.text sizeWithFont:self.SISNoticeTVCell.ShopNotice.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
////        SISNoticeTVCellHeight = labelSize2.height+60;
//        CGRect rect = self.SISNoticeTVCell.frame;
//        rect.size.height = labelSize2.height;
//        self.SISNoticeTVCell.frame = rect;
//        NSLog(@"^^^^^^^^SISNoticeTVCell%f",labelSize2.height);
//
//        return self.SISNoticeTVCell;
//    //商铺联系电话
    }
        else if (indexPath.row == 5){
//        self.SITelephoneTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
         self.SITelephoneTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.SITelephoneTVCell) {
            self.SITelephoneTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroTelephoneTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.SITelephoneTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.SITelephoneTVCell.ShopPhone setText:self.shop_user_info.shop_phone];
        return self.SITelephoneTVCell;
    //商铺地址
    }else{
//        self.SISAddressTVCell =[tableView dequeueReusableCellWithIdentifier:nil];
          self.SISAddressTVCell =[tableView cellForRowAtIndexPath:indexPath];
        if (!self.SISAddressTVCell) {
            self.SISAddressTVCell= [[[NSBundle mainBundle]loadNibNamed:@"ShopIntroShopAddressTableViewCell" owner:nil options:nil]objectAtIndex:0];
            self.SISAddressTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.SISAddressTVCell.ShopAddress setText:self.shop_user_info.shop_address];
         CGSize size = CGSizeMake(300, 1000);
        CGSize labelSize3 = [self.SISAddressTVCell.ShopAddress.text sizeWithFont:self.SISAddressTVCell.ShopAddress.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//        SISAddressTVCellheight = labelSize3.height+30;
        CGRect rect = self.SISAddressTVCell.frame;
        rect.size.height = labelSize3.height;
        self.SISNoticeTVCell.frame = rect;
        NSLog(@"^^^^^^^^SISAddressTVCell%f",labelSize3.height);
        return self.SISAddressTVCell;
    
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (indexPath.row == 0) {
        return 150;
    }else if (indexPath.row ==1){
        
        return self.SISNameTVCell.frame.size.height+20;
//        return 30;
    }else if (indexPath.row == 2){
        return self.SISIntroTVCell.frame.size.height+70;
//        return 30;
    }else if (indexPath.row ==3){
        return 40;
    }else if (indexPath.row == 4){
        return 40;
//    }else if (indexPath.row == 5){
////        return SISNoticeTVCellHeight;
//        return self.SISNoticeTVCell.frame.size.height+60;
    }else if (indexPath.row == 5){
        return 40;
    }else{
//        return SISAddressTVCellheight;
        return self.SISAddressTVCell.frame.size.height+30;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        ShopSubImageViewController *SSIVC = [ShopSubImageViewController createFromStoryboardName:@"ShopSubImage" withIdentifier:@"shop_sub_image"];
        [SSIVC getShopUserInfo:self.shop_user_info];
//        [self.SISuggestImageTVCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.navigationController pushViewController:SSIVC animated:YES];

    }else if (indexPath.row ==4){
            ViewController4Food *VC4F = [ViewController4Food createFromStoryboardName:@"CollectionView4Food" withIdentifier:@"CollectionView4Food"];
            [VC4F getShopID:self.shop_user_info.shop_user_id];
            [VC4F getShopName:self.shop_user_info.shop_user_name];
            [VC4F getShopIcon:self.shop_user_info.shop_photo];
        
            [VC4F getEstimateNum:self.shop_user_info.estimate_num];
            [VC4F getShopPhone:self.shop_user_info.shop_phone];
            [VC4F getShopNotice:self.shop_user_info.shop_notice];
            VC4F.shop_phone = self.shop_user_info.shop_phone;
//        [self.SICommListTVCell setSelectionStyle:UITableViewCellSelectionStyleNone];

            [self.navigationController pushViewController:VC4F  animated:YES];
    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.shop_user_info.shop_user_name;
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
//    [self changeCellHeight];
    //刷新tableview 更新高度
//    self.ShopIntroTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消下划线
//    [self.ShopIntroTableView reloadData];
}

//-(void)changeCellHeight{
//    //改变cell的高度需要reload该cell
//    CGSize size = CGSizeMake(300, 1000);
//    CGSize labelSize = [self.SISNameTVCell.ShopName.text sizeWithFont:self.SISNameTVCell.ShopName.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    SISNameTVCellHeight = labelSize.height+30;
//    CGSize labelSize1 = [self.SISIntroTVCell.ShopIntroduce.text sizeWithFont:self.SISIntroTVCell.ShopIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    SISIntroTVCellHeight = labelSize1.height+30;
//    CGSize labelSize2 = [self.SISNoticeTVCell.ShopNotice.text sizeWithFont:self.SISNoticeTVCell.ShopNotice.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    SISNoticeTVCellHeight = labelSize2.height+60;
//    CGSize labelSize3 = [self.SISAddressTVCell.ShopAddress.text sizeWithFont:self.SISAddressTVCell.ShopAddress.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    SISAddressTVCellheight = labelSize3.height+30;
//    NSLog(@"%f",SISNoticeTVCellHeight);
//    NSLog(@"%f",SISIntroTVCellHeight);
//    NSLog(@"%f",SISAddressTVCellheight);
//    NSLog(@"%f",SISNameTVCellHeight);
//
//}

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
