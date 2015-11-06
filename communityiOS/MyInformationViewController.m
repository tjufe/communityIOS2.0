//
//  MyInformationViewController.m
//  communityiOS
//
//  Created by 何茂馨 on 15/9/18.
//  Copyright (c) 2015年 &#20309;&#33538;&#39336;. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyInformationTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "myInfoList.h"
#import "myInformation.h"
#import "StatusTool.h"
#import "DetailInformationViewController.h"
#import "UIViewController+Create.h"

@interface MyInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong ,nonatomic)NSMutableArray * MyInfoArray;
@property(strong ,nonatomic)NSMutableArray * MyInfoList;

@property(strong,nonatomic)MyInformationTableViewCell *MICell;
@property(strong,nonatomic)myInformation *my_info;

@property(weak,nonatomic)NSNumber *page;
@property(weak,nonatomic)NSNumber *rows;

@end

NSInteger page1 ;//页数
NSInteger rows1 ;//分页请求行数
BOOL FirstLoad = true ;//默认是第一次加载
BOOL UpFresh = false;//默认上拉刷新是否
BOOL BackFresh = false;//默认回退刷新是否


@implementation MyInformationViewController
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.MyInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    self.MICell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!self.MICell){
        self.MICell = [[[NSBundle mainBundle] loadNibNamed:@"MyInformationTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    //赋值
    myInformation *m_info = [self.MyInfoArray objectAtIndex:indexPath.row];
    [self.MICell setSend_group:m_info.group_name];
    [self.MICell setSend_time:m_info.send_time];
    [self.MICell setInfo_title:m_info.title];
    [self.MICell setRead_state:m_info.state];
    
    
    return self.MICell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     myInformation *m_info = [self.MyInfoArray objectAtIndex:indexPath.row];
    //wangyao暂时取消消息状态
//    [StatusTool statusToolChangeMessageStateWithMessage_id:m_info.message_id Success:^(id object) {
        DetailInformationViewController *DIVC = [DetailInformationViewController createFromStoryboardName:@"DetailInformation" withIdentifier:@"detail_information"];
        [DIVC getInfo:m_info];
        [self.navigationController pushViewController:DIVC animated:YES];
//    } failurs:^(NSError *error) {
//        
//    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyInfoArray = [[NSMutableArray alloc]init];
    self.MyInfoList = [[NSMutableArray alloc]init];
    page1 = 1;
    rows1 = 10;
    FirstLoad = true;
    //导航栏
    self.navigationItem.title = @"通知列表";
    UIBarButtonItem *temporaryBarButtonItem=[[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title=@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //设置上拉刷新
    
    [self setupRefresh];
//    [self loadData];
    
}
-(void)setupRefresh{
    //waring自动刷新
    //   [self.pltable headerBeginRefreshing];
    //上拉加载更多
    [self.MyInformationTableView addFooterWithTarget:self action:@selector(footerReresh21)];
}
-(void)footerReresh21{
    
    page1++;
    UpFresh = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self loadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.MyInformationTableView footerEndRefreshing];
    });
    
}

-(void)loadData{
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.page = [NSNumber numberWithInteger:page1];
    self.rows = [NSNumber numberWithInteger:rows1];
    NSLog(@"^^^^^^^%@",[defaults objectForKey:@"UserID"] );
    [myInfoList LoadGroupMessageListWithUserID:[defaults objectForKey:@"UserID"] page:self.page rows:self.rows Success:^(id object) {
        self.MyInfoList = (NSMutableArray *)object;
        
        if(self.MyInfoList.count!=0&&self.MyInfoList!=nil){
            //回退刷新
            if (BackFresh) {
                [self.MyInfoArray removeAllObjects];
                for (int i=0; i<[self.MyInfoList count]; i++) {
                    self.my_info = [self.MyInfoList objectAtIndex:i];
                    
                    
                        [self.MyInfoArray addObject:self.my_info];
                    
                }

            }else{
                for (int i=0; i<[self.MyInfoList count]; i++) {
                    self.my_info = [self.MyInfoList objectAtIndex:i];
                    if(FirstLoad){//第一次加载
                        [self.MyInfoArray addObject:self.my_info];
                    
                    
                    }else if(UpFresh){ //上拉刷新
                        if(![self.MyInfoArray containsObject:self.my_info]){//去重
                            [self.MyInfoArray addObject:self.my_info];
                            }
                    }else{
                        [self.MyInfoArray removeAllObjects];
                        [self.MyInfoArray addObject:self.my_info];
                        }
                    }
                }
            FirstLoad = false;
            UpFresh = false;
            BackFresh =false;
            [self.MyInformationTableView reloadData];
        }else{
            if(FirstLoad){
                //    self.table.hidden = YES;
                [self.MyInformationTableView reloadData];
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
    
}

-(void)viewWillAppear:(BOOL)animated{
    BackFresh = true;
    [self loadData];


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
