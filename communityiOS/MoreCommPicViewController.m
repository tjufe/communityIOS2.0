//
//  MoreCommPicViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/16.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MoreCommPicViewController.h"
#import "MoreCommPicList.h"
#import "MoreCommPicTableViewCell.h"
#import "MBProgressHUD.h"

@interface MoreCommPicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)CommodityInfo * comm_info;
@property(strong,nonatomic)NSArray * pic_list;

@end

@implementation MoreCommPicViewController

-(void)getCommInfo:(CommodityInfo *)comm_info{

    self.comm_info = comm_info;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.pic_list count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreCommPicTableViewCell *MCPCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!MCPCell) {
        MCPCell =[[[NSBundle mainBundle] loadNibNamed:@"MoreCommPicTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    [MCPCell setMore_comm_pic:[self.pic_list objectAtIndex:indexPath.row]];
    return MCPCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.comm_info.comm_name;
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    
    [self loadData];
}

-(void)loadData{
    [MoreCommPicList LoadMoreCommPicWithCommID:self.comm_info.commodity_id Success:^(id object) {
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
            [self.MCPtableView reloadData];
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
